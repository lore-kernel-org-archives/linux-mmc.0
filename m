Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289E3101B1;
	Mon, 18 Aug 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525795; cv=none; b=RyF1FX1iY2szOrHcjFTbdHZTi7LvtAvJFIGfUEnZu9zl5B2Nq3TADsUAMFUTc7KuMHoZIXz9GlBKqr+WZHf5nbZeFlhyLDCSK747gzbDKmgLXuLwEk1oQrJwnN+0COPVlW9c1RG0nTRL3eixl6U3qQtAMGsIZaZeMdriE0O0W84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525795; c=relaxed/simple;
	bh=Nlrhy0jte5jkeG/sxZPldwdBsuqbcUojN+UDctTzlnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pA4gixJKce502KSqORmRN5mwKE83TDjMnVsgO+Cs8+drP9EbZPiRGeZ0JRdJUpEi1mEl8RXRxXynf6FV85wBSRFi0iLhpt+Lup8SUpZ2VTjV3wYHRElWyYp6FIgkobhf6X11l9xDRD0HBlEgU4GY2i+NqyFLLST+TeUMZAAu7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iANLcW4z; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iANLcW4z"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 891EE4397B;
	Mon, 18 Aug 2025 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755525790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSsrNhtOneuyob43kSx1I/jvPLZqPxySlqgoEIUC5JA=;
	b=iANLcW4zBSCMd1/0MWwjVKTsFelt9v4YeU/lZrgQnvojY3sSoEP6LhmeLDRAXweLtZ1W8P
	WomfYVwF6/stiV4l+2is4E9byVWlB3LgXKHfJsx0R7R7Bod/VBtxkj6jicFQ5TfhdBqstH
	pYiClKKsjFqrzjNQzn9bNvhv0eOnc0LK9UYSC6mupFB8jrNkybLp8onVZh2gOppn4lnEqv
	NCq7HUvMf1QMz5XPRaRgSjxmhzYUTsVuNktZFlKG5P1QF/5Z289xW9hnTYLQg+gnJazTFl
	LUC1i4M7DnvrOLZpSfi6RjgwBL/3rz5W5CzjUxWvrRc/DS9kjxuIWqvwSSA6DA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 18 Aug 2025 16:02:50 +0200
Subject: [PATCH v4 5/6] mmc: core: add mmc_read_tuning
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250818-mobileye-emmc-for-upstream-4-v4-5-34ecb3995e96@bootlin.com>
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

Provide a function to the MMC hosts to read some blocks of data as part
of their tuning.

This function only returns the status of the read operation, not the
data read.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/mmc_ops.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h   |  1 +
 2 files changed, 73 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 66283825513cb4ff993a1b2ec1f0b0cac4e74487..a952cc8265af8f9d9587e4f21884d5f6d2fe0369 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1077,3 +1077,75 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 	return err;
 }
 EXPORT_SYMBOL_GPL(mmc_sanitize);
+
+/**
+ * mmc_read_tuning() - read data blocks from the mmc
+ * @host: mmc host doing the read
+ * @blksz: data block size
+ * @blocks: number of blocks to read
+ *
+ * Read one or more blocks of data from the beginning of the mmc. This is a
+ * low-level helper for tuning operation. It is assumed that CMD23 can be used
+ * for multi-block read if the host supports it.
+ *
+ * Note: Allocate and free a temporary buffer to store the data read. The data
+ * is not available outside of the function, only the status of the read
+ * operation.
+ *
+ * Return: 0 in case of success, otherwise -EIO / -ENOMEM / -E2BIG
+ */
+int mmc_read_tuning(struct mmc_host *host, unsigned int blksz, unsigned int blocks)
+{
+	struct mmc_request mrq = {};
+	struct mmc_command sbc = {};
+	struct mmc_command cmd = {};
+	struct mmc_command stop = {};
+	struct mmc_data data = {};
+	struct scatterlist sg;
+	void *buf;
+	unsigned int len;
+
+	if (blocks > 1) {
+		if (mmc_host_can_cmd23(host)) {
+			mrq.sbc = &sbc;
+			sbc.opcode = MMC_SET_BLOCK_COUNT;
+			sbc.arg = blocks;
+			sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		}
+		cmd.opcode = MMC_READ_MULTIPLE_BLOCK;
+		mrq.stop = &stop;
+		stop.opcode = MMC_STOP_TRANSMISSION;
+		stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	} else {
+		cmd.opcode = MMC_READ_SINGLE_BLOCK;
+	}
+
+	mrq.cmd = &cmd;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	mrq.data = &data;
+	data.flags = MMC_DATA_READ;
+	data.blksz = blksz;
+	data.blocks = blocks;
+	data.blk_addr = 0;
+	data.sg = &sg;
+	data.sg_len = 1;
+	data.timeout_ns = 1000000000;
+
+	if (check_mul_overflow(blksz, blocks, &len))
+		return -E2BIG;
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	sg_init_one(&sg, buf, len);
+
+	mmc_wait_for_req(host, &mrq);
+	kfree(buf);
+
+	if (sbc.error || cmd.error || data.error)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_read_tuning);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 68f09a955a902047ac517441b6820fa6e4166a13..5ed5d203de23c1cd503061e0ef6a8bfd7253c8af 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -743,5 +743,6 @@ int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+int mmc_read_tuning(struct mmc_host *host, unsigned int blksz, unsigned int blocks);
 
 #endif /* LINUX_MMC_HOST_H */

-- 
2.50.1

