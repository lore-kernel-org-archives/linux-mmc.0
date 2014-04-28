From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 0/5] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Mon, 28 Apr 2014 09:37:53 +0200
Message-ID: <1398670678-30611-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Balaji, Tony, all

v10 
- bug fix on multi-core, untested
- incorporated changes from Balaji
- use devres / RAII mechanism to configure wake_up /
  sdio irq capabilities
- drop pinctrl state 'active'
  rely on driver-model states 'default', 'idle'
- add specific 'gpio_dat1' state for am335x SWAKEUP hack
- reorganized patches; +1 patch multi-core bugfix / +1 for pinctrl 
- rebased 455c6fdbd21916 / cherry-picks from mmc-next 

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

Andreas Fenkart (5):
  mmc: omap_hsmmc: Enable SDIO interrupt
  mmc: omap_hsmmc: bug: abort runtime suspend if pending sdio irq
    detected
  mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
  mmc: omap_hsmmc: switch default/idle pinctrl states in runtime hooks
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   51 ++++
 drivers/mmc/host/omap_hsmmc.c                      |  285 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    1 +
 3 files changed, 316 insertions(+), 21 deletions(-)

-- 
1.7.10.4

