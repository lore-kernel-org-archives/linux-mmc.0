Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E86CC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1F6613BE
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 16:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhEKQls (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhEKQls (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 12:41:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29548C061574;
        Tue, 11 May 2021 09:40:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so11134993plz.0;
        Tue, 11 May 2021 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iMR8WD6pU0NgmzbKxZ9ZDVZnU/TZYHWSHLJfw06DwoU=;
        b=Fg3HZT0lr9muekMYyvXb7zwn6yZgOKZkIyGh+f1M5M9/OgaCozy2Eg4+DB60ez8ccc
         3PYnyEK/tRL8YoKBMVsWZr4mUY0Ez8edPGOY441HQhAutNaslrI4ateikJk4dgXn5sOq
         pd4lgRAR3Q/fdvCrQcJGukRXCM5NQdub5D1OGFkU818s5MO/+4yADDjiBj7sqQxDEVmi
         TiS4vVqCE5e+tYWKvIxWVZsksUNS2tN0u+6An6UJ9gdVUw5kSw5cG7iD3uXgifQI6wfX
         oHroduRtWyHmWrP22vzIRLqz799/+WWnGwYXlBvU5eYohwQ9azVGta/hoCKDYgfChA9U
         Ip6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMR8WD6pU0NgmzbKxZ9ZDVZnU/TZYHWSHLJfw06DwoU=;
        b=dxptx2grdQEHzdZGSun/nbojm4gBnl1oWO9rBijVTbD0nQIefk+3xbOvvk5ryx4wiE
         Fu7WSVJGz3FMyFSiRj5Nn0mm7gLcFyhMqGKsyv9i5/2cfV9xSkUV87BaXQWNDb7tD0uZ
         kpK1z6HbiwvAuZ+rHhjvV5VXpFfTY6od1IVEJj3X+7xzsGRotgjtqK5+tbzcAEbJCAEp
         vCMQnUimaT+ikzJURWrHP/Y/QwXMC8eNA5KHe/Cf4R66XtkuICF+d0ZG1OhBgLLo7tCw
         HR8PAlTNEV1jgiUIEIDEAbne11INwGNZcy8b1lgcChe3XtZwnVTkXAxMCnqP7k1PIXvf
         4fvQ==
X-Gm-Message-State: AOAM530gsGYD8lfGKy21DU4YZUU58jpNorTCvwGUwuiXZRQxpZgYqd8y
        4wQ9rFCM/oQylYnxMzrhhwl5lVB0HqmgRXXc
X-Google-Smtp-Source: ABdhPJy6cmDWedlqBjH2+mmjFOC5Ers4EzbuHwxHL8uXjuIUMsMDRMtPssbUnFO4DFpDwqsdzrjCGg==
X-Received: by 2002:a17:902:e353:b029:ed:866b:7624 with SMTP id p19-20020a170902e353b02900ed866b7624mr31155821plc.25.1620751240606;
        Tue, 11 May 2021 09:40:40 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13:d881:ad86:9c3b:8492])
        by smtp.googlemail.com with ESMTPSA id n6sm14436512pgq.72.2021.05.11.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 09:40:40 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tong Zhang <ztong0001@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] memstick: rtsx_usb_ms: fix UAF
Date:   Tue, 11 May 2021 12:39:45 -0400
Message-Id: <20210511163944.1233295-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPDyKFrFGo9gmG+EH2hS4oXPn5Jx9v8Pk8jKgvm9KW4Mdk+85A@mail.gmail.com>
References: <CAPDyKFrFGo9gmG+EH2hS4oXPn5Jx9v8Pk8jKgvm9KW4Mdk+85A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch fixes the following issues:
1. memstick_free_host() will free the host, so the use of ms_dev(host) after
it will be a problem. To fix this, move memstick_free_host() after when we
are done with ms_dev(host).
2. In rtsx_usb_ms_drv_remove(), pm need to be disabled before we remove
and free host otherwise memstick_check will be called and UAF will
happen.

[   11.351173] BUG: KASAN: use-after-free in rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
[   11.357077]  rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
[   11.357376]  platform_remove+0x2a/0x50
[   11.367531] Freed by task 298:
[   11.368537]  kfree+0xa4/0x2a0
[   11.368711]  device_release+0x51/0xe0
[   11.368905]  kobject_put+0xa2/0x120
[   11.369090]  rtsx_usb_ms_drv_remove+0x8c/0x140 [rtsx_usb_ms]
[   11.369386]  platform_remove+0x2a/0x50

[   12.038408] BUG: KASAN: use-after-free in __mutex_lock.isra.0+0x3ec/0x7c0
[   12.045432]  mutex_lock+0xc9/0xd0
[   12.046080]  memstick_check+0x6a/0x578 [memstick]
[   12.046509]  process_one_work+0x46d/0x750
[   12.052107] Freed by task 297:
[   12.053115]  kfree+0xa4/0x2a0
[   12.053272]  device_release+0x51/0xe0
[   12.053463]  kobject_put+0xa2/0x120
[   12.053647]  rtsx_usb_ms_drv_remove+0xc4/0x140 [rtsx_usb_ms]
[   12.053939]  platform_remove+0x2a/0x50

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Co-Developed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v2: remove useless code in err_out label

 drivers/memstick/host/rtsx_usb_ms.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 102dbb8080da..29271ad4728a 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -799,9 +799,9 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
 
 	return 0;
 err_out:
-	memstick_free_host(msh);
 	pm_runtime_disable(ms_dev(host));
 	pm_runtime_put_noidle(ms_dev(host));
+	memstick_free_host(msh);
 	return err;
 }
 
@@ -828,9 +828,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	}
 	mutex_unlock(&host->host_mutex);
 
-	memstick_remove_host(msh);
-	memstick_free_host(msh);
-
 	/* Balance possible unbalanced usage count
 	 * e.g. unconditional module removal
 	 */
@@ -838,10 +835,11 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 		pm_runtime_put(ms_dev(host));
 
 	pm_runtime_disable(ms_dev(host));
-	platform_set_drvdata(pdev, NULL);
-
+	memstick_remove_host(msh);
 	dev_dbg(ms_dev(host),
 		": Realtek USB Memstick controller has been removed\n");
+	memstick_free_host(msh);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
2.25.1

