Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8900C64ED8
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 21:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjB0VC3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjB0VC2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 16:02:28 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0D423D81
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 13:02:27 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec43so31210703edb.8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 13:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy9MOuCYV5VNfajEJwG4p7UWSH7l35doRasnUcnGpDU=;
        b=G0cLESHhsWbJAxMgmHwTgG/nCwBUVbt2Op/UQUyIzAAig2NcO55zE3CRviTz1vhYI8
         L4J2br3NmgFJn38dMn9eGN0tSDujLpnCbfdF2aTdeRdLBjHsKh46lCtj63IvqMxR7M9s
         7CRuaPUolp0SVnjG64lQ6J2PpsiWD2IgnPt5URQkCmrCsvV+ii9Z0NQJWzz31Z5f44KQ
         h8jZ8pd4FlWccBYjglyHK0JZUuyGb8nZoMJJl0qBO1K/0cqrt7RIfxlExVR2ipbfF17W
         tZ82opyiF6obZHr9OyNlxVmwicbN8s1/MQTRQRQ8KWWj3VBWy3LT89ogqt0mmAEwqLHU
         5E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jy9MOuCYV5VNfajEJwG4p7UWSH7l35doRasnUcnGpDU=;
        b=NfxoaTaxhfraZK26b3lUcbTjsVk8yR/nq6ujiRx7GcKW/Ho1fbih1afQ1SgG+KNGGs
         M9qKgGxaZiCs9TzSz3YidRYlCyJmRdWrgf9E4JX6eP4i/k7+Aw9R5bpgb7AzpWImZ68P
         KNaR3AmDYS92aAwYYjN+xXu1w4wPKsg/XnteERVvtUKBKRGSgayCBvPAHeVci6wX0J7C
         jbV+XSfVPsrybPP3ZUCdxtDkYz3hsMcSIBC9OGGVkCvlX5xhs2tWEcPhZsEOhdR/KbaW
         BNgciHkb++poDFIgUhEHPeIT0JlCCWpYuLqa7TxYs/fV5wEWQCyqEYIhIPd71Lbvv00B
         5qHA==
X-Gm-Message-State: AO0yUKXewaVZRMg7R3rZLSDfTQVg8xgy80aKY20FLZiF1gv/buVx6TTC
        euwI93nxtShRqXAJAxfPpRlOOtf/bjA=
X-Google-Smtp-Source: AK7set8d5PCYJqJc7yEmjCutFbDlE75su16K9Ic3OxhRIvalix73Rgyaho6/PJtbCUmBVbIpQwM0Ug==
X-Received: by 2002:aa7:dd4b:0:b0:4b1:b71d:cbfe with SMTP id o11-20020aa7dd4b000000b004b1b71dcbfemr1085619edw.2.1677531745364;
        Mon, 27 Feb 2023 13:02:25 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9e4:5300:7c04:7bb8:89f1:77e7? (dynamic-2a01-0c23-b9e4-5300-7c04-7bb8-89f1-77e7.c23.pool.telefonica.de. [2a01:c23:b9e4:5300:7c04:7bb8:89f1:77e7])
        by smtp.googlemail.com with ESMTPSA id m19-20020a509993000000b004af5152751esm3556400edb.83.2023.02.27.13.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 13:02:24 -0800 (PST)
Message-ID: <0c1e7440-f4bc-b48a-137f-58b75ac98550@gmail.com>
Date:   Mon, 27 Feb 2023 22:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: core: allow errptr supply argument in,
 mmc_regulator_set_ocr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Basically all host drivers use code like this:

if (!IS_ERR(mmc->supply.vmmc))
	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0)

Move the IS_ERR() check to mmc_regulator_set_ocr() to simplify
host driver code.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a46..4fad81cd5 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -110,6 +110,9 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 	int			result = 0;
 	int			min_uV, max_uV;
 
+	if (IS_ERR(supply))
+		return 0;
+
 	if (vdd_bit) {
 		mmc_ocrbitnum_to_vdd(vdd_bit, &min_uV, &max_uV);
 
-- 
2.39.2

