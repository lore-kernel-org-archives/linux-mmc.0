Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4059C4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915A722509
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgLOQCF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:02:05 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64434 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730691AbgLOP5i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 10:57:38 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFFtM6u012342;
        Tue, 15 Dec 2020 07:56:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=OFtdhfLcdlDzMQ6doHiOqaevA86pZtCfTrLtkeMiaw0=;
 b=fWMS+yx6g09UK1A1Y9WC/aP02XtqnidIPBpRvx1278PmbtJMHz8ieOEZI3Jpfx5rGECo
 Ala3q/v193RTIKJEe+m2WpvUANz7wLDJzPUmgvJ9jAOOe7i8AZmHtFA4yyDcGNHYYnTV
 75F4qAODOl60+15u7jgedPmH8bXEOXsfey0ZIY4QOAXhR+FkhOLHymBrTZkNedrJj30e
 G3jSw65hsktIs7bxo8iqarJXI64hpq8EQjXWO7up4NK4EfnCWwplsX5uJJKq9iukJVNY
 2yigScpQw7c+diR0W9LT6Mo/4pHBSm0WiSVOE53fePkA89wbSaOVtrNEBSbM51ixSpEC xQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35cv3t0fn2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 07:56:51 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 07:56:50 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 07:56:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 07:56:49 -0800
Received: from octopus.marvell.com (unknown [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 643913F703F;
        Tue, 15 Dec 2020 07:56:47 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <huziji@marvell.com>, <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>
Subject: [PATCH 3/3] arm64: dts: cn913x-db: enable MMC HS400
Date:   Tue, 15 Dec 2020 17:56:36 +0200
Message-ID: <20201215155636.28474-4-kostap@marvell.com>
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

This patch adds necessary flags in the device tree
which enable HS400 mode on AP807 MMC controller
on the CN913x-DB board.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/dts/marvell/cn9130-db.dts
index d24294888400..741ae534b477 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dts
@@ -113,6 +113,8 @@
 &ap_sdhci0 {
 	pinctrl-names = "default";
 	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
 	vqmmc-supply = <&ap0_reg_sd_vccq>;
 	status = "okay";
 };
-- 
2.17.1

