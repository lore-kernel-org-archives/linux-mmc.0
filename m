Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D72C3253
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623492; cv=pass; b=diIruqXROBISb2U2S0jJ7PdoH6DERpGgkEKMkO50gA3n4sBA1ZGWNeQIcjipIzZlOhgnJNJdWmX/nW2BelEUHo+73Lg2EE7nwtB8/fvV9WNz3emwoaLtucPD69O6VIEQrb8UgqFMrFgoVjbofDINUC1zE+s7n3oVIfFjmjK2KWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623492; c=relaxed/simple;
	bh=BTywOtQLHQpsMqwU50SKbzjM59Z+Ql/iOCOPMBfLIvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVsPQzpCTVqfz6jP0mCVmD0YGlnpQ/cRx3BF26aEQBgdVQloCMp5aE5Wc7qyyASNmZKFSGnp3ds48ZJUwpF64C3cwX4vw2tygfKPmVAJjP0XHAmu5JvO9fSCqfmSTKL1RhGITy8VLsfUxol8pYX3y9rxEecgVDErqCHTbkRmtYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=hdqkTLOq; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=hr/Drxso; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="hdqkTLOq";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="hr/Drxso"
ARC-Seal: i=1; a=rsa-sha256; t=1757623475; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=f/D2FNYTumLDUNgEXWMo4msDn51Sv6X4zDkECK0Cc6zpmKBq6ZRx6kqSCYO3k/UxyM
    vFiwXBBHpd/BfC4Q4acLQTtaIC1fSDhjabmZyh/HqOsRrzIProkFzbb1+ya7CLNvo2vH
    JTFvJ7gGT+d/C5M2v6PmpQwgnPRDxKI0jFsGzENY6nLPU7ya5/4Qpj1tsK7x2D0kIINc
    d4XQXJToz1tGHNKwMrGZ1FysuB6CjY/+8geDBhbUduydmwlaQq774Pn9PtmWe0wF6ClP
    IN+24OKcn9K7lrJxUjnmhozhA53quFIcbpN1KrAtYh4xaQu85mMbH3cMzOUao2VR6WJF
    UyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623475;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rFE1N+SKv61IRj1qppOls8RqTuuJaKTkMbB2/2nCwg8=;
    b=eSM8xYKkTpHtakn+B1Jftymiek+/X2rbt3Z5WsXQWiQgLTj0Y+Sc3z8auggZ77Qj6W
    qtCb5Cgz2Xh9DAYot736S1mLg2hD/X/wxmlaSpMz4LXurBd6AoVpZNk+jlWI3HhKKkuX
    KsoPQcDe1lD+fl2h7D1IUESUYwufTnaJ1Dx3tJ6Zjle6G/bnie+3fQS4Bls0qQYb7NPB
    jCYsgLG3m2iPmvlD/oB0AhJwOFVLkcPAQpbV3YqgUNfg3DWSykpEdOkgjClnwUPra11F
    o6Lkp4741zzpvxawX5tAQP+qwZC/0UpyTDjQVrvJx0Gimxo6Q4OoHnkpFV6okWdg+gHC
    QKlw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623475;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rFE1N+SKv61IRj1qppOls8RqTuuJaKTkMbB2/2nCwg8=;
    b=hdqkTLOq7lPod35t0a5PR6xOMuJ6BpUHVmuQ1LmOpsHfjKx/1VJ5JhHSu7LhdSCgO7
    daooVwBLmvAVCmJqnfkscROgTzgeMk1rUzPPWJkOzO+aoPhBebITH1v1nWfkSd6RJAtg
    7O5QXxw6oJ+r4eSQrbeOcjr36Z9OC/gaarYC6Md/YfQDWVFkv3XtWTjXP3qOxJxJ/d8m
    wAZVmYjnqrK6H14nMFV/N97ehi+lXmJIG8IHXaz/7hzeB/d1FmbNL421JU3Fv41uRzVC
    nK70YJVZT6yXZd4Q57Tz6BcqjeW4lgozj3LGSDXn2cUUNVqLfbBSTyvGYsy9sKfv5Kix
    BIcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757623475;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rFE1N+SKv61IRj1qppOls8RqTuuJaKTkMbB2/2nCwg8=;
    b=hr/Drxso9D3j5h5jRGcqPDT0j2O1kVsYA1/hFy0M+9YWsMSuLiUyiPcBpcyeOj//xE
    HP34cFuTKSMe3x0utEDQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQfI1ZDZOzYzKOl2SdacNvyFh1H/ghUw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918BKiZheB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Sep 2025 22:44:35 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org,
	Avri.Altman@sandisk.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 2/2] mmc: core: Improve RPMB frame handling code
