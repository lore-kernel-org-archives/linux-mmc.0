Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467ECC388F7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA902075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUbyyeHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgKFC2Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgKFC2W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:22 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73546C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:22 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id f21so1725212plr.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OI2O9qBwcer8FBwT8kwD3fyAcbKrenke7SFTi0wM+zw=;
        b=HUbyyeHqM0UEsor4Pdaf7iY685ttM6RXNhjHTYXuAkBIBo+cYtxJ2Ji67VtLeSEABo
         Ngimmgq56azBbvOdpPDLj2YGh+ltEOrd2rfb5i792zlPOxX4mJqIEgxQiB1h+BzgR99k
         Py1wGyHoxOOcNbPS0D4WzdTn8lt+8rPMrXnDyp2wtMlAfAXXJRlbhSfdqcOv1SNGoSxh
         ADzs1qqnwR8eOkDFzf7A9K7n2GA/dVUafBYGm2n6bIX/yz0IzjAleoFRMNl3OdkKAmJs
         RmodTXljzfknVbFxAgayckyNlgT7iIjlQozx15yinsP99ctt8k8zmFnBWLcgb+L3KOz2
         E9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OI2O9qBwcer8FBwT8kwD3fyAcbKrenke7SFTi0wM+zw=;
        b=V8+mZBrEP2hcVRbWRJpXjNU2gsMkqv3y3LRHOKaGvYQMkldZhY2LgwzauvU40HCNXZ
         JP0RaeQL5Swa7hEkz/5GJN01vTk/2glPxOj84fJavDhb+BYKTqwj8IXOuIJLUtezg2Di
         fY4VOgEVv24bDkR3XVmm8upnk0C3nZFf1ogzDxG2M/Vk4gy+lp+fTNyddKFVkGRFUiZm
         WgIotI0/PFLytuZaesdjYB/qS5RI/oEY1dngMY6aFB2hnXlpmQBD+ZVhx5Zr7zLizHQZ
         jCvpWjo9mhB5aia1qRiGkl5d/XyRFQbxJ+Hab2TE9pBE2rGPmxnnusQJiv40cDqoCDsS
         VSKA==
X-Gm-Message-State: AOAM5339jEKYQbjHyyEMSwPg3+lJmMgTGsYtVE4kwU5qxORKg4unNQha
        v5rCKIJB3pkhna8nR4ewLlC7ug==
X-Google-Smtp-Source: ABdhPJxPx2V9sZTR4oHSnUZ5jluNldG/UbHXO1BOKj1TBRaLK9fhTtM/9oY9pfl8EX6Cb3eJj5VVIQ==
X-Received: by 2002:a17:902:9889:b029:d6:5337:a758 with SMTP id s9-20020a1709029889b02900d65337a758mr4645836plp.28.1604629701958;
        Thu, 05 Nov 2020 18:28:21 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:21 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 08/27] mmc: sdhci: add a kernel configuration for enabling UHS-II support
Date:   Fri,  6 Nov 2020 11:27:07 +0900
Message-Id: <20201106022726.19831-9-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 31481c9fcc2e..5ca9ac03db40 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
-- 
2.28.0

