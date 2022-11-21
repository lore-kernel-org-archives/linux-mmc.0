Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C0C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Nov 2022 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKUK5o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKUK5n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2022 05:57:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7BDF23
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 02:57:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so8728776wmg.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8WrJz8EiuHEjxV1Xn64IJtBPrgz4KF0qS2hg18uHrQ=;
        b=fuR281IXgRaEoXY0jzMjK7NI+8lWtnlcDl1fnMKuAnTeI5rV0kF2k3AkU3wUEQfjNI
         1BepfMm5itsKxgf6rM0D+vf+FGGairj0fv2w8S+jjrNrA7cCOYIarBTo1jr7zsZ9/mIH
         zWS2wHlRMD1eIOHPw9BDJArksuNlNS7RDlSdKarHrxmqT4v5xvujj/er7gUHV8msVOcE
         JdQYonisslukhVHR2Io+UaEO+jUGYDQNiYhMJRWP03ZfznWQVu1r1vSEeSZSnvfXXgof
         pbxHS1KZM9NnAJeUpMF5sUv31iEYxWKPDK65vXIj9TXUhjMl0ud1XS7elkUq+9r3Sy8j
         54dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8WrJz8EiuHEjxV1Xn64IJtBPrgz4KF0qS2hg18uHrQ=;
        b=d7ZyojHSahwRbfsHMnUasuFJkWk77MOi7rPv3GJiepbtRxT0iwyd/QvmQ/7RDdhX3E
         egDV2WMr82GMbp6kERHzpDeXebffNB9CbIRXhN53WmuIpQ9z6r2VtBWtXol8SSOX/UU5
         stlwdXwfVo8q5P2B7ZADXFbx4Xn+CYanMT7GwZH5EoOUNpgqdwjJFhrPRxMBg7JFdzrz
         Ovhax0Mg1od1ne0NYRwvdAknyv35RtHaCzR27hWSAMAng63ccSvyzOIUQndv9eNpQIJ/
         5fbIh5ZOc9wWyCeHKbf37iGbOumv94bjeMwx2WTamcyiwAefVrS26XMtolJX2MzkFOzv
         eGbA==
X-Gm-Message-State: ANoB5pm6tw7IC6j+oD9dMuhsyhs4CjWBP1iNI0Og8WG6WfE2Kt2wQd13
        nO9eizTZ6Gq7Xpu/AhJpoBwEj/UDKOWy
X-Google-Smtp-Source: AA0mqf7AHquxMW6GZVRHPHyeA3xgdX6mPEpgcnuxkYBleGpSsJCtYbcQQHCRuB8E0FVkmZws8ZqwXA==
X-Received: by 2002:a05:600c:3c95:b0:3cf:92cc:9e5f with SMTP id bg21-20020a05600c3c9500b003cf92cc9e5fmr12028297wmb.181.1669028258660;
        Mon, 21 Nov 2022 02:57:38 -0800 (PST)
Received: from v2202209183747202483.. ([2a03:4000:54:fac:a8fb:beff:fe0f:de18])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003c6f1732f65sm19886730wmp.38.2022.11.21.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:57:38 -0800 (PST)
From:   Sebastian Falbesoner <sebastian.falbesoner@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Sebastian Falbesoner <sebastian.falbesoner@gmail.com>
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check
Date:   Mon, 21 Nov 2022 11:57:21 +0100
Message-Id: <20221121105721.1903878-1-sebastian.falbesoner@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DB7PR04MB4010BC0CBF94753397A8EB9A900A9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <DB7PR04MB4010BC0CBF94753397A8EB9A900A9@DB7PR04MB4010.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With the current logic the "failed to exit halt state" error would be
shown even if any other bit than CQHCI_HALT was set in the CQHCI_CTL
register, since the right hand side is always true. Fix this by using
the correct operator (bit-wise instead of logical AND) to only check for
the halt bit flag, which was obviously intended here.

Fixes: 85236d2be844 ("mmc: sdhci-esdhc-imx: clear the HALT bit when enable CQE")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sebastian Falbesoner <sebastian.falbesoner@gmail.com>
---
Changes in v2:
- added fix tag and ack from Adrian Hunter

 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 31ea0a2fce35..ffeb5759830f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1512,7 +1512,7 @@ static void esdhc_cqe_enable(struct mmc_host *mmc)
 	 * system resume back.
 	 */
 	cqhci_writel(cq_host, 0, CQHCI_CTL);
-	if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT)
+	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
 		dev_err(mmc_dev(host->mmc),
 			"failed to exit halt state when enable CQE\n");
 
-- 
2.34.1

