From: Andreas Fenkart <afenkart@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v13=200/7=5D=20mmc=3A=20omap=5Fhsmmc=3A=20Enable=20SDIO=20IRQ?=
Date: Fri, 23 May 2014 10:30:27 +0200
Message-ID: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Balaji, Tony, Ulf, all

v13
- fix compile breaks if !CONFIG_PM
- additional patch: install dummy pm runtime hooks if !CONFIG_PM_RUNTIM=
E

v12
- drop !CONFIG_OF compile break only exists when
  #undef CONFIG_OF after include headers 1/7(Sebastian Reichel)
- do not emit "falling back to polling" if wake_irq not specified
  since MMC does not need it, and it might confuse users
  only emit if pinmux default/idle is not present or claiming
  the irq failed 2/7(Balaji)
- dropped out-of-tree patches 6/7(Balaji)
- mention "ti,am33xx-hsmmc" compatible section in bindings
  documentation 1/5

v11
- split !CONFIG_OF compile break into separate patch
- enable IWE/CLKEXTFREE in CON/HCTL register needed for omap4
- '&' vs '&&' in omap_hsmmc_resume, 1/5 (Andreas M=C3=BCller)
- #define DLEV_DAT instead of BIT(21) 2/5 (Balaji)
- pinctrl_pm_select_default_state() removed, 4/5 (Balaji)
- drop _irqsave/_irqrestore from omap_hsmmc_wake_irq handler since it
  can't be preempted by same priority omap_hsmmc_irq handler 1/5(Joel F=
ernandes)
- replace devres_open_group by explicit devm_free calls 1/5 (Balaji)
- disable_irq_nosync wake_irq since we handle it thread safe 1/5 (Balaj=
i)
- drop 'gpio_dat1' pinctrl states and rework documentation 5/5 (Balaji)

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
  - disable wake_irq in handler to prevent infinite loop =20
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
  itself=20

Andreas Fenkart (7):
  mmc: omap_hsmmc: install dummy pm runtime hooks if !CONFIG_PM_RUNTIME
  mmc: omap_hsmmc: Enable SDIO interrupt
  mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
  mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
  mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detected
  mmc: omap_hsmmc: switch default/idle pinctrl states in runtime hooks
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   54 ++++
 drivers/mmc/host/omap_hsmmc.c                      |  309 ++++++++++++=
++++++--
 include/linux/platform_data/mmc-omap.h             |    1 +
 3 files changed, 335 insertions(+), 29 deletions(-)

--=20
1.7.10.4

