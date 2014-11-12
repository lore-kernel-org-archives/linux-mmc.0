From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/2] mmc: core: power-on sdio card correctly.
Date: Wed, 12 Nov 2014 14:55:19 +1100
Message-ID: <20141112035217.18267.43304.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

These two patches replace my previous patch
  [PATCH 2/2] mmc: core: reset sdio card properly on resume.

The only change is to use host->card->ocr instead of
host->ocr_avail, as recommend by Ulf.

These restore my libertas  wifi device properly on system
resume.

(I'm still hoping for a reply to my other patch:
   [PATCH 1/2] mmc: core: allow a reset gpio to be configured.
)

Thanks,
NeilBrown

---

NeilBrown (2):
      mmc: core: use card->ocr when negotiating voltage setting in mmc_sdio_power_restore
      mmc: core: reset sdio card properly on resume.


 drivers/mmc/core/sdio.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--
Signature
