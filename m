Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001CC4332B
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D05D23103
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbhALJsK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:48:10 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:63018 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733191AbhALJsK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 04:48:10 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C9VVcD001139;
        Tue, 12 Jan 2021 01:47:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=cz+Y/+9/bFRzc1mDAifQJOPexc4rONAcpnzVZzqZ8wk=;
 b=dgeD/tuhgrNETc/gI2jut/Q4mGQea+wQMdPpFsZXiLhqqkilja7+E+sS+82z9aYR343n
 XT3Yipd5IPm37g7wvJKgkXc7bBlyQfAOzTniTeLXTcE2Lh3CKkGlLjfRnDtzMzI9URYq
 gXniMd4y6D+x2Dj6oOaq9BoCqLZQctuabbIgV0bql7hbdnP8xl2DONHmdJuRjWV++6Ym
 t+mZJN4sxIfdyPanr5QFEIyw7+/HNnvjJTg15GVdcLq0ewxWakfIgqrokZfzU/mklhlf
 kMq8JvhlHtPTuLGJlvc+fk3hU9djM8e9U6rTjIaQo1ixTzd/GEO4G05Xb0rVuqUvXH4S 2A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35yaqsqmps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 01:47:19 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 01:47:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 01:47:18 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id CD5E43F7040;
        Tue, 12 Jan 2021 01:47:14 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <bpeled@marvell.com>,
        <stefanc@marvell.com>, Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v3 3/4] arm64: dts: change AP807 SDHCI compatibility string
Date:   Tue, 12 Jan 2021 11:46:54 +0200
Message-ID: <20210112094655.12274-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112094655.12274-1-kostap@marvell.com>
References: <20210112094655.12274-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-11,2021-01-12 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This patch adds new compatible string to AP807 DTSI to avoid
its SDHCI controller to run in "slow mode" with disabled UHS.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
index 623010f3ca89..d9bbbfa4b4eb 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
@@ -27,3 +27,8 @@
 		#clock-cells = <1>;
 	};
 };
+
+&ap_sdhci0 {
+	compatible = "marvell,armada-ap807-sdhci";
+};
+
-- 
2.17.1

