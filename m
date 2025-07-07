Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A52E11AD;
	Mon,  7 Jul 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901898; cv=none; b=uTokmFFlu2Yf5sbOJ74hHCuxC7Q8HehO8BK6ILZUZ38F7WUNZ9YUzA3JrkyNEHmi6zrkK45rFgL7nLd200EXsVEQ8wAqmyikWTP72fCSm9WHtP7AtvBdLiJDc9j6jCUYEIAuOx9AIlDblBXoCVqTEtSrltUL38XcwkfJ8G41BI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901898; c=relaxed/simple;
	bh=z56V3LYt6JflWbtJ6sLvEX0xeXlfbTMu3dFd7UNoQsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+MeWYzPy/UBrpVmuA6tiB9Uje5pMDZmiSsbBvXgD4QatTywYI4M+Xlvm27ZnADmzH8nYISMOvl40qyux6EdRcxfYg+r6sVp0Ma3KXWz7Kn1svg5yfU5dDjblV5DK3dLkeaYO25AwnAjs/AhU1fA/lLMVmyQR6cLwFwaylqMeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dCgZXTtB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dCgZXTtB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3CF444461;
	Mon,  7 Jul 2025 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751901893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEfmHIK+C+t2w8tfy05b4ClfFEIVcsPOdzDGg7LPXR0=;
	b=dCgZXTtBYuMv7ARy6r+wg8KKXnIuNySF5eC6r4eBi/WmUy4319yHXNmUJO4TVWvOvxlP+8
	6/OAGxiW6Z2ByL6MpS4x3vC7AHKjj3JWE+N64sdcoK1wMaFyLrdBU1iZ6Q8o4jsh6c6XIj
	PEyuVkjlrxWcnsm0tsp9IToFmBfSft2WdMMP+UdMk+/FrO9ScNt363amZt40L5Z8lsRZA6
	w0S4Q+zyXFyDuo2TLKfgfCcxHyEKN9/g0dHqo7ZV+f/o9EHOquMQ5ozViUsqcXJ9PxOuq8
	PKCuN+40DupzZtai8lNzRmpP2yRquNQ6Qa8ZmwxVRCqWYi4MAqP1N5QT1jGeyg==
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
Subject: [PATCH v2 1/4] mmc: core: add mmc_read_blocks to mmc_ops
Date: Mon,  7 Jul 2025 17:24:33 +0200
Message-ID: <346c422139b658b2ba6272f7ba7b07374008760f.1751898225.git.benoit.monin@bootlin.com>
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

Add a generic function to read some blocks of data from the MMC, to be
used by drivers as part of their tuning.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/core/card.h    | 10 ++++++
 drivers/mmc/core/mmc_ops.c | 69 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h   |  3 ++
 3 files changed, 82 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 9cbdd240c3a7d..93fd502c1f5fc 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -11,6 +11,7 @@
 #define _MMC_CORE_CARD_H
 
 #include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
@@ -300,4 +301,13 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
 }
 
+static inline bool mmc_card_can_cmd23(struct mmc_card *card)
+{
+	return ((mmc_card_mmc(card) &&
+		 card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
+		(mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
+		 card->scr.cmds & SD_SCR_CMD23_SUPPORT)) &&
+		!(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
+}
+
 #endif
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 66283825513cb..848d8aa3ff2b5 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1077,3 +1077,72 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 	return err;
 }
 EXPORT_SYMBOL_GPL(mmc_sanitize);
+
+/**
+ * mmc_read_blocks() - read data blocks from the mmc
+ * @card: mmc card to read from, can be NULL
+ * @host: mmc host doing the read
+ * @blksz: data block size
+ * @blocks: number of blocks to read
+ * @blk_addr: first block address
+ * @buf: output buffer
+ * @len: size of the buffer
+ *
+ * Read one or more blocks of data from the mmc. This is a low-level helper for
+ * tuning operation. If card is NULL, it is assumed that CMD23 can be used for
+ * multi-block read.
+ *
+ * Return: 0 in case of success, otherwise -EIO
+ */
+int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
+		    unsigned int blksz, unsigned int blocks,
+		    unsigned int blk_addr, void *buf, unsigned int len)
+{
+	struct mmc_request mrq = {};
+	struct mmc_command sbc = {};
+	struct mmc_command cmd = {};
+	struct mmc_command stop = {};
+	struct mmc_data data = {};
+	struct scatterlist sg;
+
+	if (blocks > 1) {
+		if (mmc_host_can_cmd23(host) &&
+		    (!card || mmc_card_can_cmd23(card))) {
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
+	data.blk_addr = blk_addr;
+	data.sg = &sg;
+	data.sg_len = 1;
+	if (card)
+		mmc_set_data_timeout(&data, card);
+	else
+		data.timeout_ns = 1000000000;
+
+	sg_init_one(&sg, buf, len);
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (sbc.error || cmd.error || data.error)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_read_blocks);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 68f09a955a902..72196817a6f0f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -743,5 +743,8 @@ int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
+		    unsigned int blksz, unsigned int blocks,
+		    unsigned int blk_addr, void *buf, unsigned int len);
 
 #endif /* LINUX_MMC_HOST_H */
