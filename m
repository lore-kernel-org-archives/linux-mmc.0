Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74302C236B
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623492; cv=pass; b=aIn+3CIME/cSrYTmi56giCCWivn4qKWjfrGJ4awUYgsw4QHMdbLmbVvwRiiYQarl7XBFKtz87WCjWAB922YIl4dxGmNw4eJdpZgp5ON88g6QkS8UcgF6EuOP0p0BgVV7bS3hxwYvA2GiALc8o86qfAAfFOPJGztfDwtOeGBBm+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623492; c=relaxed/simple;
	bh=SlO0J5mU1NHmjICEvBkuXI/bHLIjM6B78voJx1DG1ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGBEh4kStSUlkVrdwDKXiOoePu2iMKDee4LeRFGAzcQfa5y00U8b9STsfIg2E6F4HgakARXfm3ZnnJe8Ik5Zy6F911nvA509RMTqPbTOjaySv09p8+QcmLw9byuiA+7KUDW1tGme4VPDhK3LfP/PMhjdshiOolDCWAYtUlH8pzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=nbN4WaRx; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=MODhsN4e; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="nbN4WaRx";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="MODhsN4e"
ARC-Seal: i=1; a=rsa-sha256; t=1757623475; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=csWZWwNKRIWqum3kOGdC/J3ZdgBwVRGYDnVnWi31CnOrgy6MHcE87J/ZlqpzWy6T4n
    yDAgZoBCuaeTUTmSIWCpjhpje2CEFH1SM6Z0u1Sum/cBe88sl8wKU4pQvIXEmU4xQr2+
    rTRlUjdli6mb1dt5OD4IdMrW239Q3QoL3HVB2h24ynI6rL1eEwoWE7C4Yn++6Tv1j9rF
    0lGZDygHDT7vRfD82RGkRgSwu0Xh8db46TP2c4wEGqdyBTReA7jPkDaNsBnjL/1eP+k+
    N+e9EdSZhtUmDMHTX+lDtLoIv/1MP7NvUA1lg78IinAARkwntp6o17L4g76m4F05Aan8
    Tx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623475;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/CjCD7iD9Jv0YyK00pomqHOzAZgZd+J9VBtfnhYuwx4=;
    b=MR96UMT0xkWnIK8fc96ewAqbizzCRiTB0RRjSru+7zJD9lJJmOEIdFVhu5aZPozsnS
    K01sL4c/xMmLTxZpmcvM6x2k/FhqjAWlgWFYX9V7q51xwrNrOq0ujweXDZQN8peJa3GD
    19eRpAau+InPje19Xv0IANDvLYJS5lQ2gi/Xg52vGu7iDe0xapACWZXhF6CvC4PW9hSB
    I+gt8TkqEJH1SoGq+7QRJ7gnntmfPq4SSb10VTauB7zMJorfaXmK5rUC/nQl+2mnU05W
    IvWYe1PqVhD5e/a3++Q0bB73J1c9icC1l70f7m/1EF8PCHEvvCoZYFYcI9jkvCIpWexS
    kFyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623475;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/CjCD7iD9Jv0YyK00pomqHOzAZgZd+J9VBtfnhYuwx4=;
    b=nbN4WaRxU/nadIs15cElTg4mDZOEBGkICsK3YQwZDic94YuoV0hzeABFadVxbsxmEg
    mpLwXqvzHqW8ZB4dL8HoVo37gnMN0XRQvhL0SZKRKtbGufwqj3zs57IQfTgXE9NuvTGh
    i9dUQAdO1xUy8JDae1iWAi1E6Y1HZUM4kiXOnkGiCMZT2VGLbeNmvSycSyvi7+jLvO12
    Hb/zGanBTuqjZ2PMA+mW4nNG0GfDxgPpn7s6jbtKFS3VY7FnvmqNwgJZh3zNTBKWqdwr
    ijI0N/CEC6+xTm0CWz1ff7bM5QfuHsehJjkLn7Veq0GNwa43ySzABfn1ZgSwNyrfs2g2
    ItjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757623475;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/CjCD7iD9Jv0YyK00pomqHOzAZgZd+J9VBtfnhYuwx4=;
    b=MODhsN4eZxSdkwDlur95Ag3PvalqB97lTIYJnRbP8l+8Zxvetjfiujuhl65IJXPwD4
    BxIN89iSz2P87pG/ahAg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQfI1ZDZOzYzKOl2SdacNvyFh1H/ghUw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918BKiZheA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Sep 2025 22:44:35 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org,
	Avri.Altman@sandisk.com
Cc: Bean Huo <beanhuo@micron.com>,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 1/2] mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
Date: Thu, 11 Sep 2025 22:44:25 +0200
Message-Id: <20250911204426.394260-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911204426.394260-1-beanhuo@iokpp.de>
References: <20250911204426.394260-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Rename the inner 'frm' variable to 'resp_frm' in the write path of
mmc_route_rpmb_frames() to avoid shadowing the outer 'frm' variable.

