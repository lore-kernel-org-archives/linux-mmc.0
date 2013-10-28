From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 00/12] Prepare various SH/R Mobile/Car drivers for CCF migration
Date: Mon, 28 Oct 2013 23:49:17 +0100
Message-ID: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello,

This patch series, based on v3.12-rc7, prepares various Renesas SH-Mobile,
R-Mobile and R-Car drivers for migration to CCF by adding clock prepare and
unprepare support.

The patches are pretty straightforward. Most of the drivers called
clk_enable and clk_disable in sleepable context, I've thus just converted them
to clk_prepare_enable and clk_disable_unprepare.

The clocksource drivers were slightly more complex to handle as clk_enable and
clk_disable were called in non-sleepable context. As the clocksource framework
architecture doesn't provide any sleepable callback in which clocks could be
prepared and unprepared, I've added clk_prepare and clk_unprepare calls in the
probe and suspend/resume handlers (clocksources can't be removed so the remove
handler doesn't need a clk_unprepare call).

I'd like to get all these patches merged in v3.14. As they will need to go
through their respective subsystems' trees, I would appreciate if all
maintainers involved could notify me when they merge patches from this series
in their tree to help me tracking the merge status. I don't plan to send pull
requests individually for these patches, and I will repost patches
individually if changes are requested during review.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: linux-mmc@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org

Laurent Pinchart (12):
  clocksource: sh_cmt: Add clk_prepare/unprepare support
  clocksource: sh_mtu2: Add clk_prepare/unprepare support
  clocksource: sh_tmu: Add clk_prepare/unprepare support
  sata_rcar: Convert to clk_prepare/unprepare
  drm: shmob_drm: Convert to clk_prepare/unprepare
  i2c: sh_mobile: Convert to clk_prepare/unprepare
  mmc: sh_mmcif: Convert to clk_prepare/unprepare
  mmc: sh_mobile_sdhi: Convert to clk_prepare/unprepare
  usb: gadget: r8a66597-udc: Convert to clk_prepare/unprepare
  usb: r8a66597-hcd: Convert to clk_prepare/unprepare
  fbdev: shmobile-hdmi: Convert to clk_prepare/unprepare
  fbdev: shmobile-lcdcfb: Convert to clk_prepare/unprepare

 drivers/ata/sata_rcar.c                   | 10 +++++-----
 drivers/clocksource/sh_cmt.c              | 20 ++++++++++++++++----
 drivers/clocksource/sh_mtu2.c             | 16 ++++++++++++++--
 drivers/clocksource/sh_tmu.c              | 20 +++++++++++++++++---
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c |  4 ++--
 drivers/i2c/busses/i2c-sh_mobile.c        |  8 ++++----
 drivers/mmc/host/sh_mmcif.c               | 12 ++++++------
 drivers/mmc/host/sh_mobile_sdhi.c         |  4 ++--
 drivers/usb/gadget/r8a66597-udc.c         |  6 +++---
 drivers/usb/host/r8a66597-hcd.c           |  4 ++--
 drivers/video/sh_mobile_hdmi.c            |  6 +++---
 drivers/video/sh_mobile_lcdcfb.c          |  4 ++--
 12 files changed, 76 insertions(+), 38 deletions(-)

-- 
Regards,

Laurent Pinchart
