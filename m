Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78112EAD18;
	Thu, 26 Jun 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949065; cv=none; b=ryYQUY7g7HhTeV/caZxcNGhQ0VhPKv9naWRK8Isl5T8PQWkkezqMo669YrHf2sly4BCHzetm8wHWqtId+F8K1MAugHV8T1P7TWPKiPnmi1fY7bEp6875mQYalPCappYzovt6dIOL29BB4WdgBVQURJA8CcotzscDLh2rNKEE2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949065; c=relaxed/simple;
	bh=RMDC8L847CO+NOAgqQLroJyTjebc1kwbRbZj2Nv0Reo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnTl/8KI4VnuInm4i7Pb94F2FyTaxgib3J9sOgxIykRg/7CfGbzp1QTeGFiFh0QoWNL2ZrregPLZ7BAINwW+4IjakLUTCvfFlH4/PQ5NCn7KiTOUwSh6wjU88oBLQYienV4uP6+s08XryOeczNkWcH5p/izCbEnjwiZLEcrcxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kC9OaLDG; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kC9OaLDG"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2B3A43A2A;
	Thu, 26 Jun 2025 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750949055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUJjSHPpez+43GXduk92GH0CAHcL/H7h99xXDtOUhT8=;
	b=kC9OaLDGQFkw/rhvM6I4hrTaEVabYactQ7/spHRdwl5AgZwjKZ4XOaqe8Wcfn4giSBjMyv
	03w/jVmp4R0h8wJzCt+b+CJdKssQE9qbh1VYYUu2D8mzLB6EA3ykQzadJEAop9TgIerNvp
	7cMQyyYEA1anSwNsYFytsunQdxPU9SKMP44t4Q1EAfgQuDgTANQ0eaewunAGI4CK1OvoRm
	W98WE+17SVGcTIwOtr1e05OCvj3xkvKZyPx4ABN9o2GYgf7KTENUOY4UV9AzyxVfsDaxW7
	UkKTyI/NgQOTAbQGC7Wp5SIHy9zpCS8yQmNHGODC+QkUHt0cgheGd+xWoqG4hg==
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	"Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-cadence: tune multi-block read gap
Date: Thu, 26 Jun 2025 16:43:32 +0200
Message-ID: <2a43386ffef4012530ca2421ad81ad21c36c8a25.1750943549.git.benoit.monin@bootlin.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1750943549.git.benoit.monin@bootlin.com>
References: <cover.1750943549.git.benoit.monin@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdfffeeiieejkeevuefhvdeggeefudffueeuffehffehffevjedugfdtueegtddvnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopehfrhgrmhgvfihorhhkpdhmrghilhhfrhhomhepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsggvnhhoihhtrdhmohhnihhnsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqm
 hhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlhgrughimhhirhdrkhhonhgurhgrthhivghvsehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehtrgiffhhikhdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: benoit.monin@bootlin.com

From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>

Additional tuning required for multi-block read command.
Implement it accordingly to Cadence recommendation.

2 registers used: HRS37 and HRS38. To HRS37, SD interface mode programmed,
this selects HRS38 slot - there is separate slot for every SD interface
mode. HRS38 contains gap parameter,
it is selected by starting with gap=0 and sending multi-block read command.
gap incremented until multi-block read succeeds.

As of now, this tuning executed for HS200 only

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/host/sdhci-cadence.c | 142 ++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 27bd2eb29948..6dcf7ae0c99d 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -36,6 +36,23 @@
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
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
 
@@ -251,6 +268,123 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	return 0;
 }
 
+/**
+ * mmc_send_mb_read() - send multi-block read command
+ * @host: MMC host
+ *
+ * Sends multi-block read command, CMD23/CMD18/CMD12, ignore read data
+ *
+ * Return: error code
+ */
+static int mmc_send_mb_read(struct mmc_host *host)
+{
+	const int blksz = 512;
+	const int blocks = 32;
+	struct scatterlist sg;
+	struct mmc_command sbc = {
+		.opcode = MMC_SET_BLOCK_COUNT,
+		.arg = blocks,
+		.flags = MMC_RSP_R1 | MMC_CMD_AC,
+	};
+	struct mmc_command cmd = {
+		.opcode = MMC_READ_MULTIPLE_BLOCK,
+		.arg = 0,
+		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC,
+	};
+	struct mmc_command stop = {
+		.opcode = MMC_STOP_TRANSMISSION,
+		.arg = 0,
+		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
+	};
+	struct mmc_data data = {
+		.flags = MMC_DATA_READ,
+		.blksz = blksz,
+		.blocks = blocks,
+		.blk_addr = 0,
+		.timeout_ns =  800000000,	/* 800ms */
+		.timeout_clks = 1000,
+		.sg = &sg,
+		.sg_len = 1,
+	};
+	struct mmc_request mrq = {
+		.sbc = &sbc,
+		.cmd = &cmd,
+		.data = &data,
+		.stop = &stop,
+	};
+	int size = blksz * blocks, err = 0;
+	u8 *data_buf;
+
+	data_buf = kzalloc(size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+
+	sg_init_one(&sg, data_buf, size);
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (sbc.error) {
+		err = sbc.error;
+		goto out;
+	}
+
+	if (cmd.error) {
+		err = cmd.error;
+		goto out;
+	}
+
+	if (data.error) {
+		err = data.error;
+		goto out;
+	}
+
+out:
+	kfree(data_buf);
+	return err;
+}
+
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
+	bool tuned = false;
+	u8 gap;
+	u8 hrs37_mode;
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
+		tuned = !mmc_send_mb_read(mmc);
+		if (tuned)
+			break;
+	}
+	dev_dbg(mmc_dev(mmc), "read block gap tune %s, gap %d\n",
+		tuned ? "OK" : "failed", gap);
+	return tuned ? 0 : -EIO;
+}
+
 /*
  * In SD mode, software must not use the hardware tuning and instead perform
  * an almost identical procedure to eMMC.
@@ -261,6 +395,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int max_streak = 0;
 	int end_of_streak = 0;
 	int i;
+	int ret;
 
 	/*
 	 * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
@@ -288,7 +423,12 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
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
