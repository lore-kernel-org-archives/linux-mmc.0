Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB621E0B7;
	Thu,  9 Jan 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437986; cv=none; b=rnbhA9mXPa8hJOF4Y2QaQHEpjjoV+QL8RANDg7BXQ2xl9vD+90gsjvk9c8L+PLNTi3VzP8fpw034/8BoYCTHhJyIdDpxP3Xsb5Jw4SGoiBbt6fQK6iU532wJ6onFGHgZNAIdqUbdLTdtQ56CSmJhEM7E+E30B5hSEYt+X1Zwpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437986; c=relaxed/simple;
	bh=Gr2UZqhGaCcBNCEFnPWcGvmfKjnT3yqrVaJPosur4RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUoh47ZB53WAeYVqa3WuPR3HqThyTa9WjSzIPN8+/sMGA5ZxkZlPMEtvJUbuqvSQ0dkTxyz0/TY9jGXv5kA+UhnwTIy+/Y1jL1Enj9uLNoFl4z+44Uhl4KYJqAwdWf2tMrrcKkmkpxmOEDq+1uA/SlR7LWeik/KLvqpPDaGUZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKig11aM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKig11aM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D8C4CED6;
	Thu,  9 Jan 2025 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437985;
	bh=Gr2UZqhGaCcBNCEFnPWcGvmfKjnT3yqrVaJPosur4RM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZKig11aMgs7dsX0OWshpoo/MsIIELNzaQGd8dcn4nX374inTFKyBUe0W6WG9T3MtJ
	 agtZZSTzZ12moIqTepiuq0tjDdF18w4qfXP7DVl/ro+Tq7y/XEdfI9sPLEEArz+UU6
	 Avx+57p8zuKqXas7oQvNe8AM4gJHnqrtTfPNwkjIlLO/KbR2r0zs6dkqyNuWr0q6f0
	 sKmfP1+UXEWCN0zWUWmWD40fzCoskDiXT8QKGNsBzKACZIsmR1s8xK8mkYIBcAuMWW
	 UVhE3LbZFhUTCLqYhZqKbmEHbNYmD+Wk4eJw50pTGj6zHc9TImWeAgXn+tD61t4Gss
	 vk1AMVvq8Ik9A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] mmc: Use of_property_present() for non-boolean properties
Date: Thu,  9 Jan 2025 09:52:54 -0600
Message-ID: <20250109155255.3438450-1-robh@kernel.org>
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

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Drop initialization of dat3_card_detect
 - Rebase on next-20250109
---
 drivers/mmc/host/mxcmmc.c          | 8 ++++----
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index e7a286c3216f..0a9affd12532 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -995,7 +995,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	struct mxcmci_host *host;
 	struct resource *res;
 	int ret = 0, irq;
-	bool dat3_card_detect = false;
+	bool dat3_card_detect;
 	dma_cap_mask_t mask;
 	struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
 
@@ -1048,9 +1048,9 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	if (pdata)
 		dat3_card_detect = pdata->dat3_card_detect;
-	else if (mmc_card_is_removable(mmc)
-			&& !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
-		dat3_card_detect = true;
+	else
+		dat3_card_detect = mmc_card_is_removable(mmc) &&
+				   !of_property_present(pdev->dev.of_node, "cd-gpios");
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e23177ea9d91..ff78a7c6a04c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1648,7 +1648,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	 * Retrieving and requesting the actual WP GPIO will happen
 	 * in the call to mmc_of_parse().
 	 */
-	if (of_property_read_bool(np, "wp-gpios"))
+	if (of_property_present(np, "wp-gpios"))
 		boarddata->wp_type = ESDHC_WP_GPIO;
 
 	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
-- 
2.45.2

