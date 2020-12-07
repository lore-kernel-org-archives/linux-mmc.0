Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA44C1B0D9
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 11:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CF32333F
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 11:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLGL7G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:59:06 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:18628 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727165AbgLGL7G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 06:59:06 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7BoDA4020901;
        Mon, 7 Dec 2020 03:58:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=OC6F28Kj8v0AthC31fezlZ7qeScuyPfyHzdrQxu3o/4=;
 b=V+iXz+RsLWbFV/9v01SijwWRvDZaRP8HaUdB0sMWI4oien+jwo6K/1PEbAeB5aAo98Ho
 JTmBUjb4a7HJ9Kbsu58wkgBHfdXiXFZJTxz45VrKBQ2jb7cPFPkNhd13kMoqOZ38uaoA
 +haauYMnTXp8sflpKr5KdrzNPEr3IKVU4lgc/TKCWTgczT8AuJrvAjISOKXocgEgVqrx
 v1fmwwzSxPo+f064U2Gc5sbWzobwMfcEtEfDgG1zR7G3Y81kLOKkSlf9ttiKxhMxHCBO
 n+Y5QYOP7fj+/J1sxLaHxFQfDaTIqefE6o9xvXiq/3p4XUZnYqiNYItipoOK1Qy/BjQb zA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3588et439t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 03:58:23 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Dec
 2020 03:58:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Dec 2020 03:58:22 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id F34B73F7045;
        Mon,  7 Dec 2020 03:58:17 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <ulf.hansson@linaro.org>, <keescook@chromium.org>,
        <ccross@android.com>, <tony.luck@intel.com>, <sgoutham@marvell.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bhaskara Budiredla" <bbudiredla@marvell.com>
Subject: [PATCH v3 0/2] mmc: support crash logging to MMC block devices
Date:   Mon, 7 Dec 2020 17:27:51 +0530
Message-ID: <20201207115753.21728-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_10:2020-12-04,2020-12-07 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch introduces to mmcpstore.

v3:
 - Justify new host ops requirement through commit msg
 - remove 'default n' in Kconfig

v2:
 - Fix modpost issue with ARCH=sh
 - Fix usage of ifdefs in common functions
 - Add justification of new APIs to mmc_host_ops
 - Compile mmcpstore as part of mmc blk

v1: https://lore.kernel.org/linux-mmc/20201112062422.32212-1-bbudiredla@marvell.com/T/#t
v2: https://lore.kernel.org/linux-mmc/6762a763-5284-04dc-e636-486c74dedd34@alum.wpi.edu/T/#u

Bhaskara Budiredla (2):
  mmc: Support kmsg dumper based on pstore/blk
  mmc: cavium: Add MMC polling method to support kmsg panic/oops write

 drivers/mmc/core/Kconfig           |  14 +-
 drivers/mmc/core/Makefile          |   1 +
 drivers/mmc/core/block.c           |  19 ++
 drivers/mmc/core/block.h           |   9 +
 drivers/mmc/core/core.c            |  24 +++
 drivers/mmc/core/mmcpstore.c       | 302 +++++++++++++++++++++++++++++
 drivers/mmc/host/cavium-thunderx.c |  10 +
 drivers/mmc/host/cavium.c          |  67 +++++++
 drivers/mmc/host/cavium.h          |   3 +
 include/linux/mmc/core.h           |   4 +
 include/linux/mmc/host.h           |  12 ++
 11 files changed, 464 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.17.1

