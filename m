Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE38C2BB9A
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E922509
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 16:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgLOQCQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:02:16 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:29078 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730672AbgLOP5c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 10:57:32 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFFuOmj006160;
        Tue, 15 Dec 2020 07:56:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=3EtYB5oJ9PIW1ObWs4/ibSDctYsNWwF4TaZYKV+LdnI=;
 b=IstOzogCFIuQGqiRc4GOwVPSmTIP5Rd7wmnQJRoMWnno9K+d7+dFC+74n0vxXyl7ym3U
 2r6930C4m1qb0bPelS67g277z3WE2mRxd/azkHZnJaKQXBa+4iAI/sytxNMmiFzL3i3f
 2O7ceGpTJan2e3mP6LYHs2etwCaMsjm2qbqtwi+PxzGZacoI7LS8QrUhhmk3llNNDiHh
 rKtYwGI72ZifqVLFNYjntWLQ44+5/JxBuH6Q4266pXN1xr7wbp+bIdJubfLSmvEGOrU0
 m0MboFC4sG5G5ggUH8nof4Vuwx1UMl16B33khYbcZOC8czMBNgutit02UMuu+taZ59YJ GA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8t84ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 07:56:43 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 07:56:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 07:56:41 -0800
Received: from octopus.marvell.com (unknown [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 219463F703F;
        Tue, 15 Dec 2020 07:56:38 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <huziji@marvell.com>, <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 0/3] uodate xenon controller properties in CN913X family
Date:   Tue, 15 Dec 2020 17:56:33 +0200
Message-ID: <20201215155636.28474-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

The following patches series updates Xenon SDHCI controller properties
for usage with Marvell Armada CN913X SoC family.

Marcin Wojtas (3):
  dt-bindings: mmc: xenon: add AP807 compatible string
  mmc: xenon: add AP807 compatible string
  arm64: dts: cn913x-db: enable MMC HS400

 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 1 +
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi                 | 4 ++++
 arch/arm64/boot/dts/marvell/cn9130-db.dts                     | 2 ++
 drivers/mmc/host/sdhci-xenon.c                                | 1 +
 4 files changed, 8 insertions(+)

-- 
2.17.1

