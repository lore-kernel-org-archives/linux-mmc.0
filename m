Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90630C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1B761882
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhKQWcf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:32:35 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47192 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241184AbhKQWcc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 17:32:32 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AHJXBXP026889;
        Wed, 17 Nov 2021 14:29:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=t4PWee8KaXYwU5JN+/qBheWEVVFEWJOWDj1bcZKdljg=;
 b=RAG34UvhA+lvP4Zq6QIxTYSF0c6D2SNLhzHXkaCEAsURsKAaA1I29aISZ7ehIModkjg0
 pwcGKK3oZC5jRQVIEsqZrWjUKthoXRNwIfyPXEXiEN0spOo6dM6bmzAUDNh/zwLax+i1
 77IJt+gXrKxJL4aZ0FqfRg1cA98c4TRirJSy4ZY71hw6W9dS69g6xVfT6AHC2R/NUnVe
 o/4dTvmhFmVlEk2vz1darKuzRUP0H7YdQd6jq0LJOZKjvpJ5+LGCZ09G2Rj/c8lDe7wH
 7VYyMhirFzbxqfLGRZ6CKYWYM8le/xsmJ7FwT+thVPBA2cxYgEQNVEiyxIWpCixQWQft GA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cd8028mm3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:29:21 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 17 Nov
 2021 14:28:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 17 Nov 2021 14:28:36 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 7AD075B694C;
        Wed, 17 Nov 2021 14:28:36 -0800 (PST)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <beanhuo@micron.com>,
        <tanxiaofei@huawei.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wbartczak@marvell.com>
Subject: [PATCH 0/2] mmc: cavium: Fix MMC supply switching for cards
Date:   Wed, 17 Nov 2021 14:27:59 -0800
Message-ID: <cover.1637186803.git.wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DOWX3jR2RXP6AOZA8rJD7Yn5WLCw1shw
X-Proofpoint-GUID: DOWX3jR2RXP6AOZA8rJD7Yn5WLCw1shw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_08,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Following series of patches fix code related to switching
voltage regulators used by multiple cards in Octeon/OcteonTX2
systems.

Change is necessary to support cards with different voltages,
which is common case in modern configuration where the mix of SD cards
and MMC memory chips is used as main storage.

Aside custom system, the change is required to support reference designs
for CN96xx and CN98xx systems.

First patch contains mid-size rework of do_switch() routine that
includes:
- separation of vmmc/vqmmc switch logic
- separation of register accesses to functions for better readibility
- forming do_switch() as high-level function that controls the flow of
  switch operation.

Second patch adds extended description of device-tree usage to
enable code contained in former patch.

Wojciech Bartczak (2):
  mmc: cavium: Fix voltage reg. switching for card slots
  dt-bindings: mmc: Add vmmc/vqmmc for Cavium driver

 .../devicetree/bindings/mmc/cavium-mmc.txt    |  47 ++++-
 drivers/mmc/host/cavium.c                     | 168 ++++++++++++++++--
 drivers/mmc/host/cavium.h                     |   8 +-
 3 files changed, 202 insertions(+), 21 deletions(-)

-- 
2.17.1

