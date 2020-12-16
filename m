Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68380C2BBCD
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B0A23370
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgLPHrS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:47:18 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44604 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgLPHrS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 02:47:18 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG7ef29009856;
        Tue, 15 Dec 2020 23:46:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=b2YF4QZ/ZEmPRUjyMs0RYkXpQlgxHoSvuA0+U/O7IGY=;
 b=klcyahHGdorpXatgD6LNsdW5mz3/d/W7LUKLnLY8yYWWbvvPvLef1QCF8D8ugbCRx5nL
 ur4EnbYlBbm5JeXo5rNknlP3YuRwFbGS34ctqJXCJU1VssN7Z3CcW+uOnlGlcIoWorsj
 Jg3krq8dZHD53wCMn7FImbGZU1SdwYAHeKhZGubIlfBJdELfMCHNbthr+XR1fdKm10Xu
 3DyWDixbSlDNVZCDa8HcDUbqogVhym2P+uvFjWKCkQo7hVJa3tUobYh4FbH+6qLvceyU
 knpvwW0QJPAjTt3SUAcj2otNPXrcEFyV3BoZKUCyaWiibZ+BKxGcVM5Sc++DOXZRS8Nz XA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tataq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:46:32 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 23:46:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 23:46:31 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id 65CD13F7040;
        Tue, 15 Dec 2020 23:46:29 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>
Subject: [PATCH v2 3/3] arm64: dts: cn913x-db: enable MMC HS400
Date:   Wed, 16 Dec 2020 09:45:40 +0200
Message-ID: <20201216074540.30616-4-kostap@marvell.com>
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

This patch adds necessary flags in the device tree
which enable HS400 mode on AP807 MMC controller
on the CN913x-DB board.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/dts/marvell/cn9130-db.dts
index ce49a70d88a0..79020e6d2792 100644
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

