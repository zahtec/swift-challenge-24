import MapKit

// MARK: The custom renderer for offline map tiles
final class TileOverlay: MKTileOverlay {
	override func url(forTilePath path: MKTileOverlayPath) -> URL {
		Bundle.main.url(
			forResource: "\(path.z)-\(path.x)-\(path.y)",
			withExtension: "png"
		)!
	}
}

/*
 Since the Swift Student Challenge projects are run in an offline environment, a solution
 to provide a map in this environment was needed. To do so, a map tile dataset from https://www.maptiler.com/
 was downloaded and trimmed to the appropriate area. These tiles do not require a disclaimer of their
 source and are being correctly utilized in accordance with MapTiler's policy, which is quite lenient
 for personal/education projects such as this.
 */
