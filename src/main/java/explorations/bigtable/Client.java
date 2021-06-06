package explorations.bigtable;

import com.google.cloud.bigtable.data.v2.BigtableDataClient;
import com.google.cloud.bigtable.data.v2.models.Query;
import com.google.cloud.bigtable.data.v2.models.Row;
import com.google.cloud.bigtable.data.v2.models.RowCell;
//https://googleapis.dev/java/google-cloud-bigtable/latest/com/google/cloud/bigtable/data/v2/BigtableDataClient.h
tml
public class Client {
  public static void main(String[] args) throws Exception {
    System.out.println("Querying my-table rows!");
    BigtableDataClient client = BigtableDataClient.create("static-lens-314215", "bigtable-instance");
    for (Row row: client.readRows(Query.create("my-table"))) {
      // Do something with row
      for (RowCell cell: row.getCells()) {
        System.out.printf("Family: %s   Qualifier: %s   Value: %s", cell.getFamily(),
          cell.getQualifier().toStringUtf8(), cell.getValue().toStringUtf8());
      }
    }
    // Cleanup during application shutdown.
    client.close();
  }
}

