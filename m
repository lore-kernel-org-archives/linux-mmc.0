Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE22AC4332D
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B2623103
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbhALJsM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:48:12 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13612 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732653AbhALJsK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 04:48:10 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C9VO9W001068;
        Tue, 12 Jan 2021 01:47:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Nw8egbw32c0+yxawtWtnYEp32ktpZlw4wUCUC9usBUA=;
 b=IgERooYkMR9ZqeiiYsvjNWppUF4shcggU5l6BPDupqL32n7I55UKbXLAVDEOyPIJUtdW
 XYXKTIFmvWxKLCc/vKq5WggTH67IlGEgYvksgWn/TXT3D3mrEiIqReklSkcC0s/TSeny
 TgB9rpEwCovgUHpSiWybamEXDmO8M0WWdyq+tKDIlc3Dj4/X9hl2uexEtP+jT02kitgi
 yHAdBbsA1ios+fDNHY3xTN0ovsGntblVxs+cgMNdsGm9vwz06SOd2aHTX243/4rtBVSr
 HWgqFzYytYHh1UuntDC0EE3h7M88Do3rR3tfKxYdWR5EUYo4/riOrPI7IDLzb3dJXafz vg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35yaqsqmpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 01:47:12 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 01:47:11 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 01:47:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 01:47:10 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 3DB3D3F703F;
        Tue, 12 Jan 2021 01:47:07 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <bpeled@marvell.com>,
        <stefanc@marvell.com>, Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v3 1/4] dt-bindings: mmc: xenon: add AP807 compatible string
Date:   Tue, 12 Jan 2021 11:46:52 +0200
Message-ID: <20210112094655.12274-2-kostap@marvell.com>
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

This patch adds DT binding description for the Xenon
SD/MMC controller included in AP807 north bridge.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
index ed1456f5c94d..c51a62d751dc 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
@@ -12,6 +12,7 @@ Required Properties:
   - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SoC.
   Must provide a second register area and marvell,pad-type.
   - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
+  - "marvell,armada-ap807-sdhci": For controllers on Armada AP807.
   - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
 
 - clocks:
-- 
2.17.1

