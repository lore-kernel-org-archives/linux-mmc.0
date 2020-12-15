Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA75C4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4469224F4
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgLOQCF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:02:05 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33234 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730540AbgLOP5i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 10:57:38 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFFtZZt012595;
        Tue, 15 Dec 2020 07:56:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=AVFfhemX/P7UIP+KKACd/jBpapBdjMQQk4eYqAjzAoU=;
 b=ddwbzqgnequ4k75WPWXNnX82lzwaY+FT6pQ2sdUTmQP0JBfDPuISjUsv6SPfksPmNUAo
 kWLmwMtZZpwry+BngA2oeweiJ1x2p+nyohfenomBQAg5w78xIXgecAknhCqs+f9iNAbf
 RIPmoIwDo1f9IVD1c67Lfa0kXjL1LyXOE/oXi0O2AO6BIc+TfiguIaIYXPobnt3e3qV5
 H6IgKmgno3UFetV10H9EtPolRydivNJgykx++x+VPZYf3K0WfX5hqvGdQr9iI6luEQ2D
 tpREMaQzSXn7ssFZU35zdR6GD/x8PBkVU8voHiV6kJkANnju0JTIQsU+47LTzcDyelI2 5A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 35cv3t0fmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 07:56:48 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 07:56:47 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 07:56:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 07:56:47 -0800
Received: from octopus.marvell.com (unknown [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id B645D3F703F;
        Tue, 15 Dec 2020 07:56:44 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <huziji@marvell.com>, <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>
Subject: [PATCH 2/3] mmc: xenon: add AP807 compatible string
Date:   Tue, 15 Dec 2020 17:56:35 +0200
Message-ID: <20201215155636.28474-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215155636.28474-1-kostap@marvell.com>
References: <20201215155636.28474-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
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
index 24c978de2a3f..29f6bede9b96 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -668,6 +668,7 @@ static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
 
 static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap806-sdhci",},
+	{ .compatible = "marvell,armada-ap807-sdhci",},
 	{ .compatible = "marvell,armada-cp110-sdhci",},
 	{ .compatible = "marvell,armada-3700-sdhci",},
 	{}
-- 
2.17.1

