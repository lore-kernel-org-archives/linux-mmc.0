From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering w/ device tree
Date: Fri, 29 Apr 2016 10:32:15 -0700
Message-ID: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lporzio-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, zhonghui.fu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This series picks patches from various different places to produce what
I consider the best solution to getting consistent mmc and mmcblk
ordering.

Why consistent ordering and why not just use UUIDs?  IMHO consistent
ordering solves a few different problems:

1. For poor, feeble-minded humans like me, have sane numbering for
   devices helps a lot.  When grepping through dmesg it's terribly handy
   if a given SDMMC device has a consistent number.  I know that I can
   do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
   the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
   about the SD card slot.  I don't want it to matter which one probed
   first, I don't want it to matter if I'm working on a variant of the
   hardware that has the SD card slot disabled, and I don't want to care
   what my boot device was.  Worrying about what device number I got
   increases my cognitive load.

2. There are cases where it's not trivially easy during development to
   use the UUID.  Specifically I work a lot with coreboot / depthcharge
   as a BIOS.  When configured properly, that BIOS has a nice feature to
   allow you to fetch the kernel and kernel command line from TFTP by
   pressing Ctrl-N.  In this particular case the BIOS doesn't actually
   know which disk I'd like for my root filesystem, so it's not so easy
   for it to put the right UUID into the command line.  For this
   purpose, knowing that "mmcblk0" will always refer to eMMC is handy.

Changes in v2:
- Rebased atop mmc-next
- Stat dynamic allocation after fixed allocation; thanks Wolfram!
- rk3288 patch new for v2

Douglas Anderson (1):
  ARM: dts: rockchip: Add mmc aliases for rk3288 platform

Jaehoon Chung (1):
  Documentation: mmc: Document mmc aliases

Stefan Agner (2):
  mmc: read mmc alias from device tree
  mmc: use SD/MMC host ID for block device name ID

 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
 arch/arm/boot/dts/rk3288.dtsi                 |  4 ++++
 drivers/mmc/card/block.c                      |  2 +-
 drivers/mmc/core/host.c                       | 17 ++++++++++++++++-
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
