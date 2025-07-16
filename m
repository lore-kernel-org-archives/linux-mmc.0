Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6726E143;
	Wed, 16 Jul 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680881; cv=none; b=W+AAUdcOaDkR3qXvvqoo9XNPI2dXW1cVV4nTwSk/XXKl1SPLSuu3OKBt6QGwv73DlM0tHwI/Q7b+df/etsAFEi5KJAOlhFXGCF4vEvoJcserlDLApkigUFq+9RKWRhhgK0c5X0yJEXn9ks/5airbj1A3ZS/5klbzfgdceHLmvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680881; c=relaxed/simple;
	bh=TdjdAZ5Qcl70q89Fsx6WtjY1GVu0RGAg65fTIwd72lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3oXLSdUAYrBufxCqARHD3L4J64bXpyOAwFqmHBfrE9WZCtNUIW2+BlEZcR0RWfYZFtVF2UPu9miSJOoebdk5UcS3ak9xH2+41fu60QXgNWeKUClRlZl1543DfxPJEzfQ4vNBnVzqynKv0l0y6nS6WMWWHSzmA3ASNDT1yUABf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cQ+RHXS1; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cQ+RHXS1"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 774394446E;
	Wed, 16 Jul 2025 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752680871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjdubYPyuEPfJm3WKT23YKO+sTW4CBP0Ei8HQieSzRA=;
	b=cQ+RHXS1Z/EhPM5DLfq30qSBt+nPcw1EVHf0N3khBN933OI+dhM/XZ/LUuYiljkTUX246h
	SY0daJSUfFtVBUsU5ixzfu0FYCdRXHX1FbtJyNNp8DZZ3fbWnbePWdQAdAmVNziEPXw1ui
	VhiEA6z/a2FSPVD9u6kwY3bcurO7qnK/LBCYnpzfMhehjfOq2p0WkSlbMXQS+t32hYDZem
	khucJY/RGMlxPzraAYiArTaf0pEPmQhSlwaUpPlz+slzc8gXL+2lRVnJEGQnk/HBpiqBbc
	Ee7vaVSyOxPFEmPzFvXciPfjBNUtXt8EwfH1rihtLk28BNKIx2Q4QnXoyaFFEw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 16 Jul 2025 17:47:17 +0200
Subject: [PATCH v3 6/6] mmc: sdhci-cadence: implement multi-block read gap
 tuning
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-mobileye-emmc-for-upstream-4-v3-6-dc979d8edef0@bootlin.com>
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
In-Reply-To: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudefgfdugfffgfeuhfeguedvuefhkeektdeludelvdelteelteejjeeiteetvedtnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopegludelvddrudeikedruddtrddukeejngdpmhgrihhlfhhrohhmpegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmhgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthgrfihfihhkrdgsrgihohhukhesmhhosghilhgvhigvr
 dgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhg
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

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/host/sdhci-cadence.c | 69 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 2d823e158c59844dc7916db6a1d6e3d8b02ea5a0..0a9a90f9791d343b5d64ed602066f6291efa75b5 100644
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
 
@@ -251,6 +269,49 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
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
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS200:
+		hrs37_mode = SDHCI_CDNS_HRS37_MODE_MMC_HS200;
+		break;
+	default:
+		return 0; /* no tuning in this mode */
+	}
+
+	writel(hrs37_mode, hrs37_reg);
+
+	for (gap = 0; gap <= SDHCI_CDNS_HRS38_BLKGAP_MAX; gap++) {
+		writel(gap, hrs38_reg);
+		ret = mmc_read_tuning(NULL, mmc, 512, 32);
+		if (ret == 0)
+			break;
+	}
+
+	dev_dbg(mmc_dev(mmc), "read block gap tune %s, gap %d\n",
+		ret == 0 ? "OK" : "failed", gap);
+	return ret;
+}
+
 /*
  * In SD mode, software must not use the hardware tuning and instead perform
  * an almost identical procedure to eMMC.
@@ -261,6 +322,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int max_streak = 0;
 	int end_of_streak = 0;
 	int i;
+	int ret;
 
 	/*
 	 * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
@@ -288,7 +350,12 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return -EIO;
 	}
 
-	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+	ret = sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+
+	if (!ret)
+		ret = sdhci_cdns_tune_blkgap(host->mmc);
+
+	return ret;
 }
 
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,

-- 
2.50.1

