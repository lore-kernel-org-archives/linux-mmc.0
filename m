From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH v3 3/4] mmc: mxs-mmc: Check the return codes of clk_enable() and mxs_reset_block()
Date: Thu,  8 Dec 2011 10:44:15 +0100
Message-ID: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323336236.git.LW@KARO-electronics.de>
References: <cover.1323336236.git.LW@KARO-electronics.de>
 <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323336236.git.LW@KARO-electronics.de>
 <d935557e044d2ebc56b4e70487b519fe722e9017.1323336236.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:53829 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1LHJo3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 04:44:29 -0500
In-Reply-To: <d935557e044d2ebc56b4e70487b519fe722e9017.1323336236.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323336236.git.LW@KARO-electronics.de>
References: <cover.1323336236.git.LW@KARO-electronics.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

Add an int return value to mxs_mmc_reset(), so that the return code of
mxs_reset_block() can be promoted to the caller.
Also check the return code of clk_enable() in the probe function.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index a9b70d2..0003d03 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -190,11 +190,14 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 		 BM_SSP_STATUS_CARD_DETECT);
 }
=20
-static void mxs_mmc_reset(struct mxs_mmc_host *host)
+static int mxs_mmc_reset(struct mxs_mmc_host *host)
 {
+	int ret;
 	u32 ctrl0, ctrl1;
=20
-	mxs_reset_block(host->base);
+	ret =3D mxs_reset_block(host->base);
+	if (ret)
+		return ret;
=20
 	ctrl0 =3D BM_SSP_CTRL0_IGNORE_CRC;
 	ctrl1 =3D BF_SSP(0x3, CTRL1_SSP_MODE) |
@@ -219,6 +222,7 @@ static void mxs_mmc_reset(struct mxs_mmc_host *host=
)
=20
 	writel(ctrl0, host->base + HW_SSP_CTRL0);
 	writel(ctrl1, host->base + HW_SSP_CTRL1);
+	return 0;
 }
=20
 static void mxs_mmc_start_cmd(struct mxs_mmc_host *host,
@@ -717,9 +721,19 @@ static int mxs_mmc_probe(struct platform_device *p=
dev)
 		ret =3D PTR_ERR(host->clk);
 		goto out_iounmap;
 	}
-	clk_enable(host->clk);
+	ret =3D clk_enable(host->clk);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc),
+			"%s: failed to enable clock: %d\n", __func__, ret);
+		goto out_clk_put;
+	}
=20
-	mxs_mmc_reset(host);
+	ret =3D mxs_mmc_reset(host);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc),
+			"%s: failed to reset controller: %d\n", __func__, ret);
+		goto out_clk_put;
+	}
=20
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -834,7 +848,9 @@ static int mxs_mmc_resume(struct device *dev)
 	struct mxs_mmc_host *host =3D mmc_priv(mmc);
 	int ret =3D 0;
=20
-	clk_enable(host->clk);
+	ret =3D clk_enable(host->clk);
+	if (ret)
+		return ret;
=20
 	ret =3D mmc_resume_host(mmc);
=20
--=20
1.5.6.5

