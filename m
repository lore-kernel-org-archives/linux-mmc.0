Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C117E91A
	for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469505; cv=none; b=nl7EtGh4henpgbjlAxuz8fs2th+E9oiUKdhHeJgG8Np4VH9T4ByGM5B+qZlbZMnene2Z31opO6+dXPE60bMNGDv1LLSHrjCMYpJsp0xVIu9mGYrw1qsu7DSuklMtMd8tSJqC4vcaKM38n1YayB0yq8Pg7FlA0E/jjP3m/JFACbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469505; c=relaxed/simple;
	bh=aGWh+J7rxwKpm9axvJY5ssBF78lX8hbMq3S5yTRu//o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFVJNb0IzALuTY3BaEo8ZwviLIyimyclgoHVvisfek26b4i5lBJ8rffWPz78v6djW/jnQO8EwlDflNZ2mtWjd4Z63vx6PwQeYoJ5Ox67+SM61Dhkx+0NRm9QidCkl0Upu+HGvf8XsOvI+bZmOOpHxhEDivYa+n4lflcI0hkFIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sXET9BXP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXET9BXP"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so323696966b.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2024 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723469501; x=1724074301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNAwhcFDM8KqQgtnfwdflwEG+nlv/72aPL2LKGi/+3A=;
        b=sXET9BXP6wSZPWNy/ejxbSHZpdLkCZulhIOiCZhBRiyLJUOoRpRIT6BqSpZfiDtgCr
         mu+y5bi8hDHBtV2Lx7rIM9eEMl6WbwEjksBZMY8BVUwTdKZziKlL7znroevnJqKvlIVE
         Uf5t/5qU67s9WmhdhXyqEyhDWzvd0m2IGURHapivfgRdQYmmfgku1HGna1Q4mGho1i/p
         q3bitBuMQeVjBobx/jq6bewbJBL99KzBYdNZCh9xZyImvMf48c0p96IwRO24CVCSyIkT
         e/Hqc1C/kac99i52G2LQwajcoKQzWyZIlNwoXizwXfSshBEmcgSuoO59WA4J5EBjLZfR
         +V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469501; x=1724074301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNAwhcFDM8KqQgtnfwdflwEG+nlv/72aPL2LKGi/+3A=;
        b=KCZ36/tpS0C2KicH5u6nC9byN83PlbwHqAwpv1aV1JQm5Q5H82PtQgnmwdN93mPOF8
         ieF3kahZMzMGEleyvjGime2isCD8xuKO5LDzMBu5bLdHrHlS2geJWXT9TRLS98eWPD8T
         HqHsNvbM1SpHFex4wzlHuWKEfIRDoFduuC8w3hpw2jedjf+hrxQYN+DgdYHBE79OWmHd
         DAX3JnK4vtQHBGIjuCRqMVj0YpR4fcQYugwbbbOBuOy9p2n6jLNAXRqVmUWHrDNL7hL5
         DgtOzpLPQC4wfMT0x4Ts9T0I4CJMyg8YGw6JeC54UpyQ9pdkwwXZW4I1z2YN4c38ox/f
         BEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4F/fzeZRGdEafZfPpKR4mqoPYntAK4QzLbUdueEtKQJupEnWfIlALwCUfO9mswzajSCo/atYU2yHcltjnm9R4Wv4XqLXwRhry
X-Gm-Message-State: AOJu0YziD3m+R0Z01y8oJ9P/92K5b58odeoTzcNtWvB39zfaHpzwVopQ
	xjHnnhd09ptfko0UQ3LmRtr8UVRvVV3r/7VsmgLAcrjfcvNzx5qgrMNbYHSg080=
X-Google-Smtp-Source: AGHT+IGHznDTozWS5gFQ5q84anGchZwiF66nomlT2gO64CM1lQguMUu7tnkbPdMQIJaOZthvlXHIxg==
X-Received: by 2002:a17:907:d854:b0:a7a:8e0f:aaf0 with SMTP id a640c23a62f3a-a80ed24ec0emr26886966b.36.1723469501001;
        Mon, 12 Aug 2024 06:31:41 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1ccd9csm232461966b.100.2024.08.12.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:31:40 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v8 2/4] mmc: block: register RPMB partition with the RPMB subsystem
Date: Mon, 12 Aug 2024 15:31:25 +0200
Message-Id: <20240812133127.865879-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812133127.865879-1-jens.wiklander@linaro.org>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register eMMC RPMB partition with the RPMB subsystem and provide
an implementation for the RPMB access operations abstracting
the actual multi step process.

