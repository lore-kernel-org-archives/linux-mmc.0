From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] mmc_rescan: reduce verbosity
Date: Mon, 11 Oct 2010 23:48:51 +0200
Message-ID: <1286833731-30567-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 63.mail-out.ovh.net ([91.121.185.56]:38724 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756092Ab0JKVs4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 17:48:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
includes a pr_info which prints 4 lines each second for hosts configure=
d
with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
This patch increase log level to debug (but maybe the right solution
would be to remove this log).

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/mmc/core/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c94565d..6ecfcd9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1482,7 +1482,7 @@ void mmc_rescan(struct work_struct *work)
 			mmc_release_host(host);
 			goto out;
 		}
-		pr_info("%s: %s: trying to init card at %u Hz\n",
+		pr_debug("%s: %s: trying to init card at %u Hz\n",
 			mmc_hostname(host), __func__, host->f_init);
=20
 		mmc_power_up(host);
--=20
1.7.0.4

