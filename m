From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH v2] mmc_rescan: reduce verbosity
Date: Tue, 12 Oct 2010 09:29:37 +0200
Message-ID: <1286868577-7729-1-git-send-email-eric@eukrea.com>
References: <20101012060045.GA8252@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 68.mail-out.ovh.net ([91.121.185.69]:47521 "HELO
	68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756334Ab0JLHgW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 03:36:22 -0400
In-Reply-To: <20101012060045.GA8252@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
includes a pr_info which prints 4 lines each second for hosts configure=
d
with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
This patch enable the log only if CONFIG_MMC_DEBUG is selected.

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
v2 : enable log only if CONFIG_MMC_DEBUG is selected
v1 : use pr_debug instead of pr_info
 drivers/mmc/core/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c94565d..cda9d29 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1482,9 +1482,10 @@ void mmc_rescan(struct work_struct *work)
 			mmc_release_host(host);
 			goto out;
 		}
+#ifdef CONFIG_MMC_DEBUG
 		pr_info("%s: %s: trying to init card at %u Hz\n",
 			mmc_hostname(host), __func__, host->f_init);
-
+#endif
 		mmc_power_up(host);
 		sdio_reset(host);
 		mmc_go_idle(host);
--=20
1.7.0.4

