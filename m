From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v9 0/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Tue, 11 Mar 2014 10:42:42 +0100
Message-ID: <1394530965-6022-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Resend of v8, with Chris Ball on cc and following changes.

v9
- extended comment about why wake-irq is needed
- drop double '(' ')' around card_detect_irq
- drop final '.' in in subject line of patch

v8
- rebased on top of Tony Lindgren<tony@atomide.com> changes
  - improved changelog describing the earlier work
  - improved wakeup irq setup
  - works for am3730 es platform now
- my changes on top:
  - compile tested with #undef CONFIG_OF
  - disable wake_irq in handler to prevent infinite loop  
  - fixed typo and added comment about wake-irq

v7
- rebase on 3.14.0-rc3-49726-g77e15ec
- split omap_hsmmc_pin_init due to regression on omap-3730 platform

v6
- rebase on Linux 3.13-rc3
- reformatting debugfs

v5
- fix compile error introduced by last minute one line fix

v4:
- switch to interrupts-extended format
- drop ti,swakeup-missing flag convert to comaptible section

v3:
- removed gpio_irq from platform_data

v2:
- incorparated changes as suggested by reviewers
- simplified workaround for am335x, gpio will now only wake
  the module from runtime suspend, not handle the sdio irq
  itself 

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO interrupt
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x
  mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 +++
 drivers/mmc/host/omap_hsmmc.c                      |  339 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    1 +
 3 files changed, 365 insertions(+), 25 deletions(-)

-- 
1.7.10.4

