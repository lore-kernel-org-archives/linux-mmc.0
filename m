Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A79C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Feb 2022 07:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiBRHBM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Feb 2022 02:01:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBRHBL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2022 02:01:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753FE60D4
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 23:00:55 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so12748171eje.10
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 23:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=c1WC1LBRmsTFGHrhhnaB9ccaJjMWkQMbdtbNl/QaxdA=;
        b=i33n2QmH0Mel44H31uNtlfpIdmOAfeIpHc4ugLWJNbIJHRJCW2O1RoFSG1klyHuIU4
         /iIJfw3O/i224aq6bScxzxkbw23A2gT9LCQvuDFkKVYOcYFW90FJ8r5pALsR2nbDPvTv
         IbzvZ4HI1aODQB0zW4FLwAb/+BBSsrwgVvGPzbGaeEsTQwMPugr9wI0GQsH6gfd+6IGA
         82LjkOIVHp0da6ouQcgg88JqT6KtoAYqfOE+mUSeqlhA5JU/5KcCe1ASTA9AOc49hW6d
         E04cagiliZFytMTTBAegYrM1xSJZn8MG6IfSYzj1xOmRap80Gb0edJqLONIX39Fv/hXA
         gWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=c1WC1LBRmsTFGHrhhnaB9ccaJjMWkQMbdtbNl/QaxdA=;
        b=nie46oCfly8JZ5q9exgVSio+fPcH+nGZiic02bzwBSQsy8ChxUX+Hn3Zd7y3SGmMov
         V5B0nIK3p658Hx8jU8S3+MlDxwX23cBe3cFnL/jo8RDtkImgYQQJAtal8mW1ZKG3CpN9
         rebK/25ZIhKALq4xa6gsK8u+qMtnm1RMn7VPAIDf3tnPBWOeZa9lDCJCT1Z1a7Lx6gI2
         ICplYnZhIBU6IkhTm2sXNHrHlCwr+LAFmsMcxCUuF9Wem7WVMC/IGzoyHV3PzUersJJL
         BFFfyYMikZB3jnXkAU3ky5ptU9Yv/S8ByfgByPUNADELKVefz9sBycHROX8lXHBaOXFL
         Oglw==
X-Gm-Message-State: AOAM532LuWUneycrJXATKiI+9bV3yKws8CCDr1XnPOaF/F43az9iwwE4
        KnAbCNAe9CiNTcOoLSwvKkJ2kI1Nr2U=
X-Google-Smtp-Source: ABdhPJwSfR8cTktW9ZW8hrLtYSg5KMAtJ4d9Ncf+vbHv759ukS7PQ/0Wd7MDddcfZYYXlmsca9Yu6A==
X-Received: by 2002:a17:906:f1cf:b0:6ae:9992:484 with SMTP id gx15-20020a170906f1cf00b006ae99920484mr5230915ejb.607.1645167653935;
        Thu, 17 Feb 2022 23:00:53 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:dcd6:5131:2794:470e? (p200300ea8f4d2b00dcd651312794470e.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:dcd6:5131:2794:470e])
        by smtp.googlemail.com with ESMTPSA id c6sm1893387ejs.130.2022.02.17.23.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 23:00:52 -0800 (PST)
Message-ID: <fae9ee4b-6b93-95ac-abf3-f97c62e07b9d@gmail.com>
Date:   Fri, 18 Feb 2022 08:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: core: improve fallback in mmc_select_timing()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I have a system (cheap Amlogic S905W based TV box) where the eMMC chip
refuses to switch to HS200 timing. That's not nice, but my bigger
problem is that the system then falls back to the very slow default
mode, even though DDR52 is supported and works well.

Therefore, if setting a mode fails with EBADMSG (switch error), try the
next (in descending performance order) mode instead of immediately
falling back to the slowest mode.

With the patch it looks like this on my system:

mmc1: mmc_select_hs200 failed, error -74
mmc1: new DDR MMC card at address 0001
mmcblk1: mmc1:0001 DG4008 7.28 GiB

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/mmc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bbbbcaf70..c0272192d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1523,11 +1523,23 @@ static int mmc_select_timing(struct mmc_card *card)
 	if (!mmc_can_ext_csd(card))
 		goto bus_speed;
 
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
 		err = mmc_select_hs400es(card);
-	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
+		if (!err)
+			goto bus_speed;
+		if (err != -EBADMSG)
+			return err;
+	}
+
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200) {
 		err = mmc_select_hs200(card);
-	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
+		if (!err)
+			goto bus_speed;
+		if (err != -EBADMSG)
+			return err;
+	}
+
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
 		err = mmc_select_hs(card);
 
 	if (err && err != -EBADMSG)
-- 
2.35.1

