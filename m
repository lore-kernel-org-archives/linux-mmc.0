Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D1255248
	for <linux-mmc@vger.kernel.org>; Tue,  9 Sep 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452430; cv=pass; b=rmOayO2BJ4JSS8cWyfpScAwKIkoKIyppcLN3xJCuOQheceJHJRwVySNdO2luIMfokZWLdHTFzbCc66kK0H519pkHE6P4mUYI/lKuzA2Oop29GzouvHerOybhlKC9LdQ1B4qA1dNip+vRRPXA9pwhgirYCTw+LosPWnITVdoCxEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452430; c=relaxed/simple;
	bh=Hx/Eqk+RiwWXrcG7+11qMa/+W+Px16zUP5LqwmRetfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6k+nD7OYpUyPR/BktR0PAJhHwK7a8PkmsOsO9TyoVf3maNx1gAXl7yyQCpTsVmxmLED9477ssaURxLCb7jQ2keQij4iqEZnDj7wXMK50clAZzS4kTXoM5jtOYj/746xoRaUfXctI20/uWiK2dXPTHS9lZyq0kc5udyRz3npTn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=CxUkQPPi; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=UfSwGbIN; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="CxUkQPPi";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="UfSwGbIN"
ARC-Seal: i=1; a=rsa-sha256; t=1757452408; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CIT/F28wbfi015f3VkRei/2NEMcCpwTRbGLEGcHC2UwXwzq8Xk56Q/zPlw+Iy2TYhu
    58m7oDFr0UbPHo2A4aUJFLB4j1IN2KvmXHCxjH2FO9/UX1WSUsY/b8ITLGLqSfmS2iYe
    bo1Q76lCtgKQ1lvECepS3H1cS/zpCkCzYL4ebYkYMPdX9uuaMKLX5c78V0HhGydXljU5
    CTK78UoNcmf+y/1O4toDofCxCPzJkWDZCISYiMtGLpViGsJJ1vOtNHTMO+6xFfeGCozN
    G/5LBT4TuaqjzSDD0jzEtVhS2hDKMb00M6I9TkfrMFja3F5+Zt2XupvS/yZfTbHC9yto
    2QUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757452408;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CUj2i9Nhh/zffwxX44crBTlL5KOdX0eYu04HgjoTLng=;
    b=Z9QFKR6Yad0ffizsT/0HAky2vK3B6hV+SiKlssf2IBch9SVc9yRxY/4eIizr4v1Ojx
    Z4gYfs5GHAZr9dL+C6BBlbfkH2VP2TYeY+zyo4DDqp4ikDrjYkePdBc7SgBwl3ucD+kY
    nJ7r6666tY6augQz6NTcoMv0Hp48DgvkldKjowspQItF01Lki0Nwych1NcD7WEnmLJdS
    8rgrtYR7+F/wr2uzjc4r288DlZKFZFz//NeMrQiDn2ugQd/Sbx50tA8/0tggfRHoCmVi
    ug/C8deS5kMmKxWcozYy67+dif5+WOUN5Wu/aa/IydtGaTASiqQK4qRHh2djKPDbthCw
    ryKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757452408;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CUj2i9Nhh/zffwxX44crBTlL5KOdX0eYu04HgjoTLng=;
    b=CxUkQPPi2cbZxO2t6w8ZBMBhOkY1f/ZoMCCy573db8pg89F56Lg+HA5gjiVzMHQJcD
    PGWz19zo2tvUNJcJf8DDukS+4yDNV+ji4UtDeVe+YalRChG6WhNwKt5biFT43TuezT8t
    JlXiz18wDX/EpzwWdMtq/5RmWwMXMV0r6ekLC7DaGbMfzgO7YnEZMe1tqTn6OWCvQ5XF
    8W8M8dRtY2qYt6NTX1y1qL5+GKtpNq9r9G3GjmJ/Mfdcmy/PL3qQI5UfRe/tsizoESpz
    bfBCUOEnEoFUezpbm1WIKTNBcVVxX192ExR4n/O198Z4km94MndQlme9C5sq+LFxsVLM
    Ricg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757452408;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CUj2i9Nhh/zffwxX44crBTlL5KOdX0eYu04HgjoTLng=;
    b=UfSwGbINbzsekFJP8uXmh9R18vkHXPT/2w3o3zJqsA/ScWZ72Dm0xpe2Ai08zXx9O7
    OH2sEwdH+qo1E/zLLFAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQL4pZWJy0MjKRoF1oCKjjkm13AGu0+zY="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c9189LDRXSK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 23:13:27 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 2/2] mmc: core: Improve RPMB frame handling code
Date: Tue,  9 Sep 2025 23:13:16 +0200
Message-Id: <20250909211316.1857198-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909211316.1857198-1-beanhuo@iokpp.de>
References: <20250909211316.1857198-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Simplify the switch statement by combining RPMB_PROGRAM_KEY and RPMB_GET_WRITE_COUNTER
cases which have identical validation logic. Add RPMB_FRAME_SIZE macro and replace all
sizeof(struct rpmb_frame) occurrences for better maintainability and readability.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index dd6cffc0df72..7fe9e8cc1ce4 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -121,6 +121,8 @@ struct rpmb_frame {
 #define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
 #define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
 
+#define RPMB_FRAME_SIZE        sizeof(struct rpmb_frame)
+
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -2864,12 +2866,12 @@ static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
 	 * The size of an RPMB frame must match what's expected by the
 	 * hardware.
 	 */
-	BUILD_BUG_ON(sizeof(struct rpmb_frame) != 512);
+	BUILD_BUG_ON(RPMB_FRAME_SIZE != 512);
 
 	idata->ic.opcode = opcode;
 	idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 	idata->ic.write_flag = write_flag;
-	idata->ic.blksz = sizeof(struct rpmb_frame);
+	idata->ic.blksz = RPMB_FRAME_SIZE;
 	idata->ic.blocks = buf_bytes /  idata->ic.blksz;
 	idata->buf = buf;
 	idata->buf_bytes = buf_bytes;
@@ -2893,32 +2895,27 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
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
-			return -EINVAL;
-		write = true;
-		break;
 	case RPMB_GET_WRITE_COUNTER:
-		if (req_len != sizeof(struct rpmb_frame) ||
-		    resp_len != sizeof(struct rpmb_frame))
+		if (req_len != RPMB_FRAME_SIZE ||
+		    resp_len != RPMB_FRAME_SIZE)
 			return -EINVAL;
-		write = false;
+		write = (req_type == RPMB_PROGRAM_KEY);
 		break;
 	case RPMB_WRITE_DATA:
-		if (req_len % sizeof(struct rpmb_frame) ||
-		    resp_len != sizeof(struct rpmb_frame))
+		if (req_len % RPMB_FRAME_SIZE ||
+		    resp_len != RPMB_FRAME_SIZE)
 			return -EINVAL;
 		write = true;
 		break;
 	case RPMB_READ_DATA:
-		if (req_len != sizeof(struct rpmb_frame) ||
-		    resp_len % sizeof(struct rpmb_frame))
+		if (req_len != RPMB_FRAME_SIZE ||
+		    resp_len % RPMB_FRAME_SIZE)
 			return -EINVAL;
 		write = false;
 		break;
@@ -2926,10 +2923,8 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
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
@@ -2943,7 +2938,7 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
 			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
 
 		/* Send result request frame */
-		memset(resp_frm, 0, sizeof(*resp_frm));
+		memset(resp_frm, 0, RPMB_FRAME_SIZE);
 		resp_frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
 		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
 			  resp_len);
-- 
2.34.1