Add a callback to extract the needed device information at registration
to avoid accessing the struct mmc_card at a later stage as we're not
holding a reference counter for this struct.

Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
instead of in mmc_rpmb_chrdev_open(). This is needed by the
route_frames() function pointer in struct rpmb_ops.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Manuel Traut <manut@mecka.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 241 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c9963248fcb..ec8b13b9be12 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -33,6 +33,7 @@
 #include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
+#include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/delay.h>
 #include <linux/capability.h>
@@ -40,6 +41,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
 #include <linux/debugfs.h>
+#include <linux/rpmb.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
 #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
 
+/**
+ * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
+ *
+ * @stuff        : stuff bytes
+ * @key_mac      : The authentication key or the message authentication
+ *                 code (MAC) depending on the request/response type.
+ *                 The MAC will be delivered in the last (or the only)
+ *                 block of data.
+ * @data         : Data to be written or read by signed access.
+ * @nonce        : Random number generated by the host for the requests
+ *                 and copied to the response by the RPMB engine.
+ * @write_counter: Counter value for the total amount of the successful
+ *                 authenticated data write requests made by the host.
+ * @addr         : Address of the data to be programmed to or read
+ *                 from the RPMB. Address is the serial number of
+ *                 the accessed block (half sector 256B).
+ * @block_count  : Number of blocks (half sectors, 256B) requested to be
+ *                 read/programmed.
+ * @result       : Includes information about the status of the write counter
+ *                 (valid, expired) and result of the access made to the RPMB.
+ * @req_resp     : Defines the type of request and response to/from the memory.
+ *
+ * The stuff bytes and big-endian properties are modeled to fit to the spec.
+ */
+struct rpmb_frame {
+	u8     stuff[196];
+	u8     key_mac[32];
+	u8     data[256];
+	u8     nonce[16];
+	__be32 write_counter;
+	__be16 addr;
+	__be16 block_count;
+	__be16 result;
+	__be16 req_resp;
+} __packed;
+
+#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
+#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
+#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
+#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
+#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
+
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -163,6 +207,7 @@ struct mmc_rpmb_data {
 	int id;
 	unsigned int part_index;
 	struct mmc_blk_data *md;
+	struct rpmb_dev *rdev;
 	struct list_head node;
 };
 
@@ -2670,7 +2715,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
 
 	get_device(&rpmb->dev);
 	filp->private_data = rpmb;
-	mmc_blk_get(rpmb->md->disk);
 
 	return nonseekable_open(inode, filp);
 }
@@ -2680,7 +2724,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
 	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
 						  struct mmc_rpmb_data, chrdev);
 
-	mmc_blk_put(rpmb->md);
 	put_device(&rpmb->dev);
 
 	return 0;
@@ -2701,10 +2744,165 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
 {
 	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
 
+	rpmb_dev_unregister(rpmb->rdev);
+	mmc_blk_put(rpmb->md);
 	ida_free(&mmc_rpmb_ida, rpmb->id);
 	kfree(rpmb);
 }
 
