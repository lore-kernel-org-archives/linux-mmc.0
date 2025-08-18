Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A5340DAF;
	Mon, 18 Aug 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525795; cv=none; b=tLi0IMbUewWx+VHhaLxW9D+bmt78tlQp91pvp8qkyOehf/7TIdnU5WXl0F9YrTZRNTK3ZQXP4SnTVVh7HiJwj/jAsRzWC6UH+V1lhLzH0g1DDexp7QyYVrVfOBS02MtVFhwvL9AtNZyGwaP8pn51uAFDIkUpQ6fropaM3XeMZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525795; c=relaxed/simple;
	bh=cqEMvBDIJh7sk0fkOOAjgfqJjUAGTMyPiTk2mzsorz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6uEj4jPFWPszpI3C1reh9yLSRH/9clqxPURQxWLkmO2RtWUes0Qk+E5EAvlJEuzKDfpnYzcrXLFM2VYeXZJOQJcEnmJ1Hrrcyfxwpn0zBhxlAPW7co8PkRnzQwQgpx5eNelKHHyFlLo00ewAa6guOgO5ttcewNaR7HDhWU0+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TB/BbVCx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TB/BbVCx"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08A1B43977;
	Mon, 18 Aug 2025 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755525791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKrzRB/Gdry9CrfnOHOsusIysuNG4TtE8dFjQjPlkg0=;
	b=TB/BbVCxzzQE/PbTdC2h8/PGF3ZOHi89W61dj13jSBz+LvTWljHBkELKYTr9Qj/5Bu5ePb
	2IkKGA2udMB+ZLjnlTCskufFCcnVYmThjzLyq7VTlCm+hQUk51DbHSOSr1nAD0444EDfRk
	LXPrpf2O+w0iqB/8aiLI34KDuFWCD0Fa4o+OhL04LtzR2v6j5EQlTkZMsdAJM2tS7o5khC
	gNglfXCfbBIMWrHNoay982mXSJfeDYUzw6kodRO77jiG+cuHoubQm7R/SesqhDP4rt1W6H
	mAeAuaLlvf8lRZpnBgV9mevnenzG8btGaQdFUlQep3hIXychvxhQ+p7OcKsdGg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 18 Aug 2025 16:02:51 +0200
Subject: [PATCH v4 6/6] mmc: sdhci-cadence: implement multi-block read gap
 tuning
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250818-mobileye-emmc-for-upstream-4-v4-6-34ecb3995e96@bootlin.com>
References: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
In-Reply-To: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepuegvnhhofphtucfoohhnihhnuceosggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedufefgudfgfffguefhgeeuvdeuhfekkedtleduledvleetleetjeejieetteevtdenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehpdhhvghloheplgduledvrdduieekrddutddrudekjegnpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepvhhlrgguihhmihhrrdhkohhnughrrghtihgvvhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesi
 hhnthgvlhdrtghomhdprhgtphhtthhopehtrgiffhhikhdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrgh
X-GND-Sasl: benoit.monin@bootlin.com

The controller suspends the clock between blocks when reading from the
MMC as part of its flow-control, called read block gap. At higher clock
speed and with IO delay between the controller and the MMC, this clock
pause can happen too late, during the read of the next block and
trigger a read error.

To prevent this, the delay can be programmed for each mode via the pair
of registers HRS37/38. This delay is obtained during tuning, by trying
a multi-block read and increasing the delay until the read succeeds.

For now, the tuning is only done in HS200, as the read error has only
been observed at that speed.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/host/sdhci-cadence.c | 63 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 2d823e158c59844dc7916db6a1d6e3d8b02ea5a0..a2a4a5b0ab964883cef8c5d7f6e0c961fe76bc13 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -36,6 +36,24 @@
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
 
+/* Read block gap */
+#define SDHCI_CDNS_HRS37		0x94	/* interface mode select */
+#define   SDHCI_CDNS_HRS37_MODE_DS		0x0
+#define   SDHCI_CDNS_HRS37_MODE_HS		0x1
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR12	0x8
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR25	0x9
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR50	0xa
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR104	0xb
+#define   SDHCI_CDNS_HRS37_MODE_UDS_DDR50	0xc
+#define   SDHCI_CDNS_HRS37_MODE_MMC_LEGACY	0x20
+#define   SDHCI_CDNS_HRS37_MODE_MMC_SDR		0x21
+#define   SDHCI_CDNS_HRS37_MODE_MMC_DDR		0x22
+#define   SDHCI_CDNS_HRS37_MODE_MMC_HS200	0x23
+#define   SDHCI_CDNS_HRS37_MODE_MMC_HS400	0x24
+#define   SDHCI_CDNS_HRS37_MODE_MMC_HS400ES	0x25
+#define SDHCI_CDNS_HRS38		0x98	/* Read block gap coefficient */
+#define   SDHCI_CDNS_HRS38_BLKGAP_MAX		0xf
+
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
 
@@ -251,6 +269,44 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	return 0;
 }
 
+/**
+ * sdhci_cdns_tune_blkgap() - tune multi-block read gap
+ * @mmc: MMC host
+ *
+ * Tune delay used in multi block read. To do so,
+ * try sending multi-block read command with incremented gap, unless
+ * it succeeds.
+ *
+ * Return: error code
+ */
+static int sdhci_cdns_tune_blkgap(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	void __iomem *hrs37_reg = priv->hrs_addr + SDHCI_CDNS_HRS37;
+	void __iomem *hrs38_reg = priv->hrs_addr + SDHCI_CDNS_HRS38;
+	int ret;
+	u32 gap;
+	u32 hrs37_mode;
+
+	/* Currently only needed in HS200 mode */
+	if (host->timing != MMC_TIMING_MMC_HS200)
+		return 0;
+
+	writel(hrs37_mode, hrs37_reg);
+
+	for (gap = 0; gap <= SDHCI_CDNS_HRS38_BLKGAP_MAX; gap++) {
+		writel(gap, hrs38_reg);
+		ret = mmc_read_tuning(mmc, 512, 32);
+		if (!ret)
+			break;
+	}
+
+	dev_dbg(mmc_dev(mmc), "read block gap tune %s, gap %d\n", ret ? "failed" : "OK", gap);
+	return ret;
+}
+
 /*
  * In SD mode, software must not use the hardware tuning and instead perform
  * an almost identical procedure to eMMC.
@@ -261,6 +317,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int max_streak = 0;
 	int end_of_streak = 0;
 	int i;
+	int ret;
 
 	/*
 	 * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
@@ -288,7 +345,11 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return -EIO;
 	}
 
-	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+	ret = sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+	if (ret)
+		return ret;
+
+	return sdhci_cdns_tune_blkgap(host->mmc);
 }
 
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,

-- 
2.50.1

