Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A42C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 18:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389167AbiDUSbL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391324AbiDUSbK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 14:31:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE8FD1A;
        Thu, 21 Apr 2022 11:28:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x191so5344525pgd.4;
        Thu, 21 Apr 2022 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WoeAeHW5+pgaqDzt+MQVIH8ZiTqwseT46QF5bHnKTlY=;
        b=qXLuFnoGfr2jkk+KCzjgqPXHHV4meayjHWJhhlSGh7uLIcIv7gOYM8FfxmcUwvX3fx
         jZ3/ViCTj5cneAUoM9EGbFf/ZNW5Fd+ycgDRM9k5XZzTey28EE/4qDK6QPbXX1ZYoTdJ
         acN+Xo8jEj9vfFJKg3EHQXnSF9FryTHr3t5XNQHRNQp7N572xCTvahqniwftriKI66/3
         PyhQXRG2ZiR81w0c7YSFJgOsDVP+YC3MR9ESA4eZUSmiY7sZH78oJKbtjYkHyg+PK6V8
         VRthEQlXzPyfzSEiTEONs99ctVvNr9KuvK/FjDWTqWJEr2Xg6wM+Gka/O5AMoy1Oaaci
         XSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WoeAeHW5+pgaqDzt+MQVIH8ZiTqwseT46QF5bHnKTlY=;
        b=o7OX0kLHBLY/LuDv+qbl4zuIgSKbsZGkcA009n3WxTleWDgORjEkwWfvNBaJ+HWFQ/
         6hWoqfH+AYOT6c570G6J4KO8xD4pkEQM0XZ97H6FivoSFsx4Aam1/lgce2YWnsqQfxk8
         n1cR0E1Le5oG+lTlOhRYUH/XGuE8m6Ce/F2qOjZvQoZI2VmQGrl09bMCmMRvbNamb4cn
         duiG+9ZdUVFZsSD0YyZ5AyGFKNS5+ta6z1A2Ih0WVUmZf7gSpz5IxdXJd575TpsuxJMQ
         ZRu74ENiqz3eJh34z3SDTQNIH6sPc30fyWvSRQ1wNAccZ42l9fCN4G15Hximy4f11Ndd
         Npnw==
X-Gm-Message-State: AOAM530opdb727UbimXc4L+4K0SfKqyoOP/ld8kno4I8TnRiZVIV6TnO
        TLnBAyTVBxGD4QB2cIsNPmo=
X-Google-Smtp-Source: ABdhPJxFDwn3JFhdVvifutf6KZ4J30lL9zq4foVLQ7EpaOZfJo/wQ030Mfch0S+M3IeJarLqaJzr0w==
X-Received: by 2002:a63:5a20:0:b0:3aa:2fd0:9e94 with SMTP id o32-20020a635a20000000b003aa2fd09e94mr637635pgb.602.1650565699397;
        Thu, 21 Apr 2022 11:28:19 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id s62-20020a635e41000000b003a9eb7f65absm6509333pgb.85.2022.04.21.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:28:19 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 1/5] mmc: sdhci-brcmstb: "mmc1: Internal clock never stabilised." seen on 72113
Date:   Thu, 21 Apr 2022 14:27:59 -0400
Message-Id: <20220421182803.6495-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421182803.6495-1-kdasu.kdev@gmail.com>
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

The problem is in the .shutdown callback that was added to the
sdhci-iproc and sdhci-brcmstb drivers to save power in S5. The
shutdown callback will just call the sdhci_pltfm_suspend() function
to suspend the lower level driver and then stop the sdhci system
clock. The problem is that in some cases there can be a worker
thread in the "system_freezable_wq" work queue that is scanning
for a device every second. In normal system suspend, this queue
is suspended before the driver suspend is called. In shutdown the
queue is not suspended and the thread my run after we stop the
sdhci clock in the shutdown callback which will cause the "clock
never stabilised" error. The solution will be to have the shutdown
callback cancel the worker thread before calling suspend (and
stopping the sdhci clock).

NOTE: This is only happening on systems with the Legacy RPi SDIO
core because that's the only controller that doesn't have the
presence signal and needs to use a worker thread to do a 1 second
poll loop.

Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f24623aac2db..11037cd14cfa 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -313,6 +313,10 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+
+	/* Cancel possible rescan worker thread */
+	cancel_delayed_work_sync(&host->mmc->detect);
 	sdhci_pltfm_suspend(&pdev->dev);
 }
 
-- 
2.17.1

