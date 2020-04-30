Return-Path: <SRS0=CLt1=6O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60127C8300A
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355862137B
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUHf05to"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD3JRC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3JRC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2020 05:17:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77970C035495
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u15so5705354ljd.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAMZhL85o785efprM1NP2kmSTjnBd3DKp3TTm2/2pLw=;
        b=VUHf05tojt/8dBM7x8qriL+LZ5NSWiYL6ASfP0/qa6Z9WAiEfoL0VwjcYukMjohKAb
         IL3ataGrAGmqEvD+4NaBt2zCS/93XwBYOhc8YeP4b+2KAhUtSCWGHgcunC686tBuERjN
         JksemGXqBS/YkvykkQvS0KcGJ86LWPedSfqGfw8zWHtGAkLRMhkhr2GGLkz3YzbEtzVw
         /RNA47eQ6QSFWQVl0WCRRZHBN5EHtQcn4P3YphuQjrDURAjexH30bXSaiy1wluST12zj
         QX9GIE3S1R+B5Te/YJFb4HrtTuurnNQP8SJUQi6y8lyZRv1o6N9eqE6uXTpPgXCxIULc
         8reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAMZhL85o785efprM1NP2kmSTjnBd3DKp3TTm2/2pLw=;
        b=SqR8//SlTHcedle9M+o2x+u/7dsTbneiM4GXHzVrFEiTdFV/vEn5e6YJsA4VzOBx0X
         Q5zESu9GSYG8t5GN6oZq02gvsLcPI+g7LXMMG2fMuIkOOCigORz92mXghrjDWbCUotHs
         TpbYZOV+CjudbIz/mD5T+o2O4IT4qr6Qck4C09S46B6xJbWwqE6b5xSu220OdxPA/psG
         MIgcB3c8k9rnWRPPQxVOqriVdXft3Jz1g+MpauwyGBQm1pc+UZlkWCf6giNAwbYqVd29
         xbOYh/eu1tmeav07lZlOMw3PNElkkDy117DsfkYCO4cojad8yh7MQozkr/BfjYorqoaU
         i3Kg==
X-Gm-Message-State: AGi0PuaLDlZgFp/VxzWOFZvubsLgroBP2h1FiOdwO/gsZJo5hnuARaQd
        iie8qxrPpqFAzvheWKGy8cpTOJ5pvy8=
X-Google-Smtp-Source: APiQypL+uEyUbsga+hXMGToa54CpmX3+zYfupgtWwqH5J1W083jmsUWfJ/eXZguHDsGCrMriqPsXAg==
X-Received: by 2002:a2e:9948:: with SMTP id r8mr1637670ljj.1.1588238218547;
        Thu, 30 Apr 2020 02:16:58 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id x29sm4417818lfn.64.2020.04.30.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:16:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] mmc: sdio: Fix potential NULL pointer error in mmc_sdio_init_card()
Date:   Thu, 30 Apr 2020 11:16:37 +0200
Message-Id: <20200430091640.455-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430091640.455-1-ulf.hansson@linaro.org>
References: <20200430091640.455-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

During some scenarios mmc_sdio_init_card() runs a retry path for the UHS-I
specific initialization, which leads to removal of the previously allocated
card. A new card is then re-allocated while retrying.

However, in one of the corresponding error paths we may end up to remove an
already removed card, which likely leads to a NULL pointer exception. So,
let's fix this.

Fixes: 5fc3d80ef496 ("mmc: sdio: don't use rocr to check if the card could support UHS mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ebb387aa5158..d35679e6e6aa 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -718,9 +718,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 			/* Retry init sequence, but without R4_18V_PRESENT. */
 			retries = 0;
 			goto try_again;
-		} else {
-			goto remove;
 		}
+		return err;
 	}
 
 	/*
-- 
2.20.1

