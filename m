Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EE4C0018C
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B553A23357
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgLPHrS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:47:18 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:11418 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgLPHrS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 02:47:18 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG7dZpm030944;
        Tue, 15 Dec 2020 23:46:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Puao5oWLLJfN2JnWB5z4+yCqLqmX11iEa7/vH7+sU2k=;
 b=h8kgeo4wuhTfKpjbOOq+3ZDCm0Z36znNQ0ggIllUeqHAih9JfNqjY7sPvMxV8CTLW6ld
 s2vlJLp8FNE/FwNpJcZzdPQnUlYgqyjPZVNWXpcoTK0piOpp4Royekv4lm4gjYxxgA5Z
 fSb/3c2lRGnrSaod+0SHUp4plhhZr42FDtsaMnuZKemdt1TbUJqeSoUMXX9lu1Bg2qK7
 9P7g8vKDVWXIHsyKuC7NYhe3l9ZFl2naqJGNzN/UKNA6dSBeZe7LMvU7JwTj8rUR3eIY
 ZnJU3HJpDLAOdANXsMQ75Y3ZkUq8ltTJ5iNDbZLKLK7HlTDEaj7i1aQsDhnOaqW9ab6M HA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35cv3t34tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:46:30 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 23:46:29 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 23:46:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 23:46:29 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id CC46F3F703F;
        Tue, 15 Dec 2020 23:46:26 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>
Subject: [PATCH v2 2/3] mmc: xenon: add AP807 compatible string
Date:   Wed, 16 Dec 2020 09:45:39 +0200
Message-ID: <20201216074540.30616-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216074540.30616-1-kostap@marvell.com>
References: <20201216074540.30616-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_02:2020-12-15,2020-12-16 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

This patch adds new compatible string to differentiate
between the controllers versions included in the AP807
north bridge. Thanks to this change, the SoCs which use
AP807 will not run unintentionally in the 'slow mode'
with disabled UHS modes.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 4 ++++
 drivers/mmc/host/sdhci-xenon.c                | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
index 623010f3ca89..e9a740ec22cb 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
@@ -27,3 +27,7 @@
 		#clock-cells = <1>;
 	};
 };
+
+&ap_sdhci0 {
+	compatible = "marvell,armada-ap807-sdhci";
+};
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index c67611fdaa8a..add1b4dcd5e5 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -684,6 +684,7 @@ static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
 
 static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap806-sdhci", .data = (void *)XENON_AP806},
+	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
 	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
 	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
 	{}
-- 
2.17.1

