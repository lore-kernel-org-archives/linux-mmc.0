Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E362C6FA86
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Sep 2022 01:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiINBke (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Sep 2022 21:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiINBkY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2022 21:40:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E46DAF6
        for <linux-mmc@vger.kernel.org>; Tue, 13 Sep 2022 18:40:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d12so13610986plr.6
        for <linux-mmc@vger.kernel.org>; Tue, 13 Sep 2022 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KCj2JZhUIlc2QtoOnWJCVSUQllFdWStECUChjU/ENkM=;
        b=QoFzBSfh8I5qKUc3oiR5VDOzyaxYVfSz8gA+UwQWkYigZZSyqT4xezLzsZHdr0nLNN
         s6prqoijgK5ssjlGtYChnABIcRZclmJXrxuDRTUjJEjD3hAhacnzOHOgNmbYF7XUAuHS
         Y0g3mk+sx8ecGVhRH2tD1p6O1Fa7M+rSpF2gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KCj2JZhUIlc2QtoOnWJCVSUQllFdWStECUChjU/ENkM=;
        b=w2vUUf2LpPH203p8bPeFl3osC7iry6iPKq7WFKM3/CbJ1rjhIdQ1O0hH3WC9iWWxkQ
         mKswGtEV0wa/8ksm9BbQzmn6KJ2W2jpEkbRkeL/oDbZTChyuFoTajJYv5WUjAbSJ66fj
         mIkttLY9FcqiRs/HCHVbs/rGOPFunD9OQB20Mep6SeWMdmfP2H5kcAcVhEsFrc+6UTpY
         Ww4vh9+pXnv93aCbI26xUEE+l/bWuvOkd84VFpxcFWnCNCSBV2eVH+8AvyJzjKbH2U/V
         FymNWFI59Ui7AF4rrREuIh+pK7pMsjNGopVoNkuADS2/t4yDvTfjafCUw51PiH/usYQ5
         5Kdg==
X-Gm-Message-State: ACrzQf36gdy83ecId+lGUn7q6XjAq39rnj8uOtHHzB1OUleHbe/MqM+V
        V0VJC1gf/xlrFI4SliOPEP4iYA==
X-Google-Smtp-Source: AMsMyM6xb9Xs+R2n31o4v660yqssLLBb7p9bFfIProsVZH9e3LzA6espTlaQIqHoyrrr1pQEj3zGXQ==
X-Received: by 2002:a17:90a:4402:b0:1fd:c07d:a815 with SMTP id s2-20020a17090a440200b001fdc07da815mr2104374pjg.188.1663119617833;
        Tue, 13 Sep 2022 18:40:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c6e2:a019:5c54:fb4c])
        by smtp.gmail.com with UTF8SMTPSA id n18-20020a170903111200b00174d4fabe76sm9137227plh.214.2022.09.13.18.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:40:17 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>,
        stable@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>,
        Chris Ball <cjb@laptop.org>,
        Philip Rakity <prakity@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] mmd: core: Terminate infinite loop in SD-UHS voltage switch
Date:   Tue, 13 Sep 2022 18:40:10 -0700
Message-Id: <20220914014010.2076169-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This loop intends to retry a max of 10 times, with some implicit
termination based on the SD_{R,}OCR_S18A bit. Unfortunately, the
termination condition depends on the value reported by the SD card
(*rocr), which may or may not correctly reflect what we asked it to do.

Needless to say, it's not wise to rely on the card doing what we expect;
we should at least terminate the loop regardless. So, check both the
input and output values, so we ensure we will terminate regardless of
the SD card behavior.

Note that SDIO learned a similar retry loop in commit 0797e5f1453b
("mmc: core: Fixup signal voltage switch"), but that used the 'ocr'
result, and so the current pre-terminating condition looks like:

    rocr & ocr & R4_18V_PRESENT

(i.e., it doesn't have the same bug.)

This addresses a number of crash reports seen on ChromeOS that look
like the following:

    ... // lots of repeated: ...
    <4>[13142.846061] mmc1: Skipping voltage switch
    <4>[13143.406087] mmc1: Skipping voltage switch
    <4>[13143.964724] mmc1: Skipping voltage switch
    <4>[13144.526089] mmc1: Skipping voltage switch
    <4>[13145.086088] mmc1: Skipping voltage switch
    <4>[13145.645941] mmc1: Skipping voltage switch
    <3>[13146.153969] INFO: task halt:30352 blocked for more than 122 seconds.
    ...

Fixes: f2119df6b764 mmc: sd: add support for signal voltage switch procedure
Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/core/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 06aa62ce0ed1..3662bf5320ce 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -870,7 +870,8 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	 * the CCS bit is set as well. We deliberately deviate from the spec in
 	 * regards to this, which allows UHS-I to be supported for SDSC cards.
 	 */
-	if (!mmc_host_is_spi(host) && rocr && (*rocr & SD_ROCR_S18A)) {
+	if (!mmc_host_is_spi(host) && (ocr & SD_OCR_S18R) &&
+	    rocr && (*rocr & SD_ROCR_S18A)) {
 		err = mmc_set_uhs_voltage(host, pocr);
 		if (err == -EAGAIN) {
 			retries--;
-- 
2.37.2.789.g6183377224-goog

