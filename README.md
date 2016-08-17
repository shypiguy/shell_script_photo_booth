# shell_script_photo_booth
Simple Raspberry Pi Photo Booth in shell script

This shell script assumes you have wired to your Raspberry Pi the following:
* a gphoto2 supported digital camera (script is set up for a Canon EOS 5D) connected to the USB port
* two sets of LED lights, one set attached to the camera to blink and get the subjects attention before capturing images, and another to signal that the photo booth is ready to capture another set of images
* a momentary (normally open) switch to start the image capture process. I used an iluminated momentary switch using it's light as the "ready" light

This shell script further assumes that the desired output is three images taken one second apart, composited with a vertical logo on the right of the composite image. I have included sample output images.

To run the photobooth, you must be connected to the raspberry pi to execute the "gen_serial.sh" script with super user access. ex: sudo ./gen_serial.sh

This main script sets up the GPIO inputs/outputs and starts the photo capture sequence when the momentary button is pressed. It flashes the led lights on the camera to get the subject's attention and then instructs gphoto2 to capture three images with a 1 second delay between captures. Then it downloads the three images and deletes them from the camera. Finally, it spawns a nohup process to prepare the composite image in the background so the main script can get back to the business of taking pictures without having to wait around for the images to be processed.

The background script in this example composites the three images with a vertical logo and then initiaties an upload of the final image to dropbox using Andrea Fabrizi's excellen dropbox_uploader shell script which is not provided here.
