Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992F28A1D6;
	Mon,  7 Jul 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901897; cv=none; b=UZAShv47zcnchmMx20GrlwOR0El97oEIzJv7fZl8jz5XNd+IWIIDeq9rVWEvmyhRQt3YcF1oVmgQCYxnyLTatGG+9MjA3A7fQM9zWyO3EYoeWVO//2dtEXs6tz9IzpsLI/DH6qACsDepnEfjwZb0OjmMWWm6fHLNqVNtIsAmSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901897; c=relaxed/simple;
	bh=qYb9y//QmCZa2tCqRmFc+CD/t63Lr9ZkatkFc6Ffv+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0zdjuzMJSXigPW6iRnL6PQ5kyYEFu5HTVvMikiPe4hMhbhIL62PC8+ofRlsBqqBejTo1JUM0cgJcNq2r1nKcTlIKMOA60oBUKmA/wmke62I938KaLbpMQmvhclPQPPwyvpcWFsH6a6cEg54eTCMYwQyHRVbhFMEz/534gKqQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jeqUfG5Z; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jeqUfG5Z"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 404754446E;
	Mon,  7 Jul 2025 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751901893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A57nz6RK/Z+8UqMlpppM+ROv8Kwa5LbCTBc+BSbupIU=;
	b=jeqUfG5ZyzKqzRZy9gyXRsNm4w+m+Sn5ZxHn/qBcjRXAhWF/9OQleZmUa+MWRUEpVjeC/5
	2z7Y7qLeOUwGivFMLdzhtzyyFtCi9HDdy7SihO5Q7fV4vSkgAhKLlCqMb6Z4CsW/QGvhWV
	1NqaY4GzK+hWvXlYIPMd6GWcfdawQrGIU9eTlbHg5SETQxHQG3BdARSy4uHqj3L2SIbEFF
	Su50tRMGV36Sh8au9kuBvguWPXbkgJjS2puv4rYVz6bAYtWbIYLCBmxGRlgnvzgMaBbonY
	OrVesH/f2ypoIijMm1F7dCZ2CePbsbelDP5a7tunZkRoCO70VMs4bZEzbgzhPA==
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	"Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 2/4] mmc: sdhci-cadence: implement multi-block read gap tuning
Date: Mon,  7 Jul 2025 17:24:34 +0200
Message-ID: <3dfd4773123ca92a4adc935100788129e1970449.1751898225.git.benoit.monin@bootlin.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751898225.git.benoit.monin@bootlin.com>
References: <cover.1751898225.git.benoit.monin@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdfffeeiieejkeevuefhvdeggeefudffueeuffehffehffevjedugfdtueegtddvnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopehfrhgrmhgvfihorhhkpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigq
 dhmmhgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhlrgguihhmihhrrdhkohhnughrrghtihgvvhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepthgrfihfihhkrdgsrgihohhukhesmhhosghilhgvhigvrdgtohhmpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomh
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
 drivers/mmc/host/sdhci-cadence.c | 72 +++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 2d823e158c598..2199100f3d4a7 100644
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
 
@@ -251,6 +269,52 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
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
+	void *buf;
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
+	buf = kmalloc(512 * 32, GFP_KERNEL);
+	for (gap = 0; gap <= SDHCI_CDNS_HRS38_BLKGAP_MAX; gap++) {
+		writel(gap, hrs38_reg);
+		ret = mmc_read_blocks(NULL, mmc, 512, 32, 0, buf, 512 * 32);
+		if (ret == 0)
+			break;
+	}
+	kfree(buf);
+
+	dev_dbg(mmc_dev(mmc), "read block gap tune %s, gap %d\n",
+		ret == 0 ? "OK" : "failed", gap);
+	return ret;
+}
+
 /*
  * In SD mode, software must not use the hardware tuning and instead perform
  * an almost identical procedure to eMMC.
@@ -261,6 +325,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int max_streak = 0;
 	int end_of_streak = 0;
 	int i;
+	int ret;
 
 	/*
 	 * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
@@ -288,7 +353,12 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
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
