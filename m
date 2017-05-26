From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Bug: sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware
 interrupt.
Date: Fri, 26 May 2017 17:50:40 +0200 (CEST)
Message-ID: <433605218.311867.1495813840749@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

i noticed that the RPI2 with next-20170526 and bcm2835_defconfig doesn't boot from SD card [1]. At least i was able to fix the NULL pointer dereference [2]. Now i'm getting the output see below. I try to narrow this down, but maybe someone already has an idea.

Regards
Stefan

[1] - https://storage.kernelci.org/next/master/next-20170526/arm/bcm2835_defconfig/lab-collabora/boot-bcm2836-rpi-2-b.txt
[2] - https://github.com/lategoodbye/rpi-zero/commit/ff0b8c7e3f6a4d1b6dfe99710fa9ee333e2b8886

[    0.328506] sdhci: Secure Digital Host Controller Interface driver
[    0.330949] sdhci: Copyright(c) Pierre Ossman
[    0.471038] sdhost-bcm2835 3f202000.mmc: loaded - DMA enabled (>1)
[    0.473582] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.476764] ledtrig-cpu: registered to indicate activity on CPUs
[    0.479552] usbcore: registered new interface driver usbhid
[    0.481930] usbhid: USB HID core driver
[    0.484411] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
[    0.488231] oprofile: using timer interrupt.
[    0.492227] NET: Registered protocol family 10
[    0.496233] Segment Routing with IPv6
[    0.498773] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.502518] NET: Registered protocol family 17
[    0.510802] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 87, base_baud = 0) is a PL011 rev2
[    0.852460] mmc0: host does not support reading read-only switch, assuming write-enable
[    0.860971] mmc0: new high speed SDHC card at address 0001
[    0.875465] mmcblk0: mmc0:0001 00000 29.8 GiB
[    1.397285] console [ttyAMA0] enabled
[    1.406137] raspberrypi-firmware soc:firmware: Attached to firmware from 2017-04-27 17:19
[    1.423787] vc4_hdmi 3f902000.hdmi: vc4-hdmi-hifi <-> 3f902000.hdmi mapping ok
[    1.434811]  mmcblk0: p1 p2
[    1.441932] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops)
[    1.452869] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops)
[    1.462502] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops)
[    1.472183] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops vc4_crtc_ops)
[    1.482493] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops vc4_crtc_ops)
[    1.492658] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops vc4_crtc_ops)
[    1.502596] cma: cma_alloc: alloc failed, req-size: 4096 pages, ret: -12
[    1.512404] vc4-drm soc:gpu: failed to allocate buffer with size 16777216
[    1.522337] cma: cma_alloc: alloc failed, req-size: 4096 pages, ret: -12
[    1.532182] vc4-drm soc:gpu: failed to allocate buffer with size 16777216
[    1.542155] [drm:vc4_bo_create] *ERROR* Failed to allocate from CMA:
[    1.551681] [drm] num bos allocated: 0
[    1.558530] [drm] size bos allocated: 0kb
[    1.565612] [drm] num bos used: 0
[    1.571938] [drm] size bos used: 0kb
[    1.578483] [drm] num bos cached: 0
[    1.584922] [drm] size bos cached: 0kb
[    1.591580] vc4_v3d 3fc00000.v3d: Failed to allocate memory for tile binning: -12. You may need to enable CMA or give it more memory.
[    1.609589] vc4-drm soc:gpu: failed to bind 3fc00000.v3d (ops vc4_v3d_ops): -12
[    1.621480] vc4-drm soc:gpu: master bind failed: -12
[    1.629515] vc4_v3d: probe of 3fc00000.v3d failed with error -12
[    1.715334] dwc2 3f980000.usb: DWC OTG Controller
[    1.723064] dwc2 3f980000.usb: new USB bus registered, assigned bus number 1
[    1.733085] dwc2 3f980000.usb: irq 39, io mem 0x3f980000
[    1.742503] hub 1-0:1.0: USB hub found
[    1.749074] hub 1-0:1.0: 1 port detected
[    1.756656] ALSA device list:
[    1.762420]   No soundcards found.
[    1.798146] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    1.812372] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[    1.830538] devtmpfs: mounted
[    1.841464] Freeing unused kernel memory: 1024K
[  223.667700] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware interrupt.
[  223.667701] sdhost-bcm2835 3f202000.mmc: =========== REGISTER DUMP ===========
[  223.667702] sdhost-bcm2835 3f202000.mmc: SDCMD  0x00004052
[  223.667702] sdhost-bcm2835 3f202000.mmc: SDARG  0x00021e18
[  223.667699] sdhost-bcm2835 3f202000.mmc: SDTOUT 0x017d2a20
[  223.667702] sdhost-bcm2835 3f202000.mmc: SDCDIV 0x00000003
[  223.667705] sdhost-bcm2835 3f202000.mmc: SDRSP0 0x00000900
[  223.667703] sdhost-bcm2835 3f202000.mmc: SDRSP1 0x00001269
[  223.667703] sdhost-bcm2835 3f202000.mmc: SDRSP2 0x7fffffff
[  223.667705] sdhost-bcm2835 3f202000.mmc: SDRSP3 0x00024007
[  223.667705] sdhost-bcm2835 3f202000.mmc: SDHSTS 0x00000081
[  223.667701] sdhost-bcm2835 3f202000.mmc: SDVDD  0x00000001
[  223.667702] sdhost-bcm2835 3f202000.mmc: SDEDM  0x00010831
[  223.667702] sdhost-bcm2835 3f202000.mmc: SDHCFG 0x0000040e
[  223.667700] sdhost-bcm2835 3f202000.mmc: SDHBCT 0x00000200
[  223.667699] sdhost-bcm2835 3f202000.mmc: SDHBLC 0x00000001
[  223.667699] sdhost-bcm2835 3f202000.mmc: ===========================================
