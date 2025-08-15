Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02554292B52;
	Fri, 15 Aug 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222937; cv=none; b=LoFOPgkvq/VzO53OyT4VaSxIu/3L8xUrx+FFuoEmuzsswtRiddZodQWNVgocMiQak+xjarsQGOVhjHzoJ1A7XYQpcBjTZ76pKS/F0aMfWZCqPKlzz9LV2jjL+3K7wJvrYeqKa6mVaTfMKmKJhVuQr8ebKxV9+j/wW+baJYyhykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222937; c=relaxed/simple;
	bh=NHJg45Q6RPT/LzftpxYLT2sirlMKoU2PUDsz68Jd5mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvMpx7z84Hd2Lhx5c5SdFCUaYQmiRD/zYtpEL8Xb/RZ41RNqam1Vo92PydhavV98/WFcsi/jX0KlB1RwXOM5WPWzmZzWUwEt3PHL7puhTZYH5qAyQeWEbOsdRPxxMypY7y6KUB+jOZlpe/IcE+n3N4D+QOkrWIpjHjgVSPvesuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Jwa9oA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Jwa9oA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCA1C4CEF5;
	Fri, 15 Aug 2025 01:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222936;
	bh=NHJg45Q6RPT/LzftpxYLT2sirlMKoU2PUDsz68Jd5mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6Jwa9oAl2loRWlaQq4BM/0mXiLm6tdOKqdwld6dQqu0gODg4+zNXfHa+rTroLGB7
	 8UrOJxC1WKC2P70lYm4b4saRYK1t5Nob/yNNjViViOfUIPaAbOMjMK8ZXlpWT8ao8G
	 /SDobr+9mn9xuTpFWNiyeV05e9SyD21HJWhIc7joNVb1zo/cZ/bj1za7eMz6l7/RiP
	 EH2O5B7nUruj16+ckY0M/MvdYcmm++nPF0K3BoKp+aQQcE6GuxDGrnUjRq//QJUCeF
	 LDFJnp8D8cgxOfXvGS/kIgxdAJT2H/jub54gCzuLo5tdZtenkYlfHpXvfE8X+Zaf+3
	 Kk+32QhYKXAxw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 33/38] mmc: sdhci-msm: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:08 +0800
Message-ID: <20250815013413.28641-34-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250815013413.28641-1-jszhang@kernel.org>
References: <20250815013413.28641-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use __maybe_unused.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/sdhci-msm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9d8e20dc8ca1..d2906bf6e598 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1943,7 +1943,7 @@ static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
 		qcom_ice_enable(msm_host->ice);
 }
 
-static __maybe_unused int sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
+static int sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 {
 	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
 		return qcom_ice_resume(msm_host->ice);
@@ -1951,7 +1951,7 @@ static __maybe_unused int sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 	return 0;
 }
 
-static __maybe_unused int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
+static int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
 {
 	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
 		return qcom_ice_suspend(msm_host->ice);
@@ -2011,13 +2011,13 @@ static inline void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
 {
 }
 
-static inline __maybe_unused int
+static inline int
 sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 {
 	return 0;
 }
 
-static inline __maybe_unused int
+static inline int
 sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
 {
 	return 0;
@@ -2801,7 +2801,7 @@ static void sdhci_msm_remove(struct platform_device *pdev)
 		clk_disable_unprepare(msm_host->bus_clk);
 }
 
-static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
+static int sdhci_msm_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2820,7 +2820,7 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
 	return sdhci_msm_ice_suspend(msm_host);
 }
 
-static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
+static int sdhci_msm_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2856,11 +2856,8 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend,
-			   sdhci_msm_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_msm_driver = {
@@ -2869,7 +2866,7 @@ static struct platform_driver sdhci_msm_driver = {
 	.driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
-		   .pm = &sdhci_msm_pm_ops,
+		   .pm = pm_ptr(&sdhci_msm_pm_ops),
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-- 
2.50.0

