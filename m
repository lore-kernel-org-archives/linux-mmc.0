Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D823EC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E25123102
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 09:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbhALJsK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:48:10 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48774 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731426AbhALJsJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 04:48:09 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C9VVcB001139;
        Tue, 12 Jan 2021 01:47:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=5LzXMHHPhUDyzXfzYkgicufhDK5baqKaqSfOz1uAnSE=;
 b=XBSDnZaG9z/BtNTO4ExEFuPSNHDA7oM+efhAuS9NWyWEvY/E+NXC8o4TMlt3JcoxPILd
 P3enVAuZRAcMOI2MNr3FJI5XNClKNvXzWoT/UBkpCBp66rCuWr8Xvn6zUzs2hK3bMB9n
 MnNEoWszlFVIXF7dvMbKaeigWV3ANmL/2sNSrtpanoIyGH1WBSHT5HAAYxfegI9Of3Ss
 ggjM0Dr251jOB26WOby2I56msucdkZpf569GIU0GdelvxcTuzUtHi/oBuYbzcCwFdbAD
 7C3nI6AdnvpTkwyvTEpymK0OlIggys6MH+Cam1KlbHhOhqHr85S/txV+V3Ohpbwo4+3r tQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35yaqsqmp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 01:47:08 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 01:47:07 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 01:47:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 01:47:06 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 6F94A3F7043;
        Tue, 12 Jan 2021 01:47:03 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <bpeled@marvell.com>,
        <stefanc@marvell.com>, Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v3 0/4] update xenon controller properties in CN913X
Date:   Tue, 12 Jan 2021 11:46:51 +0200
Message-ID: <20210112094655.12274-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-11,2021-01-12 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

The following patches series updates Xenon SDHCI controller properties
for usage with Marvell Armada CN913X SoC family.

- v2:
* rebase on top of "next" branch of linux/kernel/git/ulfh/mmc.git 

- v3:
* separate between driver and DTSI changes for new compatibility
   string
* add my signed-off-by entry to all patches

Konstantin Porotchkin (1):
  arm64: dts: change AP807 SDHCI compatibility string

Marcin Wojtas (3):
  dt-bindings: mmc: xenon: add AP807 compatible string
  mmc: xenon: add AP807 compatible string
  arm64: dts: cn913x-db: enable MMC HS400

 .../devicetree/bindings/mmc/marvell,xenon-sdhci.txt          | 1 +
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi                | 5 +++++
 arch/arm64/boot/dts/marvell/cn9130-db.dts                    | 2 ++
 drivers/mmc/host/sdhci-xenon.c                               | 1 +
 4 files changed, 9 insertions(+)

-- 
2.17.1