Date: Thu, 11 Sep 2025 22:44:26 +0200
Message-Id: <20250911204426.394260-3-beanhuo@iokpp.de>
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

Introduce RPMB_FRAME_SIZE, CHECK_SIZE_NEQ(), and CHECK_SIZE_ALIGNED()
macros to replace repetitive sizeof(struct rpmb_frame) checks in
mmc_route_rpmb_frames().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index dd6cffc0df72..b32eefcca4b7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -121,6 +121,10 @@ struct rpmb_frame {
 #define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
 #define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
 
+#define RPMB_FRAME_SIZE        sizeof(struct rpmb_frame)
+#define CHECK_SIZE_NEQ(val) ((val) != sizeof(struct rpmb_frame))
+#define CHECK_SIZE_ALIGNED(val) IS_ALIGNED((val), sizeof(struct rpmb_frame))
+
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -2864,12 +2868,12 @@ static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
 	 * The size of an RPMB frame must match what's expected by the
 	 * hardware.
 	 */
-	BUILD_BUG_ON(sizeof(struct rpmb_frame) != 512);
+	static_assert(!CHECK_SIZE_NEQ(512), "RPMB frame size must be 512 bytes");
 
 	idata->ic.opcode = opcode;
 	idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 	idata->ic.write_flag = write_flag;
-	idata->ic.blksz = sizeof(struct rpmb_frame);
+	idata->ic.blksz = RPMB_FRAME_SIZE;
 	idata->ic.blocks = buf_bytes /  idata->ic.blksz;
 	idata->buf = buf;
 	idata->buf_bytes = buf_bytes;
@@ -2893,32 +2897,28 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
 	if (IS_ERR(md->queue.card))
 		return PTR_ERR(md->queue.card);
 
-	if (req_len < sizeof(*frm))
+	if (req_len < RPMB_FRAME_SIZE)
 		return -EINVAL;
 
 	req_type = be16_to_cpu(frm->req_resp);
 	switch (req_type) {
 	case RPMB_PROGRAM_KEY:
-		if (req_len != sizeof(struct rpmb_frame) ||
-		    resp_len != sizeof(struct rpmb_frame))
+		if (CHECK_SIZE_NEQ(req_len) || CHECK_SIZE_NEQ(resp_len))
 			return -EINVAL;
 		write = true;
 		break;
 	case RPMB_GET_WRITE_COUNTER:
-		if (req_len != sizeof(struct rpmb_frame) ||
-		    resp_len != sizeof(struct rpmb_frame))
+		if (CHECK_SIZE_NEQ(req_len) || CHECK_SIZE_NEQ(resp_len))
 			return -EINVAL;
 		write = false;
 		break;
 	case RPMB_WRITE_DATA:
-		if (req_len % sizeof(struct rpmb_frame) ||
-		    resp_len != sizeof(struct rpmb_frame))
+		if (!CHECK_SIZE_ALIGNED(req_len) || CHECK_SIZE_NEQ(resp_len))
 			return -EINVAL;
 		write = true;
 		break;
 	case RPMB_READ_DATA:
-		if (req_len != sizeof(struct rpmb_frame) ||
-		    resp_len % sizeof(struct rpmb_frame))
+		if (CHECK_SIZE_NEQ(req_len) || !CHECK_SIZE_ALIGNED(resp_len))
 			return -EINVAL;
 		write = false;
 		break;
@@ -2926,10 +2926,8 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
 		return -EINVAL;
 	}
 
-	if (write)
-		cmd_count = 3;
-	else
-		cmd_count = 2;
+	/* Write operations require 3 commands, read operations require 2 */
+	cmd_count = write ? 3 : 2;
 
 	idata = alloc_idata(rpmb, cmd_count);
 	if (!idata)
@@ -2943,7 +2941,7 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
 			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
 
 		/* Send result request frame */
-		memset(resp_frm, 0, sizeof(*resp_frm));
+		memset(resp_frm, 0, RPMB_FRAME_SIZE);
 		resp_frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
 		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
 			  resp_len);
-- 
2.34.1

