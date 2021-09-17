Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6CEC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A8D60F21
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbhIQR3E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343988AbhIQR3D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 13:29:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE759C061764;
        Fri, 17 Sep 2021 10:27:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s24so7911791wmh.4;
        Fri, 17 Sep 2021 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALoBWaWV7jtCqRbGUVPAv75PEetKCqXCAn6SGuf3CPQ=;
        b=hfmZa6o3msrRRDWRzDSGlKKb3/zofRhELYAB7KdW63iFI1KBlxsYXJ2RrSfCf1pA3i
         SwaolNQ+1oENric+GAhhKBHvS5ihJ90k04MLmhro9OqUDkhGXyjDwgvp728ZtGofTKvW
         TeppU87f++S0Fbfhbo8gCWnMcTecI8h5nv5cCTt2xu8330bZHKgF6xEnaVGlhANFVcRH
         jeqskdwMjYgb7Pc0bjc1jDe1iqF18e40jLmhU6Woxh6vxDQt8RFobF6z+EuVv+5HZSv2
         V8judbdkMUP/OaQWZWndJjonLJJYooi7KIQhlzmV5GM2sfsb7NNqgImAhPLXX2iWmgWx
         06jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALoBWaWV7jtCqRbGUVPAv75PEetKCqXCAn6SGuf3CPQ=;
        b=JVGTk+UrkHtrA3uHy2c2D7WpHmYrUNcOt4hMdhfTje+U15vp2pSIEO6ZUpDdHdDezR
         p45Rz/c0vACO/PN14nZRrbrmSw+ck8QN9poxeTt9CkJ7Di2JO2gi8ZcfioWA3jfBf8MF
         74CWs7i0MgOkmo0XfF7VWWEiz7+g8amUcmSZks1GUy3KJANek658tm4+Gtn1cfRJrnks
         temn0J8tiwjwjHTuNmWt8bKWedwX0zjjFDIfc4OohHFRmfF4Rt1Psv1Xln4rEut1dHcQ
         O/NI8/0tvkCoi6f9ATouH3nKxxOWmxh4ySk3k8qV3UWrD2ToeMnP09lKs+veiLs349BU
         vjKw==
X-Gm-Message-State: AOAM530DDaTsQ1ZU+gKcLQSrrA7zfuWvegx9jm2pFV/e4VzWXm1viUHu
        zKMu+BtPV/8P5Vg90Z5qUv8=
X-Google-Smtp-Source: ABdhPJzpFCTOT3+hvrV+KLsGUNUODYFMtpIVIXJqH4rfY50hNbvyWQTNBDZquyANgC2MKWKqQ4eTig==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr16177279wmi.148.1631899659530;
        Fri, 17 Sep 2021 10:27:39 -0700 (PDT)
Received: from ubuntu-laptop.speedport.ip (p200300e94717cf050f860509a8ecdb17.dip0.t-ipconnect.de. [2003:e9:4717:cf05:f86:509:a8ec:db17])
        by smtp.gmail.com with ESMTPSA id 135sm2901947wma.32.2021.09.17.10.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:27:39 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer cannot meet the timeout value required by the device
Date:   Fri, 17 Sep 2021 19:27:27 +0200
Message-Id: <20210917172727.26834-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917172727.26834-1-huobean@gmail.com>
References: <20210917172727.26834-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

If the data transmission timeout value required by the device exceeds
the maximum timeout value of the host HW timer, we still use the HW
timer with the maximum timeout value of the HW timer. This setting is
suitable for most R/W situations. But sometimes, the device will complete
the R/W task within its required timeout value (greater than the HW timer).
In this case, the HW timer for data transmission will time out.

Currently, in this condition, we  disable the HW timer and use the SW
timer only when the SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk is set by the
host driver. The patch is to remove this if statement restriction and
allow data transmission to use the SW timer when the hardware timer cannot
meet the required timeout value.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/sdhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 357b365bf0ec..463517fd9886 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -969,9 +969,6 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 		count++;
 		current_timeout <<= 1;
 		if (count > host->max_timeout_count) {
-			if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
-				DBG("Too large timeout 0x%x requested for CMD%d!\n",
-				    count, cmd->opcode);
 			count = host->max_timeout_count;
 			*too_big = true;
 			break;
@@ -1016,8 +1013,7 @@ void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	bool too_big = false;
 	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
 
-	if (too_big &&
-	    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
+	if (too_big) {
 		sdhci_calc_sw_timeout(host, cmd);
 		sdhci_set_data_timeout_irq(host, false);
 	} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
-- 
2.25.1

