package examples.albums;

import com.intuit.karate.junit5.Karate;

class AlbumsRunner {
    
    @Karate.Test
    Karate testAlbums() {
        return Karate.run("albums").relativeTo(getClass());
    }    

}