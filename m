Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381DC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9A121556
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H7zJqw4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgFSM6q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:58:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55424 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbgFSM6n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 08:58:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwZSv058358;
        Fri, 19 Jun 2020 07:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571515;
        bh=VgzXtbEPK3BZf4YNOTbshjleKAPVz3hmnBNiNTgI/zo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H7zJqw4J394jESjLoLpCTIRcxQ3THnu16UGGA0JLjWpKvYH6W2FJh49k8LBlgF4yC
         Jbujo8GyR9XPxL5FSTrtz5W1ng/UW2fuZ/dSZHVvt8VBLKfvxlXHSIWnHJk1K6GH9K
         0dw8poqah9BCNbsk6JtFNvGZMDqc0vlmdjn8DJxc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05JCwZ8b081271
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 07:58:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:35 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Hr015675;
        Fri, 19 Jun 2020 07:58:31 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
Date:   Fri, 19 Jun 2020 18:28:01 +0530
Message-ID: <20200619125801.9530-8-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619125801.9530-1-faiz_abbas@ti.com>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable CONFIG_SDHCI_AM654 to Support AM65x sdhci controller.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 883e8bace3ed..40dd13e0adc5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -731,6 +731,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_BCM2835=y
 CONFIG_MMC_SDHCI_XENON=y
+CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MMC_OWL=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
2.17.1

