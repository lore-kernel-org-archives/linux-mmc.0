Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB214D710
	for <linux-mmc@vger.kernel.org>; Tue,  7 May 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073413; cv=none; b=Df5ZfGO86U3cms+Vs+M8QyqKuJeuFZE1qjdKznsu8KxZaF0Dcd0OgQAbU+/Hm8r+4wg0XeFlzlncDQpzUGx+krdzjbChw57BOwe77Ckk5XqzaGD4bFIaiIoJyQwJz2IYuK7G24TOoTwW60z5MctKVA+9VDm+M+FNz6aQqtI0RDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073413; c=relaxed/simple;
	bh=+jjmPCWL7r8Fyhz8AVURstJ73YjgSbV09gAbN+yt3g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFrc23OZnGtXY8pxzFoGSjuWUMADUUWh4vjsJJM6Reg2+tFCcIXlruStxK2mqPOc8z3Lg9sz4xV9zbkmVCe3tnG3PTp+1TQm4W0N0pqAuX9WDsHWlkAAIuadYR8/nRgl5hAAbA2ZXu0nAHbBzyrRQn/dgSAPXEykdSMjXgzOv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FuBma0c5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuBma0c5"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51fea3031c3so3585911e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 May 2024 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715073409; x=1715678209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbRspnpSma1b5MC8A+dHKQyEgWUfH4y7j2WEQBaodgE=;
        b=FuBma0c566nz6SMZOkLjEsY68YbUySCOULAGZh0I7PQhqKrG7LGqKDy+VOxb3/Nqzv
         W4OT+FPVRB2FJTAvP6WkQ/zVrrgGfwbUQFV+zRJFTcnyF9glatz8TqsHa/36vIVamC7l
         9Gc3Gf7DF2Hr46eTYDs5YTnCDPP/GiLIjsXo9mETSkbMeu4AJkIiqa4op9+lEWsvTyli
         PUAG4ZA1LGWuaKqay87CJWd/8vB/D22fLERus0eT4aCjYe9M9I6OJtE9bWGjBgEmxDMC
         Bl8CCGKGe+N13DPbfcMt8Y3VHTYjZ4MQTZ5ArTHBmTsY+GUWhcOmEwsZL+aOV5B95nzd
         pe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715073409; x=1715678209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbRspnpSma1b5MC8A+dHKQyEgWUfH4y7j2WEQBaodgE=;
        b=hsR0A2ZJQtbi6UyyGxjOfsHhi8e7ExZVTLPgaUvcOdLu6zdgPKNKABlmOZaaSac9C0
         n23DIPplcBJDVhpIyQpbNoQTsWzHwzrBtzVLKEGpuOj9efLEHb3PgBxZQ3WXwt6dZqeD
         o2ZTYSIa86u0F/2urEwqzPX3esO7uOg2oMa+5baBH7+wGHjWBjChNdVNjPOZeVcwK4LY
         Ko9wF2UcX1ClTtfIlzYT0AeZSQSmH+axYO+Hu7AR9Q23kwJMLR3e1cefjQxE8NRzZ1FK
         wfDCOYuSrW4rrZCmy47QPhGowoCgRh0iFc9ysKctQ9knDTB7xnTLSwzuEKfJM1P/Az4Z
         qbkA==
X-Forwarded-Encrypted: i=1; AJvYcCXHukgXn6qJ+sBWWfF3cC6QQ46OgRZRts8PvDxcj0m2cKzTv+tbKgrdQ9/WPrnI7dJhSU9XskgXfOrFsgZ8Nl0CcMRF/C864+px
X-Gm-Message-State: AOJu0Yw4ebU+H40sTirwjx+3dZqWoYFygs8nXJIfLUxODFqUlxg6ErIW
	oDU65fB95vMLLaRsmlgAN2RKr1ZwrcwYpm2IqY6nURBJt+I2kFHEsRwcmMuHUN0=
X-Google-Smtp-Source: AGHT+IFYwdXwqyDPJz0/hsNF/GVMaHPMWunbBWyfBA9jckpQ/DAl2rhonyiHr8a/X9Dq3Gxy7hvEZQ==
X-Received: by 2002:a05:6512:457:b0:51f:b781:7293 with SMTP id y23-20020a056512045700b0051fb7817293mr8206662lfk.11.1715073408824;
        Tue, 07 May 2024 02:16:48 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709061d4700b00a59a93a3ef4sm3976134ejh.149.2024.05.07.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:16:47 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Traut <manut@mecka.net>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v6 2/3] mmc: block: register RPMB partition with the RPMB subsystem
Date: Tue,  7 May 2024 11:16:18 +0200
Message-Id: <20240507091619.2208810-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507091619.2208810-1-jens.wiklander@linaro.org>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
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
---
 drivers/mmc/core/block.c | 241 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..a7f126fbc605 100644
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
 
@@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
 
 	get_device(&rpmb->dev);
 	filp->private_data = rpmb;
-	mmc_blk_get(rpmb->md->disk);
 
 	return nonseekable_open(inode, filp);
 }
@@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
 	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
 						  struct mmc_rpmb_data, chrdev);
 
-	mmc_blk_put(rpmb->md);
 	put_device(&rpmb->dev);
 
 	return 0;
@@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
 {
 	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
 
+	rpmb_dev_unregister(rpmb->rdev);
+	mmc_blk_put(rpmb->md);
 	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
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
@@ -2741,6 +2939,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 	rpmb->dev.release = mmc_blk_rpmb_device_release;
 	device_initialize(&rpmb->dev);
 	dev_set_drvdata(&rpmb->dev, rpmb);
+	mmc_blk_get(md->disk);
 	rpmb->md = md;
 
 	cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops);
@@ -3002,6 +3201,42 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 
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
@@ -3047,6 +3282,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 		pm_runtime_enable(&card->dev);
 	}
 
+	mmc_blk_rpmb_add(card);
+
 	return 0;
 
 out:
-- 
2.34.1

