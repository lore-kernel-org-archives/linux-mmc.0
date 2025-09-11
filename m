Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A782DCF74
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624962; cv=pass; b=PNEMYUvux6k6L1b+PbckkjLyYPgy//BDDdhEeAS4TxT5tbrqvokkHgaOSSlS2/elKV1fimbhNWPl9JEaK6zvY2fEeDsLnNsvw2gR+vjvzLs3C6h0/G9mpYEsapY1mKIj6emys4qksjQQoqcAAaLL1n0SDE1Oi5FMNID10EcNUNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624962; c=relaxed/simple;
	bh=SYi7Pzzaz76VSgfIECX5nbJ8/3hB8YjAHsGLSUrym2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmuZCm+H2OHMjek5EGSZW1umedidZs7yws8NKAa0omM1NgndF57yyC4arxAwTCvYWw9KEFjHhe16pZjXlFx6HqIBQv8VDAPCkzNIVbMqsUu0gJllFMao6zMsV5NAkBLEWLdZ5bd71kMK3jgtsvwIsc+IPGeuJy/AvVcL2Ykrgs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=n0hVJpzP; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=ye2vE3OK; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="n0hVJpzP";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="ye2vE3OK"
ARC-Seal: i=1; a=rsa-sha256; t=1757624774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H21gKNjMT3M3AqUCYzqojt4J6u3zRzq1MILKgxzpTgHVX/KJyy2YFOpvqacKauY4WP
    8A6HbQcLDSxa161E/ewFwdtO+OZykEYQMJ+wEgIf2O2PMU9pFMzS7Vx0HOR/Wt5VxUW1
    niBFioxMgPtb20MNuD1lAFx4SFgxyVohnmNRhP3MaZBwlENy/9oyjRgXD6rPIjXsh3Np
    0Oo4cpg2+7fFn6EaVrDI8kYriebpBSajKgSah9/bl0vsXJcSS0SJACHgUHVTCx0BxSEk
    tow9YThnAKlJhfy+3ETcOnSE8U1Z0060BCSniZ8iNZ0wYvls3CcCeR4gbTIcNURgO6g5
    tz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757624774;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x7/1WZTJ8IfFwkjqf5wuc+922MTh3F7jv4ISRGdQoH0=;
    b=UXznRWl/wVYDP+JcrvxRAHWYatEBEtQnlnuHDrPrUbgJFbV3IdyGSpi25PTcoI3pWZ
    D8+uXGtd7Ie4PfapnSiqeuZUkNXlKdE0gNQHWk26N69agRZkn7HocBny4kN1Pv+ePNY+
    QOIvX9ocancrpCL9WzrkSU02N049D7HNUXT1bkL4OQuNCJ8a++6B6oZg4kGy6W5bOUAX
    nc0ZEsgv4V3yujOu2E71IPT5W8Iqd2jGxZNuDv5Vxp/Wd3LPL3LzXblXPkpTAWgUr0RF
    iKMPgJGqcBb5AzFDCBE0xCgT3K/Ezvw2NJfMYneIgO3L20SRXJfjIj048blEn2dVHxcK
    tzVw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757624774;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x7/1WZTJ8IfFwkjqf5wuc+922MTh3F7jv4ISRGdQoH0=;
    b=n0hVJpzPeSK4lYBUrjWB3w8OsYXhTW4tDuQxuYDguifCvl4KOt/1VEZI4X+fSe8qse
    Qk0C4u1XGxJypoL/Dk98+10BS7Xb26XlpT9X8f+i/7mAi2WbQrAmQrs/PhL8Ux+3+ypZ
    uDQ3xxaU8ZjldKcO8EMK7nVTRwLo2qb/yTV1kMk4Kd5Hg9vk3NfqSWjNxpTcNdykVxW8
    Ycv0sYfetWT0FvcGr8UxFwTUYXijJSjJsEg9wZtfccSj+nu4V2tktlAMQmTmvquqM4l7
    daeVGYS5UyoBnb5NEatZg+IZmkZY8ksPhVHCWb+EYsKHDY71PFM9d++2Ov0k+magnfwQ
    1gKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757624774;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x7/1WZTJ8IfFwkjqf5wuc+922MTh3F7jv4ISRGdQoH0=;
    b=ye2vE3OK0T7DjXPSPhvLq3EykGyLAcjmc+1pFgdDacB28crZhvDRyBkqAlidBXXuXW
    wTN4hrOnRAG7uq9hMWAg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQfI1ZDZOzYzKOl2SdacNvyFh1H/ghUw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918BL6DhgK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Sep 2025 23:06:13 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org,
	Avri.Altman@sandisk.com
Cc: Bean Huo <beanhuo@micron.com>,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v3 1/2] mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
Date: Thu, 11 Sep 2025 23:06:05 +0200
Message-Id: <20250911210606.446355-2-beanhuo@iokpp.de>
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
 drivers/mmc/core/block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
 
-- 
2.34.1

