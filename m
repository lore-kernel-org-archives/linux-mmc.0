Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E6226D1D
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625498; cv=pass; b=J7/iogKsUoTtV8Ljd3YlaJ6OyI1BUEPcwI+9G1lzIF5InNFDDWGatXU99+1b1hbFboJ2/MgClZNfJitHvwhzSn6iEd1dnfjPChZ5VesN0xAWInUa/g/8TGNQnxrHIzQRf0X6AFuFUX+3kZaHHZk9Tt9p0JC4/Lg4MKQZLZGfk4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625498; c=relaxed/simple;
	bh=BTywOtQLHQpsMqwU50SKbzjM59Z+Ql/iOCOPMBfLIvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGbW0j8xUGK17cpaf7vWXMiwV0Iy65nrJ9bYtty4G1jQom2WL5VwP0qzIylgJQFAaAPV0pTdE72dpDll94c5MdTbjCqY079WCG3j9M0lxPTUQF8X1XT8DnSfke3zkZ7Z4wky+NGOjkFlPNNJDIZcVNHtX9PgmnZSciyNai6OhDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=QLfMn5EH; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=0ha+FqRn; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="QLfMn5EH";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="0ha+FqRn"
ARC-Seal: i=1; a=rsa-sha256; t=1757624774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AgmWYehgL+IEIbjm4No5tJly67LrXizu2r1bRUBoZjjzbce5mhVN7EYGlLLVMYMFa8
    w6WMUiEjLb5u9ZbLOuRxsITip5BNAIOX+oH3jvvAvnQQ5p7fRq1uSMy60Qk01PXm8Xk3
    rsBOiz7gkVdmu3vZcDwwC8Kpr6ZZQcklTkakGFDNMkSn8zNJ3YuuiCPUqgBgBcqBnH6C
    8XUOBxCDkcmRgVDvoVnBKaoPGBMMV2em1ZBqJVwRhQ91Pr3oTjio7Djrzm3Wb009JJ0l
    XVouXaC7qbKaSKUnQs2tuHDDfILzQnbzUSdEIm3TJR6lkqqNkY8sQyhNjXIUTZXlo3D9
    Gprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757624774;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rFE1N+SKv61IRj1qppOls8RqTuuJaKTkMbB2/2nCwg8=;
    b=XVJS04eam4nZFH9r+rkyBR2eQ1LwGMDbapg11H+GuVylXoW2ea42giGFiWoNgfA23d
    Tc/vzZJu6LacZwYeCfIRosWwknOkeg0p52xiVpwx6z82mQ2yK+iNC4Uv+G7Y3H8+Cc9o
    YW3VMP2M+R46q3m5JPPVnBACa0T2i+j1xorbtSG1oiMr60bkt6m++fCV5yZ+6Pu44lmr
    KsTeHYeUcI7EAcgtYR8HUmYi113c7RVQ/Y8hhqq8Sz9EKKMGWkStNZ8zbEdV3bwb6awf
    kHeZ/o6hGq1xY8nQl/5v2+4RTLb5l21npPdtyEyaYbWEDP3y60a3CIM7Liz2GDIrhS1G
    JXNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757624774;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rFE1N+SKv61IRj1qppOls8RqTuuJaKTkMbB2/2nCwg8=;
    b=QLfMn5EHfreIhgnF2zkwIG5t5FeJqw8h7r93eLl4Y055bZKmEQwGmYrlU/mOtSVseV
    JniP1sthmYGle08p59V6kUhm85ZF71Wrt7ocXl6hPa6qx3dpNhgBIboJqscyqK8fNH3B
    iq0HHM484s5LH/s8tfAttAvof/WPhOPbgNYRwF6f+g/Ct/Blq9/NKuuWewa2Cwsl0S6O
    XEbx7DyGnPtkTBjNpFlcxZRvQ8sk7GQMr3+Di2uoX8Ed2jovgXq9T8tqSGcU3m1HBW7V
    7nX1VR/XqeGxYvC71g046BcBAeXkviKLD3U1w+kRJ4738WQWXPQg5AtnwZCr8UV8ni0n
    SSKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757624774;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rFE1N+SKv61IRj1qppOls8RqTuuJaKTkMbB2/2nCwg8=;
    b=0ha+FqRnQwfDqrCKYlNCwNjAaa+lNvh0u/pmZ6UIwAePt2iIusDmsaIxjuCKLLWyTf
    tizmfH0bHX1y/LmoCuBA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQfI1ZDZOzYzKOl2SdacNvyFh1H/ghUw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918BL6EhgL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Sep 2025 23:06:14 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org,
	Avri.Altman@sandisk.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 2/2] mmc: core: Improve RPMB frame handling code
Date: Thu, 11 Sep 2025 23:06:06 +0200
Message-Id: <20250911210606.446355-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911210606.446355-1-beanhuo@iokpp.de>
References: <20250911210606.446355-1-beanhuo@iokpp.de>
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

