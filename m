Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A8C4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C09423343
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLPHrM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:47:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50704 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgLPHrM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 02:47:12 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG7efrl009855;
        Tue, 15 Dec 2020 23:46:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=w5GrLSQ9eqfsoNb/NwjLFScHtEue9U7az16HBNOK9Eg=;
 b=YwuakNCmd5FuJ5reDY7qxE0QzmPgdvhebOYhb2Fxu/1ya41FZS3M83lDJaNb9IjIS2B/
 sadYxy6XozvG9iiOkilfL925I+VB3LymYyP/z1Nbxf0LO9TpjuCi7N8rIAq1ua7gIG+L
 vF10qYbyXHIYCmJNPAYZ4yuxu0zxWJtUVArgy4/eLg0H2+IBAOmUZPP8suHftmx/Bb7d
 p1m9LVzNmM2yrkQBE1JElt7XFiVdB9sZI6h59I+pT8iXDsNCbY0TyovT0sVark9J+fg8
 Nln6si/6pAFcd6FMAFx7dpVcYo5ofqBE3vM/ltLJ44KkQcQ8+XXd0Fr/u0hsEbA0H+ok 1g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tatac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:46:25 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 23:46:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 23:46:23 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id 6BFB23F703F;
        Tue, 15 Dec 2020 23:46:21 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v2 0/3] update xenon controller properties in CN913X family
Date:   Wed, 16 Dec 2020 09:45:37 +0200
Message-ID: <20201216074540.30616-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_02:2020-12-15,2020-12-16 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

The following patches series updates Xenon SDHCI controller properties
for usage with Marvell Armada CN913X SoC family.

- v2: rebase on top of "next" branch of linux/kernel/git/ulfh/mmc.git

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

