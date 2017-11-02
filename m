From: Ivid Suvarna <ivid.suvarna@gmail.com>
Subject: USB is not resumed(disconnected) after suspend to disk
Date: Thu, 2 Nov 2017 10:19:44 +0530
Message-ID: <CABXF_ACakK+zYQQW6OuzJbCqq0k3WGtGhRds8YjU8nn21fAEuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "ivid.suvarna" <ivid.suvarna@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi all,

I am trying to support suspend to disk(hibernate) on Hikey with 4.4
kernel. During suspend, I could see the usb devices getting reset and I
can access them properly. Message can be seen as below:

usb 1-1: reset high-speed USB device number 2 using dwc2
usb 1-1.2: reset high-speed USB device number 3 using dwc2
usb 1-1.2.4: reset high-speed USB device number 4 using dwc2


But after resume, usb gets disconnected and I could not access it
anymore:

usb 1-1: USB disconnect, device number 2
usb 1-1.2: USB disconnect, device number 3
usb 1-1.2.4: USB disconnect, device number 4

However "dwc2 f72c0000.usb" gets setup properly. I guess it is OTG. I
have connected only keyboard to USB Type-A. OTG is not connected.

Is the dwc2_suspend() and dwc2_resume() functions support only suspend
to mem? Is there any hack such that we can forcefully reset the
USB(dwc2) on resume in dwc2_resume() code path. I tried adding
usb_reset_device() to dwc2_resume() path but that gave a panic as
expected. I tried to skip suspend in dwc2_suspend(), but still the usb
disconnects.

I added "dwc2_lowlevel_hw_init" to resume path just to check but still
no use. Is the power to hub lost or clock is not set properly or
something because I could not understand what is the problem.

Below is some more dmesg log:

ivid@ivid:~# dmesg | grep usb
[    0.408019] usbcore: registered new interface driver usbfs
[    0.408099] usbcore: registered new interface driver hub
[    0.408224] usbcore: registered new device driver usb
[    0.486321] usbcore: registered new interface driver asix
[    0.486403] usbcore: registered new interface driver ax88179_178a
[    0.486583] dwc2 f72c0000.usb: Configuration mismatch. Forcing host
mode
[    0.487491] usbcore: registered new interface driver usb-storage
[    0.581006] usbcore: registered new interface driver usbhid
[    0.581052] usbhid: USB HID core driver
[    2.054331] dwc2 f72c0000.usb: Configuration mismatch. Forcing host
mode
[    2.059779] f72c0000.usb supply vusb_d not found, using dummy
regulator
[    2.065133] f72c0000.usb supply vusb_a not found, using dummy
regulator
[    2.939845] dwc2 f72c0000.usb: DWC OTG Controller
[    2.943587] dwc2 f72c0000.usb: new USB bus registered, assigned bus
number 1
[    2.951537] dwc2 f72c0000.usb: irq 37, io mem 0x00000000
[    3.342725] usb 1-1: new high-speed USB device number 2 using dwc2

Below are some additional debug logs.

* During suspend:

dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -104
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -2
dwc2 f72c0000.usb: DWC OTG HCD URB Dequeue
dwc2 f72c0000.usb: Called usb_hcd_giveback_urb()
dwc2 f72c0000.usb:   urb->status = -2

* During resume:

dwc2 f72c0000.usb: ClearPortFeature USB_PORT_FEAT_ENABLE
usb 1-1: USB disconnect, device number 2
done.
usb 1-1.2: USB disconnect, device number 3
asix 1-1.2:1.0 eth0: unregister 'asix' usb-f72c0000.usb-1.2, ASIX
AX88772 USB 2.0 Ethernet
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x00,
ep->hcpriv=ffffffc02ee7d900
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x00,
ep->hcpriv=          (null)
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x81,
ep->hcpriv=ffffffc02e823f00
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x82,
ep->hcpriv=ffffffc02e827e00
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x03,
ep->hcpriv=ffffffc02eeb7800
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x00,
ep->hcpriv=ffffffc02e827000
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x00,
ep->hcpriv=          (null)
dwc2 f72c0000.usb: DWC OTG HCD EP DISABLE: bEndpointAddress=0x81,
ep->hcpriv=ffffffc02ee7d800
dwc2 f72c0000.usb: SetPortFeature
dwc2 f72c0000.usb: SetPortFeature - USB_PORT_FEAT_POWER

* I changed the hibernation default value to 1 in
"drivers/usb/dwc2/platform.c" in params_hi6220 since hibernation by
default is disabled, but no use.

Thanks,
Ivid
