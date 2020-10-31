Return-Path: <SRS0=eM5z=EG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89760C388F9
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2924F20739
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 14:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpDxLmFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgJaOZT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 31 Oct 2020 10:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgJaOZS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Oct 2020 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604154317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=CZZDYsM4yr5f6C7zqA86aLBpezdgQujjpLHyEcl2FVU=;
        b=KpDxLmFe0RhbPxaP2S4xoPftsAjAVmOtO/4eeyaRvbPuaUr3ArfTY584HulexDiG0mGTvw
        otEX+soJXzZ7hmS0uDhK6Q77sf+a8znsN1gP+f0QZLtIDHD97LBCdilemEopSMEgVFrApV
        +kPsZarUPlIGJLkO1cmYFoFiat1lSH8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-xrZnVhJnNBiBetyDkVv5_Q-1; Sat, 31 Oct 2020 10:25:15 -0400
X-MC-Unique: xrZnVhJnNBiBetyDkVv5_Q-1
Received: by mail-oi1-f197.google.com with SMTP id l142so3833733oig.1
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2020 07:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CZZDYsM4yr5f6C7zqA86aLBpezdgQujjpLHyEcl2FVU=;
        b=IkCfGQ8dESibXWkYcnFTPNzjDsSCh5hSG+IvtbHenPBLWK2hmHD18FemZ8psQ1YYTo
         GVKPPtZH5hcWR/U4G15kArozRBk4R4Auxql2Fn40+slfuxAGfcDPS7qkExyJw9grd87P
         QEAJfcVjnGuaHf43kI5QE9CwyQGcqlVH5ARgmY9gTe4EqKOLSmpXTawTyWVivE2l0gU9
         431GIYMBo7ABf/1chaVDX+8ClsdGS9JuQcibuSdr9K7jVJ1sdngUG/6qwIX9zrB1C63B
         BvFMK4NS4SK5Ul8gGD4RR47vzKxHtrJ5l92HA6w03TyF5Vd7JkOUccAr98TnC4TQ8c2O
         49wQ==
X-Gm-Message-State: AOAM530i6vC98R3XHlzYOvEcLIXZHnfM2HclM7U9WM9jv+gpvmBOlVRT
        Kngh7+5Onk5207swQJjOlyj9FboV1Y/0fN5UWPXPXYCJq1hDUgjjAxqTIaQD+50JdKYf4lel0CF
        xghK345VuvHibjL+a3gwk
X-Received: by 2002:a9d:4b10:: with SMTP id q16mr5508886otf.274.1604154314724;
        Sat, 31 Oct 2020 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDZXUwyVDrgQ8lV8rA33RPNGnqnjxHnBVv9j31G0UFSyzWIAER6R0Hh+NvjC1SOe7+vHvEwg==
X-Received: by 2002:a9d:4b10:: with SMTP id q16mr5508877otf.274.1604154314527;
        Sat, 31 Oct 2020 07:25:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s21sm2191276otd.5.2020.10.31.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 07:25:13 -0700 (PDT)
From:   trix@redhat.com
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        kvalo@codeaurora.org, jgg@ziepe.ca, leon@kernel.org,
        chao@kernel.org, gustavoars@kernel.org, colin.king@canonical.com,
        vaibhavgupta40@gmail.com, keescook@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] memstick: jmb38x_ms: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 07:25:05 -0700
Message-Id: <20201031142505.2139539-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index e83c3ada9389..f9a93b0565e1 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -748,7 +748,7 @@ static int jmb38x_ms_set_param(struct memstick_host *msh,
 				      clock_delay);
 		host->ifmode = value;
 		break;
-	};
+	}
 	return 0;
 }
 
-- 
2.18.1

