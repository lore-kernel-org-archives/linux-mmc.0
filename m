Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C78DC433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 08:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E991A610A2
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 08:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhETIaM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhETIaM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 04:30:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399CDC061574;
        Thu, 20 May 2021 01:28:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l70so11341844pga.1;
        Thu, 20 May 2021 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNwm3g2gLFqW8k/J4MYUNInnUysaFCvyxZVIOLPuoQA=;
        b=ZFaDgpVXYaNuSzlkV41plByij9nWPuAmXof4XR1HU6+duXJoJBuV84GJ01CBhu2DXO
         933HcUeKHcxoefuhn0we4XLpvgN75gjSnrxn4dz1FB4zttZDm/cE7/fGbP38Yc+nBor1
         L69JxyKZmd6paywpYWgSbwfLbJVvKGlgjQQM83bZRa3StxCsgfE3F4DVOS2mSFHqY031
         OMGtz9ZyL3q/0jffnUVOeDJAdaJ9v4DAlXEFChMHqqFmfGzpl7hMQD9PQheoKsxbOSUK
         x/Y/qDMDdp/ebhsmCo92XvHvthdIb0m9qLqMqEYkFu9ExZ6wjFHFvGNeZW6uE+rwO2MH
         cIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNwm3g2gLFqW8k/J4MYUNInnUysaFCvyxZVIOLPuoQA=;
        b=UmqdcxaBHGn1ulZDAD5O/2tBPoOoe5pj2FpScqdsjRugnICrdEArMt71I35S3MpGPz
         Z8pwh6jEz68BWKmps7EHErb/I19tMh3E+FE5L8xHccTsifdqM0bBxhjrIXTvQfKZZQAL
         2+OlqI3qFhta3sDpjIGE47wEvtbHuhkuG5KyWOYCm3qqb7USvD1wmRXhaBfl5+8cjQ2n
         HSHKXinxodcfD9BHo4oZ/DT9CvFm/2qLJD/X4yzdfI06baUzEb1OA2DiFrA/2uq8OkrX
         IgTWiKYKxAULwglNeiVxZSp8v/3+qgSUzqSlbmWw2SDPVF+6Cg3sANAM2k3BT/2sdkuV
         1g0w==
X-Gm-Message-State: AOAM531NtDjOQh/92EPQdzbSlj74LJ/YE1+J1gi7DntlHkzRjMkjljBu
        MZaF0v3x3qptuHVuJlf3xWI=
X-Google-Smtp-Source: ABdhPJxKUqhNAMI/a9ElcGAkHhLNDjlzSXgYUbm339j9dziYqgOM6jnbw17qfzJG1YvxI726dIqk5w==
X-Received: by 2002:aa7:8d46:0:b029:2de:75aa:1964 with SMTP id s6-20020aa78d460000b02902de75aa1964mr3345424pfe.61.1621499329670;
        Thu, 20 May 2021 01:28:49 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id r11sm1427887pgl.34.2021.05.20.01.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:28:49 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: core: Use ternery for return value in mmc_vdd_to_ocrbitnum()
Date:   Thu, 20 May 2021 16:28:37 +0800
Message-Id: <20210520082837.2129-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Just simplify the code.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f194940..600543c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1028,9 +1028,7 @@ static int mmc_vdd_to_ocrbitnum(int vdd, bool low_bits)
 
 	/* Base 2000 mV, step 100 mV, bit's base 8. */
 	bit = (vdd - 2000) / 100 + 8;
-	if (bit > max_bit)
-		return max_bit;
-	return bit;
+	return (bit > max_bit) ? max_bit : bit;
 }
 
 /**
-- 
1.9.1

