Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F83C43333
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC3B23100
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbhALJsM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:48:12 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60622 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388625AbhALJsM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 04:48:12 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C9VVcE001139;
        Tue, 12 Jan 2021 01:47:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=dUeX9ZdPNHuFVeAWTAORQVIXK2VRGllOze1tz03uvY4=;
 b=i/vyYv6ycGAt2vemgVMzOgglvicg2dYYzdG4PTwytK5fPeQYO5W3WTESSNusoRhljodT
 pAefK3Fks3maEPBc9+IxALXAaxyA7QEeqkefmels4Rabsc48AEE1rLIY4msdqYqkhyAp
 HTPLGqgleERQFVssSrUSk9vtcqEHqbwg3e4V13P+0fDWduWij+S+0Q/OmffTnqZNoHzK
 AqhPis16bZaSlhK44rrFCIMgcIGhSVYvKAGel/P4dP+UeeT2LQ55nywGaqma73fFwdhh
 7qbHg6KLfj4JkgFkNQwYPp+0yQc0GlgW5uJ2oqBS8ASYNwvPoQpyVkr5+2Ql6Cn6ETHy WA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35yaqsqmq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 01:47:23 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 01:47:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 01:47:22 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 9A7A03F7043;
        Tue, 12 Jan 2021 01:47:18 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <bpeled@marvell.com>,
        <stefanc@marvell.com>, Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v3 4/4] arm64: dts: cn913x-db: enable MMC HS400
Date:   Tue, 12 Jan 2021 11:46:55 +0200
Message-ID: <20210112094655.12274-5-kostap@marvell.com>
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

From: Marcin Wojtas <mw@semihalf.com>

This patch adds necessary flags in the device tree
which enable HS400 mode on AP807 MMC controller
on the CN913x-DB board.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
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

