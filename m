Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA75C4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C5522509
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgLOQCR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:02:17 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51526 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730682AbgLOP5c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 10:57:32 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFFufUD006224;
        Tue, 15 Dec 2020 07:56:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=4JQngb4vTl2z5Km2Q0sbQvmvyYV/348D1o4EIdvAylU=;
 b=VcjHAP/L6ixPh8FDDztcYdPy2HBlETzr+OXdnZbRL/NDQPmWKy7yWXpFAHH30kGgxE12
 VCYQKv+mGNfqG4hpMSM+ZnhHFffEF6uO3lH/tJRio+6Ygk5Uz0bMLdVQBYK3i0YhTR1g
 5LYcAud8RIZhhcbFx/T9lDNkRRf8/VGYheyce1qg2JfHAv20+Fd0ftdCuVAwsVMx6Y9v
 YJZB3FZtUcwAGLWsQtepJ+vrBQdZSZxUwglKSJwN1xuAXAfgOMYawtygSEyl3fXdh/vq
 erTbCMHvjmjhN8UqFer1wvFDZke9DtcpPqzmsIH4HY0x+bMuiBAe5Mpbt3XgOdwxcnGY /A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8t84ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 07:56:45 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 07:56:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 07:56:44 -0800
Received: from octopus.marvell.com (unknown [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 0ACCC3F703F;
        Tue, 15 Dec 2020 07:56:41 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <huziji@marvell.com>, <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>
Subject: [PATCH 1/3] dt-bindings: mmc: xenon: add AP807 compatible string
Date:   Tue, 15 Dec 2020 17:56:34 +0200
Message-ID: <20201215155636.28474-2-kostap@marvell.com>
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

This patch adds DT binding description for the Xenon
SD/MMC controller included in AP807 north bridge.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
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

