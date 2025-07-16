Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA52641CC;
	Wed, 16 Jul 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680880; cv=none; b=inIWTTRTzBASqBgUZgW7qKYH8OPb2xbg5rO3uygZY4JsB0Pxmnc/sZZfrFoi2Q9HjTHxAUyxCmNnNaulkDJ1q5UBG36u/oI1T66od2UlfwYythiNZmOPs8Z5aKB4kCM0z28MxnQ1x6Pvs6dPG8TG589BTzEHpOsd2tVUehe783c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680880; c=relaxed/simple;
	bh=+D4AuuieIDiT5yylBAhD4ODzcVXVO2cpEOlH+fDrBfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eoksCFhAfOQDCj9ZFKHO1aDuXrji1oJDNg/9NFQOvREEXFKE8IjDGepUqJ0aTroGmuikw+/1aYyTvvP6/i+TMedIjcbvO/zL1JmCUR7L8bEqMwN+Gz4WcmyxQD4QEOn/Igfyy+XscsyH1tluzr0pY1C9AxulDk+ASJcNNcZgwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e2zOuYjt; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e2zOuYjt"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1098844464;
	Wed, 16 Jul 2025 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752680871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+RGyc+JZolUqNUA4hKmoPbrC+oOxx/SPJY9oZeZX2s=;
	b=e2zOuYjtfbnikpFEqe0XJ71u+xT/nkuuZenq3i4Yfg4Y5eUm1N9avSxzRdCip3j+Qfeg7y
	x20q807eSWfLOL2vyjSE3katRU6WUgOYezzINu9hP8w6bg5pEUeoLh1ZL5SgkMKcQlqnj2
	L5MyBavSpiKzLYu6VzyhqZqN+L6IeEYn5PepUMdt8Sykh88Ja3IIsnSvr7xrrI4bzzcZHL
	9EJzesV3GSkVrg/Js7I3ezjxZgAaRPBc5LqEXdKcyyM3yO1ItOhUjysdceEFEFljqayFGV
	FdBBrJQHBh/6LB0V01PGSTZtc42rtdhy70z5BZWgsOD711jmimlZ2pdKXSKbiw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 16 Jul 2025 17:47:16 +0200
Subject: [PATCH v3 5/6] mmc: core: add mmc_read_tuning
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-mobileye-emmc-for-upstream-4-v3-5-dc979d8edef0@bootlin.com>
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

Provide a function to the MMC hosts to read some blocks of data as part
of their tuning. The card parameter is optional since it is not
available from the execute_tuning() operation, but present in
execute_hs400_tuning() and prepare_sd_hs_tuning().

This function only returns the status of the read operation, not the
data read.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/mmc_ops.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h   |  2 ++
 2 files changed, 81 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 66283825513cb4ff993a1b2ec1f0b0cac4e74487..d29e5daf3e326ab37e61c99456421b1f66bcb0de 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1077,3 +1077,82 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 	return err;
 }
 EXPORT_SYMBOL_GPL(mmc_sanitize);
+
+/**
+ * mmc_read_tuning() - read data blocks from the mmc
+ * @card: mmc card to read from, can be NULL
+ * @host: mmc host doing the read
+ * @blksz: data block size
+ * @blocks: number of blocks to read
+ *
+ * Read one or more blocks of data from the beginning of the mmc. This is a
+ * low-level helper for tuning operation. If card is NULL, it is assumed that
+ * CMD23 can be used for multi-block read.
+ *
+ * Note: Allocate and free a temporary buffer to store the data read. The data
+ * is not available outside of the function, only the status of the read
+ * operation.
+ *
+ * Return: 0 in case of success, otherwise -EIO / -ENOMEM / -E2BIG
+ */
+int mmc_read_tuning(struct mmc_card *card, struct mmc_host *host,
+		    unsigned int blksz, unsigned int blocks)
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
+		if (mmc_host_can_cmd23(host) &&
+		    (!card || (mmc_card_can_cmd23(card) &&
+		     !mmc_card_blk_no_cmd23(card)))) {
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
+	if (card)
+		mmc_set_data_timeout(&data, card);
+	else
+		data.timeout_ns = 1000000000;
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
index 68f09a955a902047ac517441b6820fa6e4166a13..5a6471a6219222b199a16afd9e6bd5ab74b05c86 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -743,5 +743,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+int mmc_read_tuning(struct mmc_card *card, struct mmc_host *host,
+		    unsigned int blksz, unsigned int blocks);
 
 #endif /* LINUX_MMC_HOST_H */

-- 
2.50.1