+static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_count)
+{
+	unsigned int n;
+
+	for (n = 0; n < cmd_count; n++)
+		kfree(idata[n]);
+	kfree(idata);
+}
+
+static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
+					     unsigned int cmd_count)
+{
+	struct mmc_blk_ioc_data **idata;
+	unsigned int n;
+
+	idata = kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
+	if (!idata)
+		return NULL;
+
+	for (n = 0; n < cmd_count; n++) {
+		idata[n] = kcalloc(1, sizeof(**idata), GFP_KERNEL);
+		if (!idata[n]) {
+			free_idata(idata, n);
+			return NULL;
+		}
+		idata[n]->rpmb = rpmb;
+	}
+
+	return idata;
+}
+
+static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
+		      int write_flag, u8 *buf, unsigned int buf_bytes)
+{
+	/*
+	 * The size of an RPMB frame must match what's expected by the
+	 * hardware.
+	 */
+	BUILD_BUG_ON(sizeof(struct rpmb_frame) != 512);
+
+	idata->ic.opcode = opcode;
+	idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	idata->ic.write_flag = write_flag;
+	idata->ic.blksz = sizeof(struct rpmb_frame);
+	idata->ic.blocks = buf_bytes /  idata->ic.blksz;
+	idata->buf = buf;
+	idata->buf_bytes = buf_bytes;
+}
+
+static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
+				 unsigned int req_len, u8 *resp,
+				 unsigned int resp_len)
+{
+	struct rpmb_frame *frm = (struct rpmb_frame *)req;
+	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
+	struct mmc_blk_data *md = rpmb->md;
+	struct mmc_blk_ioc_data **idata;
+	struct mmc_queue_req *mq_rq;
+	unsigned int cmd_count;
+	struct request *rq;
+	u16 req_type;
+	bool write;
+	int ret;
+
+	if (IS_ERR(md->queue.card))
+		return PTR_ERR(md->queue.card);
+
+	if (req_len < sizeof(*frm))
+		return -EINVAL;
+
+	req_type = be16_to_cpu(frm->req_resp);
+	switch (req_type) {
+	case RPMB_PROGRAM_KEY:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    resp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = true;
+		break;
+	case RPMB_GET_WRITE_COUNTER:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    resp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = false;
+		break;
+	case RPMB_WRITE_DATA:
+		if (req_len % sizeof(struct rpmb_frame) ||
+		    resp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = true;
+		break;
+	case RPMB_READ_DATA:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    resp_len % sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (write)
+		cmd_count = 3;
+	else
+		cmd_count = 2;
+
+	idata = alloc_idata(rpmb, cmd_count);
+	if (!idata)
+		return -ENOMEM;
+
+	if (write) {
+		struct rpmb_frame *frm = (struct rpmb_frame *)resp;
+
+		/* Send write request frame(s) */
+		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
+			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
+
+		/* Send result request frame */
+		memset(frm, 0, sizeof(*frm));
+		frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
+		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
+			  resp_len);
+
+		/* Read response frame */
+		set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
+	} else {
+		/* Send write request frame(s) */
+		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req, req_len);
+
+		/* Read response frame */
+		set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
+	}
+
+	rq = blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(rq)) {
+		ret = PTR_ERR(rq);
+		goto out;
+	}
+
+	mq_rq = req_to_mmc_queue_req(rq);
+	mq_rq->drv_op = MMC_DRV_OP_IOCTL_RPMB;
+	mq_rq->drv_op_result = -EIO;
+	mq_rq->drv_op_data = idata;
+	mq_rq->ioc_count = cmd_count;
+	blk_execute_rq(rq, false);
+	ret = req_to_mmc_queue_req(rq)->drv_op_result;
+
+	blk_mq_free_request(rq);
+
+out:
+	free_idata(idata, cmd_count);
+	return ret;
+}
+
 static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 				   struct mmc_blk_data *md,
 				   unsigned int part_index,
@@ -2739,6 +2937,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 	rpmb->dev.release = mmc_blk_rpmb_device_release;
 	device_initialize(&rpmb->dev);
 	dev_set_drvdata(&rpmb->dev, rpmb);
+	mmc_blk_get(md->disk);
 	rpmb->md = md;
 
 	cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops);
@@ -3000,6 +3199,42 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 
 #endif /* CONFIG_DEBUG_FS */
 
+static void mmc_blk_rpmb_add(struct mmc_card *card)
+{
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	struct mmc_rpmb_data *rpmb;
+	struct rpmb_dev *rdev;
+	unsigned int n;
+	u32 cid[4];
+	struct rpmb_descr descr = {
+		.type = RPMB_TYPE_EMMC,
+		.route_frames = mmc_route_rpmb_frames,
+		.reliable_wr_count = card->ext_csd.enhanced_rpmb_supported ?
+				     2 : 32,
+		.capacity = card->ext_csd.raw_rpmb_size_mult,
+		.dev_id = (void *)cid,
+		.dev_id_len = sizeof(cid),
+	};
+
+	/*
+	 * Provice CID as an octet array. The CID needs to be interpreted
+	 * when used as input to derive the RPMB key since some fields
+	 * will change due to firmware updates.
+	 */
+	for (n = 0; n < 4; n++)
+		cid[n] = be32_to_cpu(card->raw_cid[n]);
+
+	list_for_each_entry(rpmb, &md->rpmbs, node) {
+		rdev = rpmb_dev_register(&rpmb->dev, &descr);
+		if (IS_ERR(rdev)) {
+			pr_warn("%s: could not register RPMB device\n",
+				dev_name(&rpmb->dev));
+			continue;
+		}
+		rpmb->rdev = rdev;
+	}
+}
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md;
@@ -3045,6 +3280,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 		pm_runtime_enable(&card->dev);
 	}
 
+	mmc_blk_rpmb_add(card);
+
 	return 0;
 
 out:
-- 
2.34.1

