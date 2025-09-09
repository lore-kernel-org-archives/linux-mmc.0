Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A81C68F
	for <linux-mmc@vger.kernel.org>; Tue,  9 Sep 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452600; cv=pass; b=TI0Pup+RMEPmD3IFrymwK7Emf2z43hUulJOQfYFfT7YDdT/Uo5rF4N8agFdMUpHexx6OnLdK/Diqr0wvaxLNNnMKqX6Ip7PBaIizJia+iMEY0YCMht8/aD7H1J49TxbVLifWuQ3TuvoT5NnnUP35m7SIbVkVkVVeCv28crhrapY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452600; c=relaxed/simple;
	bh=3mSbGyEhe+MJb5L1VfUQl/K2t5pRp12eJJeSGx/4les=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nv8rlNHAUAAHjCViCo3GRG1sAIGBi8kJLEU3KH8IRMharQgkCD2YlOCEMAQjnQkijPtAvfx6Gtbe0/CLFn19fNnX6nTbiOQUWst+5Ba57QoBwp9Y3QUICHZxl7jhjablykp17wQ2t7vOOI1UaWPwi6lQQP/ZJHrHGiQNL0W+F9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=HDxRSs1x; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=zLe9kR6G; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="HDxRSs1x";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="zLe9kR6G"
ARC-Seal: i=1; a=rsa-sha256; t=1757452407; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sx2Bnv+5+c5t85J3Sog0tL4AqsZBK6OTrEuJng8KkzjGQg8Qk8bsXKlgOXpv8rxiXZ
    q6H5Cmc4UJ9Ku9kVw2VjEtEw8rxMtGDznn7ounoRAnp+xXaD/fnGz/0mVZEah2LuVXHW
    r8wFJbcEjcZd0ZtHsJxttKLWMqCWSFiYbiExrOs3igj5weF2CJ1RRgJmupRmCMj4uj5V
    Mh+vByoDfYVMRv+/WDxRpwDTdlO8m3j5/tFAphfyzeGKJBpswWD9Mdxf4cNYQGlOXDUZ
    DYWombDmHW86QYvVAvX9j+MA+ofiDjXaLhVN2+3AAlCmC1Z5zlV2bEQti0zp25Wf+XQb
    TpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757452407;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=glYq/Vo1u5gdz/zyG7jCzkaVwuPr0szmEZG2wFYLGGk=;
    b=WjXUSSGWqklvhzTDbVlj/cs7qNHz6TasftFmLfkpwdrUwjO+04J2jQ6+Yx3hmLoyN0
    +S6ZHv4s1uXG7RMRHubUR+uPdXqNHngjeGPb1Z+EBV0IxRVsY/BywQv5+U/o0zMvLtBo
    HWi28Zm6956fCVnE+hzKcZmdJU6dY9ikg2pKBhvjqbn+amZeuW8O0UiU6f2hWPpEHO4H
    1fipoytTQY0kjnCVvFxXy0XETYfwbhbAZv2m4bR2bqfLDGdM7mU+y2SJIcv1o5FSj3o8
    njOXYR+2PtKQg6vUFMYpq69FWrG1+MYUsF8V0Ul62rt4c1AVb0hjLeY5AMcxrPCO66m1
    yL8Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757452407;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=glYq/Vo1u5gdz/zyG7jCzkaVwuPr0szmEZG2wFYLGGk=;
    b=HDxRSs1xm/WLn/CwBppVusaDZSaaaPAmbl/TC8eDTjpEC/fhumYwT98T6mxRM9JxGz
    qgKNJA/6PKhNhO2ZYCN8iS8fTwVLIDPsjWTIEvnIYxz/Sn698uam4/vZbC4dJ38/ut2/
    4PO4N8xNrNMbseClWn7WRquVV8ogiOL1yLToWt6ptoKPyv27zrxhXO5VqIS/eOKUhtUD
    TAQhPcPWD6t8bkEkZoOYK6oBlU2NT9/p0+Vn65LJ398lpP3SKG2Gyw4YCXCesBuDQhRF
    3IMXo7wTUU8jrxACSo9q7+e68ptFZyXYYnuG22j+oOiSKS5eXgpnJ+m1Mo77v/UxZc+j
    hHWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757452407;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=glYq/Vo1u5gdz/zyG7jCzkaVwuPr0szmEZG2wFYLGGk=;
    b=zLe9kR6Gm53Vyv9nt3E6uA/3uiKrvD7WOYtfpuizarsoF5Bo2jSo8QV4TDt5naRPWl
    p8nEOTLpe1v+u+eMV4Cg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQL4pZWJy0MjKRoF1oCKjjkm13AGu0+zY="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c9189LDRXSJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 23:13:27 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 1/2] mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
Date: Tue,  9 Sep 2025 23:13:15 +0200
Message-Id: <20250909211316.1857198-2-beanhuo@iokpp.de>
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

Rename the inner 'frm' variable to 'resp_frm' in the write path of
mmc_route_rpmb_frames() to avoid shadowing the outer 'frm' variable.

The function declares 'frm' at function scope pointing to the request
frame, but then redeclares another 'frm' variable inside the write
block pointing to the response frame. This shadowing makes the code
confusing and error-prone.

Using 'resp_frm' for the response frame makes the distinction clear
and improves code readability.

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

