Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06CFC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF8921556
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u0X/Sjdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbgFSM66 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:58:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35048 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732690AbgFSM6j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 08:58:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwVfe076871;
        Fri, 19 Jun 2020 07:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571511;
        bh=aJnKA0kudzVvE8QWCNmxRFasKDl7kSmbWoXmdq3ovjY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u0X/SjdyEzBsGZpN3q+7L6C5HO6Kzh0yj1ImbJGdQrMXTj5m912uYchbK+7mQ69o0
         pTmLJLwBdqnYQwzJ5yqeeROZKYZyOjbKeL3bbQf4vAMs2kHgKbAJGZ9A1ERhR4cfIK
         5RzeUEJzr/IVremsfEDg3uB2pZBC8rj0991a2Yyk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05JCwVGB105882
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 07:58:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:31 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Hq015675;
        Fri, 19 Jun 2020 07:58:27 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 6/7] mmc: sdhci_am654: Add support for clkbuf_sel property
Date:   Fri, 19 Jun 2020 18:28:00 +0530
Message-ID: <20200619125801.9530-7-faiz_abbas@ti.com>
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

Add support for writing new clkbuf_sel property for the J721e 4 bit IP.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f7535ee3a232..f9d24af12396 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -47,6 +47,8 @@
 #define SEL100_MASK		BIT(SEL100_SHIFT)
 #define FREQSEL_SHIFT		8
 #define FREQSEL_MASK		GENMASK(10, 8)
+#define CLKBUFSEL_SHIFT		0
+#define CLKBUFSEL_MASK		GENMASK(2, 0)
 #define DLL_TRIM_ICP_SHIFT	4
 #define DLL_TRIM_ICP_MASK	GENMASK(7, 4)
 #define DR_TY_SHIFT		20
@@ -86,6 +88,7 @@ struct sdhci_am654_data {
 	struct regmap *base;
 	bool legacy_otapdly;
 	int otap_del_sel[11];
+	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
 	bool dll_on;
@@ -238,6 +241,9 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
 				   SELDLYTXCLK_MASK, 1 << SELDLYTXCLK_SHIFT);
 	}
+
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
+			   sdhci_am654->clkbuf_sel);
 }
 
 static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
@@ -260,6 +266,9 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
+			   sdhci_am654->clkbuf_sel);
+
 	sdhci_set_clock(host, clock);
 }
 
@@ -582,6 +591,8 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	}
 
 	device_property_read_u32(dev, "ti,strobe-sel", &sdhci_am654->strb_sel);
+	device_property_read_u32(dev, "ti,clkbuf-sel",
+				 &sdhci_am654->clkbuf_sel);
 
 	sdhci_get_of_property(pdev);
 
-- 
2.17.1

