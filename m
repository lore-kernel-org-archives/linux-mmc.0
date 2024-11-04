Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECC1CCB23;
	Mon,  4 Nov 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747232; cv=none; b=GgAikgw6W3UFqEPFuPOF/ISXIYgZW4+AFioclL9pV5vM1zcjoYlqTMEDAGnFrLEJQNqTL/fXvcexmOqoAbSs1EkSzqB6xX+tDt9+XbhteRiLryuF++tJWfotIA0jZjhBR1ech34kEIkLJVQDCbfF/Gdulub5+6AS5f9sjISpx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747232; c=relaxed/simple;
	bh=GpppFndmxOiMWcsj4cKxdFdIF2ODqAfHC96A/9l0Ga4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWybhmPux/h7zYpz/BClMjWj8Gx5aEjOD0phBrbo4p0qrXTa2YTvhbx57oG61nXkeAK30396j6Kh9RKeX2EQ3EWxxKV5Q625ArWdeFR8WPni+SpcpUmD9uJfRCnk9HW+zPUi7z6QFRYM3os638m+D/rLBd0pSeeztozmtL5yNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEHxkBXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEHxkBXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1DCC4CECE;
	Mon,  4 Nov 2024 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747232;
	bh=GpppFndmxOiMWcsj4cKxdFdIF2ODqAfHC96A/9l0Ga4=;
	h=From:To:Cc:Subject:Date:From;
	b=OEHxkBXJGNeLH3YX6LKaxeQhDMJ+EUjYKIR+lrLbq5gmRMES/xm+GJXWrhF1MaT7C
	 KIcs18j1Uq8G/xp8uSsf13UWuxmHhtFxoDmcXl8xNexu/2U5zSTgSqKkEimTEKR8XD
	 F3AIWCCB1fPS690o2sHYPFB0/1G6yEXuY/TY+OOkQWV9uOm9GjyKpU6ABgXB7vsIA+
	 pZjoYEkJksasKivOPSnMU2m1+0VwSLDOrSBOYHcudIDMnS7vKjJCBEDFTkSlLqd9xO
	 FrRItjUDWlaic/7GAL0EmnW8sU2pbnOTDAIhbGjVzFZTvmuOJp+MEjvf7SkAJwq7c/
	 CJW1cvlwhDT1Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:07:06 -0600
Message-ID: <20241104190707.275758-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/mmc/host/mxcmmc.c          | 6 +++---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 1edf65291354..dcb1a7336029 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1048,9 +1048,9 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	if (pdata)
 		dat3_card_detect = pdata->dat3_card_detect;
-	else if (mmc_card_is_removable(mmc)
-			&& !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
-		dat3_card_detect = true;
+	else
+		dat3_card_detect = mmc_card_is_removable(mmc) &&
+			!of_property_present(pdev->dev.of_node, "cd-gpios");
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0..cda1872769e0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1629,7 +1629,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	 * Retrieveing and requesting the actual WP GPIO will happen
 	 * in the call to mmc_of_parse().
 	 */
-	if (of_property_read_bool(np, "wp-gpios"))
+	if (of_property_present(np, "wp-gpios"))
 		boarddata->wp_type = ESDHC_WP_GPIO;
 
 	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
-- 
2.45.2

