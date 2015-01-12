From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/3] Convert omap_hsmmc to use common devicetree parsing
 code.
Date: Tue, 13 Jan 2015 08:23:18 +1300
Message-ID: <20150112191702.2895.75815.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

This is another resend with mmc_gpio_set_cd_isr() now returning
void and being EXPORTed.

I included
	WARN_ON(ctx->cd_gpio_isr);
to guard against misuse.

My goal is to get omap_hsmmc to use the common code for parsing of,
particularly so that I can set "cap-power-off-card", which omap_hsmmc
doesn't explicitly report.

Thanks,
NeilBrown

P.S. Sorry for delay - I've been travelling.

---

NeilBrown (3):
      mmc: core: Allow host driver to provide isr for card-detect interrupts.
      mmc: omap_hsmmc: use slot-gpio library for gpio support.
      mmc: omap_hsmmc: use mmc_of_parse to parse common mmc configuration.


 drivers/mmc/core/slot-gpio.c  |   18 +++++++
 drivers/mmc/host/omap_hsmmc.c |  100 +++++++++--------------------------------
 include/linux/mmc/slot-gpio.h |    2 +
 3 files changed, 40 insertions(+), 80 deletions(-)

--
Signature