The function declares 'frm' at function scope pointing to the request
frame, but then redeclares another 'frm' variable inside the write
block pointing to the response frame. This shadowing makes the code
confusing and error-prone.

Using 'resp_frm' for the response frame makes the distinction clear
and improves code readability.

Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB subsystem")
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c    |   6 +-
 drivers/ufs/core/ufs-rpmb.c | 225 ++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufs-rpmb.h |  26 +++++
 3 files changed, 254 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ufs/core/ufs-rpmb.c
 create mode 100644 drivers/ufs/core/ufs-rpmb.h

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9cc47bf94804..dd6cffc0df72 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2936,15 +2936,15 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
 		return -ENOMEM;
 
 	if (write) {
-		struct rpmb_frame *frm = (struct rpmb_frame *)resp;
+		struct rpmb_frame *resp_frm = (struct rpmb_frame *)resp;
 
 		/* Send write request frame(s) */
 		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
 			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
 
 		/* Send result request frame */
-		memset(frm, 0, sizeof(*frm));
-		frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
+		memset(resp_frm, 0, sizeof(*resp_frm));
+		resp_frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
 		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
 			  resp_len);
 
diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
new file mode 100644
index 000000000000..c33157ec51ce
--- /dev/null
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UFS OPTEE based RPMB Driver
+ *
+ * Copyright (C) 2025 Micron Technology, Inc
+ * Copyright (C) 2025 Qualcomm Innovation Center.
+ *
+ * Authors:
+ *	Bean Huo <beanhuo@micron.com>
+ *	Can Guo <quic_cang@quicinc.com>
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/rpmb.h>
+#include <linux/string.h>
+#include <ufs/ufshcd.h>
+#include <linux/unaligned.h>
+#include "ufshcd-priv.h"
+#include "ufs-rpmb.h"
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
+#define UFS_RPMB_SEC_PROTOCOL		0xEC	/* JEDEC UFS application */
+#define UFS_RPMB_SEC_PROTOCOL_SPEC	0x01	/* SECURITY PROTOCOL SPECIFIC */
+
+
+/* UFS RPMB device structure */
+struct ufs_rpmb_dev {
+	struct rpmb_dev *rdev;
+	struct ufs_hba *hba;
+};
+
+static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, u8 secp, void *buffer,
+                          size_t len, bool send)
+{
+	struct scsi_device *sdev = hba->ufs_rpmb_wlun;
+	u8 cdb[12] = { 0, };
+	int ret;
+
+	cdb[0] = send ? SECURITY_PROTOCOL_OUT : SECURITY_PROTOCOL_IN;
+	cdb[1] = secp;
+	put_unaligned_be16(spsp, &cdb[2]);
+	put_unaligned_be32(len, &cdb[6]);
+
+	ret = scsi_execute_cmd(sdev, cdb, send ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
+	                       buffer, len,  /*timeout=*/10 * HZ, 0, NULL);
+	return ret <= 0 ? ret : -EIO;
+}
+
+/* UFS RPMB route frames implementation */
+static int ufs_rpmb_route_frames(struct device *dev, u8 *req, unsigned int req_len,
+                                 u8 *resp, unsigned int resp_len)
+{
+	if (!req || !req_len || !resp || !resp_len)
+		return -EINVAL;
+
+	struct ufs_rpmb_dev *ufs_rpmb = dev_get_drvdata(dev);
+	struct rpmb_frame *frm_out = (struct rpmb_frame *)req;
+	struct ufs_hba *hba = ufs_rpmb->hba;
+	bool need_result_read = true;
+	u16 req_type;
+	int ret;
+
+	req_type = be16_to_cpu(frm_out->req_resp);
+	switch (req_type) {
+	case RPMB_PROGRAM_KEY:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    resp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		break;
+	case RPMB_GET_WRITE_COUNTER:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    resp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		need_result_read = false;
+		break;
+	case RPMB_WRITE_DATA:
+		if (req_len % sizeof(struct rpmb_frame) ||
+		    resp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		break;
+	case RPMB_READ_DATA:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    resp_len % sizeof(struct rpmb_frame))
+			return -EINVAL;
+		need_result_read = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ufshcd_rpm_get_sync(hba);
+	ret = ufs_sec_submit(hba, 0x1, UFS_RPMB_SEC_PROTOCOL, req, req_len, true);
+	if (ret)
+		goto out;
+
+	if (need_result_read) {
+		struct rpmb_frame *frm_resp = (struct rpmb_frame *)resp;
+		memset(frm_resp, 0, sizeof(*frm_resp));
+		frm_resp->req_resp = cpu_to_be16(RPMB_RESULT_READ);
+		ret = ufs_sec_submit(hba, 0x1, UFS_RPMB_SEC_PROTOCOL, resp, resp_len, true);
+	}
+
+	if (!ret)
+		ret = ufs_sec_submit(hba, 0x1, UFS_RPMB_SEC_PROTOCOL, resp, resp_len, false);
+out:
+	ufshcd_rpm_put_sync(hba);
+	return ret;
+}
+
+/* UFS RPMB device registration */
+int ufs_rpmb_probe(struct ufs_hba *hba)
+{
+	struct ufs_rpmb_dev *ufs_rpmb;
+	struct rpmb_dev *rdev;
+	u32 cid[4]; /* 16 bytes, similar to MMC CID */
+	u8 *serial_data;
+
+	if (!hba->ufs_rpmb_wlun) {
+		dev_info(hba->dev, "No RPMB LUN, skip RPMB registration\n");
+		return -ENODEV;
+	}
+	/* Get the ASCII serial number data */
+	serial_data = hba->dev_info.serial_number;
+	if (!serial_data) {
+		dev_err(hba->dev, "Serial number not available\n");
+		return -EINVAL;
+	}
+	printk("serial is %s\n", serial_data);
+	/*
+	 * Use serial number as device ID. Copy ASCII serial number data.
+	 * This provides a unique device identifier for RPMB operations.
+	 */
+	memset(cid, 0, sizeof(cid));
+	strncpy((char *)cid, serial_data, sizeof(cid) - 1);
+	
+	/* Debug: print both string and u32 representations */
+	printk("cid as string: %s\n", (char *)cid);
+	printk("cid as u32: [0x%08x, 0x%08x, 0x%08x, 0x%08x]\n", 
+	       cid[0], cid[1], cid[2], cid[3]);
+
+	struct rpmb_descr descr = {
+		.type = RPMB_TYPE_UFS,
+		.route_frames = ufs_rpmb_route_frames,
+		.dev_id = (void *)cid,
+		.dev_id_len = sizeof(cid),
+		.reliable_wr_count = hba->dev_info.rpmb_io_size,
+		.capacity = hba->dev_info.rpmb_region0_size,
+	};
+
+	ufs_rpmb = devm_kzalloc(hba->dev, sizeof(*ufs_rpmb), GFP_KERNEL);
+	if (!ufs_rpmb)
+		return -ENOMEM;
+
+	ufs_rpmb->hba = hba;
+	dev_set_drvdata(&hba->ufs_rpmb_wlun->sdev_gendev, ufs_rpmb);
+
+	/* Register RPMB device */
+	rdev = rpmb_dev_register(&hba->ufs_rpmb_wlun->sdev_gendev, &descr);
+	if (IS_ERR(rdev)) {
+		dev_info(hba->dev, "Err! UFS RPMB device register failed.\n");
+		devm_kfree(hba->dev, ufs_rpmb);
+		return -EIO;
+	}
+
+	ufs_rpmb->rdev = rdev;
+	dev_info(hba->dev, "UFS RPMB device registered\n");
+	return 0;
+}
+
+/* UFS RPMB remove handler */
+void ufs_rpmb_remove(struct ufs_hba *hba)
+{
+	struct ufs_rpmb_dev *ufs_rpmb = dev_get_drvdata(&hba->ufs_rpmb_wlun->sdev_gendev);
+
+	if (ufs_rpmb) {
+		rpmb_dev_unregister(ufs_rpmb->rdev);
+		dev_info(hba->dev, "UFS RPMB device unregistered\n");
+	}
+}
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("UFS RPMB integration into the RPBM framework using SCSI Secure In/Out");
diff --git a/drivers/ufs/core/ufs-rpmb.h b/drivers/ufs/core/ufs-rpmb.h
new file mode 100644
index 000000000000..368b80893189
--- /dev/null
+++ b/drivers/ufs/core/ufs-rpmb.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Micron Technology, Inc.
+ * Copyright (C) 2025 Qualcomm Innovation Center.
+ *
+ * Authors:
+ *	Bean Huo <beanhuo@micron.com>
+ *	Can Guo <quic_cang@quicinc.com>
+ */
+#ifndef UFS_RPMP_H
+#define UFS_RPMB_H
+
+struct ufs_hba;
+
+#ifdef CONFIG_RPMB
+int ufs_rpmb_probe(struct ufs_hba *hba);
+void ufs_rpmb_remove(struct ufs_hba *hba);
+#else
+int ufs_rpmb_probe(struct ufs_hba *hba)
+{
+	return 0;
+}
+void ufs_rpmb_remove(struct ufs_hba *hba) { }
+#endif
+
+#endif /* UFS_RPMB_H */
-- 
2.34.1

