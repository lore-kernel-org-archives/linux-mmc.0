Return-Path: <SRS0=q8Wp=7D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CBCC433E2
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 15:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A019120849
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 15:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NDA5URa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgEUPYC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 May 2020 11:24:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43322 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730245AbgEUPYC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2020 11:24:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590074641; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hed5X6RlvHP5iun0h6cacBLjIzbJ+Q/7Jlx/w5qDseg=; b=NDA5URa0Wr+sQd6q4JaZHipsFkWEPACl181F6ELl8m4b47WsFwJPZPdIY4nxxQezc+FWT4hK
 2QTcqWsoT4FsUPef5F32oBJpCxqDczoEQaKydsQ76P5xYHaKyCgD5QtwrVxbl9uEpXeupgM0
 /CZ9dt1vzotSALooE0dW4xaxS50=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ec69d10eb073d56918be5ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 May 2020 15:24:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65992C433AF; Thu, 21 May 2020 15:23:59 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4E06C433CA;
        Thu, 21 May 2020 15:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4E06C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 1/3] dt-bindings: mmc: Supply max load for mmc supplies
Date:   Thu, 21 May 2020 20:53:33 +0530
Message-Id: <1590074615-10787-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590074615-10787-1-git-send-email-vbadigan@codeaurora.org>
References: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
 <1590074615-10787-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Supply the max load needed for driving the mmc supplies.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 .../devicetree/bindings/mmc/mmc-controller.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index acc9f10..9058b82 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -290,6 +290,22 @@ properties:
     description:
       Supply for the bus IO line power
 
+  vmmc-max-load-microamp:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 1000000
+    description:
+      Maximum load for the card power.
+
+  vqmmc-max-load-microamp:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 1000000
+    description:
+      Maximum load for the bus IO line power.
+
   mmc-pwrseq:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

