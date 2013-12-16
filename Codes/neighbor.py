from PyQt4.QtCore import *
from shapely.wkb import loads
# Replace the below value with the field containing name or id of the feature
# For example, if your field is called name then change the line below to
# name_filed = 'name'
name_field = 'UHFCODE'
# Replace the below value with the field name that you want to sum up
sum_field = 'PNTCNT'
layer = qgis.utils.iface.activeLayer()
layer.startEditing()
provider = layer.dataProvider()
# We add 2 attributes to the current layer
provider.addAttributes( [QgsField("Neighbors", QVariant.String),
                         QgsField("Sum", QVariant.Int)])
neighbor_name_index = provider.fieldNameIndex("Neighbors")
neighbor_sum_index = provider.fieldNameIndex("Sum")
allAttrs = provider.attributeIndexes()
# Select all features along with their attributes
provider.select(allAttrs)
feat = QgsFeature()
polygon_dict = {}
# Loop through all features and store their geometry and relevant attributes in
# a dictionary
while provider.nextFeature(feat):
  feature_id = feat.id()
  attrmap = feat.attributeMap()
  name = attrmap[provider.fieldNameIndex(name_field)].toString()
  sum_value = attrmap[provider.fieldNameIndex(sum_field)].toInt()[0]
  print 'Reading Geometry for %s' % name
  geom = feat.geometry()
  wkb = geom.asWkb()
  polygon = loads(wkb)
  polygon_dict[feature_id] = [ polygon, name, sum_value ]

# Now one-by-one take a feature and find all other features that touch its
# geometry
all_polygons = polygon_dict.keys()
attribute_dict = {}

for polygon_id in all_polygons:
  this_polygon, this_name, this_sum = polygon_dict[polygon_id]
  neighbor_list = []
  sum_of_neighbors = 0

  for polygon_id_compare in all_polygons:
    compare_polygon, compare_name, compare_sum = polygon_dict[polygon_id_compare]
    if this_polygon.touches(compare_polygon):
      neighbor_list.append(unicode(compare_name))
      sum_of_neighbors += compare_sum

  # Make a list of all neighbors' names
  neighbor_string = ','.join(neighbor_list)
  attribute_dict[polygon_id] = {neighbor_name_index: QVariant(neighbor_string),
                                neighbor_sum_index: QVariant(sum_of_neighbors)}

# Update the attribute table
provider.changeAttributeValues(attribute_dict)
layer.commitChanges()
layer.stopEditing()
