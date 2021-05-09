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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB542C433ED
	for <linux-mmc@archiver.kernel.org>; Sun,  9 May 2021 21:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC366128E
	for <linux-mmc@archiver.kernel.org>; Sun,  9 May 2021 21:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhEIVzu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 9 May 2021 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhEIVzt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 May 2021 17:55:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29247C061573;
        Sun,  9 May 2021 14:54:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m124so11874216pgm.13;
        Sun, 09 May 2021 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NGZNDXjQL+muSyzj7U9/zaOUo2jeB+uihkrcejFFks=;
        b=Ey1YI8NSGJiM++MiPWJX82SDjc3T0sX6aV0gSg38rRA2Bvob/gy7/GtSC3bXsbJvPK
         l3QBAS8geCEGY0UaxTZBMXAi5fRrVlEKaMcuGNxIt5hHNhNVCbqPvwp/wZ0bprZa2aCU
         S28hxWXPb7XkWDBhy6bcxM0UzXkB3PC3SHT36djMetJQqZ2QyRaeV+f2NW/RgHBiSrKT
         HeBiuk1HWV0iqgDEOm7kg8LPuIO59lZBxY1nRyFTtaXxpXDtb+001pmfsgeyOjunBEli
         1S+fom3zKoT2EPdMhXdU81Y+4LbFWkju4yImWkFriptGupG2fV3peLMUsiN9Oz+1C0Na
         3kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NGZNDXjQL+muSyzj7U9/zaOUo2jeB+uihkrcejFFks=;
        b=GesScBFfY40+ECaQeYJY3VMGjrOM+2pjJlMHKIsQYmvO3GaHXy1Fy9PIb7+DqiuKPA
         9qchzmVDezsxIoh5rxnfwaJMbYPJkChzAOs4rzOaOGPecmNXyCht+ogtv1dD5WfvBSV7
         Hm/iGoMF35VbT/GL4SXq9Yz1GOSUzHU4XhG6p2BHwA0YohtE9yo3tBBuDOc01/wo50qU
         mtgD/7D/WoJqfRslTOFklUjD1HtBc10FsQenTalsn9T72miaqUqn9Swqyt8ejGiNzzh9
         xn9zVEbzSEchcfDgzAjgHvDCWhQb5jR8k3xeEEW/Unyqt5Bu7NUudXA3VtEHg5ZHKY/V
         zedQ==
X-Gm-Message-State: AOAM530F5fu5yPm4ZGvvW/y9WpH25Q0axmj4EM6hSpwSCDutDz+6Yrve
        2QHdiNG7AppgbCzV7bzxIpfgiQImAZV0d7We
X-Google-Smtp-Source: ABdhPJwfdTl0DTeerlW7AtkhO6PFzt7sSRmPovjkDNawfc1OOO7pMip+13y1wCgCcUcd773cbN0VLw==
X-Received: by 2002:a62:3815:0:b029:28e:8c94:e1ad with SMTP id f21-20020a6238150000b029028e8c94e1admr22030836pfa.56.1620597285489;
        Sun, 09 May 2021 14:54:45 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13:8589:d56e:ef4e:6a])
        by smtp.googlemail.com with ESMTPSA id k7sm9561263pfc.16.2021.05.09.14.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 14:54:45 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tong Zhang <ztong0001@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: rtsx_usb_ms: fix UAF
Date:   Sun,  9 May 2021 17:54:15 -0400
Message-Id: <20210509215416.950337-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch fixes the following issues:
1. memstick_free_host() will free the host, so the use of ms_dev(host) after
it will be a problem. To fix this, move memstick_free_host() after when we
are done with ms_dev(host).
2. if something bad happens in memstick_add_host() and we end up taking
err_out in rtsx_usb_ms_drv_probe(), we'd better avoid running rtsx_usb_ms_drv_remove()
3. In rtsx_usb_ms_drv_remove(), pm need to be disabled before we remove
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
---
 drivers/memstick/host/rtsx_usb_ms.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 102dbb8080da..851643d007b7 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -799,9 +799,10 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
 
 	return 0;
 err_out:
-	memstick_free_host(msh);
 	pm_runtime_disable(ms_dev(host));
 	pm_runtime_put_noidle(ms_dev(host));
+	memstick_free_host(msh);
+	platform_set_drvdata(pdev, NULL);
 	return err;
 }
 
@@ -811,6 +812,8 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	struct memstick_host *msh = host->msh;
 	int err;
 
+	if (!host)
+		return 0;
 	host->eject = true;
 	cancel_work_sync(&host->handle_req);
 
@@ -828,9 +831,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	}
 	mutex_unlock(&host->host_mutex);
 
-	memstick_remove_host(msh);
-	memstick_free_host(msh);
-
 	/* Balance possible unbalanced usage count
 	 * e.g. unconditional module removal
 	 */
@@ -838,10 +838,11 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
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

