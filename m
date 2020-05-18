Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F04C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FBD207FB
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="QLzBpTDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgERTMa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 15:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgERTMY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 15:12:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CF6C05BD09
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 12:12:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so744513wmu.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWB++yMqgyFLL/O/QOjwJZdaE9T80lON0SlrWCGskB8=;
        b=QLzBpTDLcLeGRR9ddqVlyLiZtzhOL4Y/2JcFhYFoabbgwipjYKS+xuq0wmO9tQBkzA
         aHSdVGFrLuADLDg3Kdi1m4HMgDqGcfQuMoe+srFIRwgJJzKUFIePaJNTNRBnFWBbjSrn
         lk1PUgl1jhanDWCawgJYky9M6sXYpwtjEU5sfDeXyLa6eegScPv/WDeS8yu9KV+lRtKW
         4wdZX+ZGpo3hcPs80BfoJ/Xie8HDj08lEdgNIgCEzrEVywrM61oG0ssEIqQjSgkByUub
         ts/9kHEV7fR8HBYCu3YOTgDfbQ06XcHPYbHQ0hsqOJo+bNQZwTrLDmGv42tuEse8WwDY
         xWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWB++yMqgyFLL/O/QOjwJZdaE9T80lON0SlrWCGskB8=;
        b=XABR9I6WFdaLsCYdcS8L8WmWPzWj15TaRSwBj7Ah/oGDL1TH/EmzEIil0AW06AoL4y
         XhMywnYgHFQwNZ3D+BUq/i4pMRokaSEYQzpRTzAk6tieDrPPNoZuoYXr1Oo01yanVuBR
         g9bJ9aS5kjt+giTEiPlGwkpAB25Uj+nlu0phGikWE3T1QnRK0B6NCXa4l3IY7/v2e4RV
         8HYHQ9KTTC4Fsu+arxaiHx1rrJeQVm1aEqtz7ysBTkUx+juKARMjQjGzllwiZIYFmjIo
         DPeNV7vWxxMoIdMF+J3N9CLzO3lk+G9LLe0sBE0OwBtr+FRYQJRQJoOjLynjk7PWnkLF
         9Y4g==
X-Gm-Message-State: AOAM5305WMDVDrhCJCSEUlkQjdznH6IJobhYHtfRGSVkZbQoeTHmEhG6
        ZIifPmNij7ISKz1n0TVoMA00zA==
X-Google-Smtp-Source: ABdhPJzo+QJUBzc2fvdhkpqShkVRy+RPiVaa3EHF2V6GthCy7/nGJlMOHQCidp2egzf442awmEtUGA==
X-Received: by 2002:a1c:a910:: with SMTP id s16mr905391wme.70.1589829142894;
        Mon, 18 May 2020 12:12:22 -0700 (PDT)
Received: from localhost.localdomain (host203-36-dynamic.30-79-r.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id v11sm17683046wrv.53.2020.05.18.12.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:12:22 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        gerg@linux-m68k.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH v6 4/4] MAINTAINERS: add myself to maintain M5441X mmc host driver
Date:   Mon, 18 May 2020 21:17:42 +0200
Message-Id: <20200518191742.1251440-4-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518191742.1251440-1-angelo.dureghello@timesys.com>
References: <20200518191742.1251440-1-angelo.dureghello@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since actively working on Freescale ColdFire M5441X, adding
myself as a maintainer of this driver.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc0749810b0..92aab798154f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6713,6 +6713,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/fsl-sec4.txt
 F:	drivers/crypto/caam/
 
+FREESCALE COLDFIRE M5441X MMC DRIVER
+M:	Angelo Dureghello <angelo.dureghello@timesys.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-esdhc-mcf.c
+F:	include/linux/platform_data/mmc-esdhc-mcf.h
+
 FREESCALE DIU FRAMEBUFFER DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	linux-fbdev@vger.kernel.org
-- 
2.26.2

