Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D284C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 14:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB9C22482
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 14:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLWOl1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:41:27 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48284 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727057AbgLWOl1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2020 09:41:27 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BNEbFKk022240;
        Wed, 23 Dec 2020 06:40:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=4+e4XRkngAgRt5Vk2OG8INWx+UVQ+jDAX73WsUzeUn8=;
 b=XcH3eBybT5j55bMwiJL03PJytHlLSGKSCrdgDEh4iguXQAzjKIA6MTSEBqlAgi48k+uV
 JBPqNfXbXp5rhttkbTPbviykMJOhUEaU2+2WWmSaS3XVazFymPCee0essHafm8kssUbW
 3FZ/GPZ8eNhWmr4mneR91XGZGMagJKswqCbGm6gfZ/Uy4x3kqrRFuAF3H3gC8s4dJeQQ
 suo6MdgdQume6g21osSiUNUjwM4JLl1ib5lWcHDIWn1YTN2NylfhGOc+waCK6SXJgGP6
 3FGd4iVMhNHmDLHYespm0F6nUCG27zMwTa5ZCX2iF6LZ7sMHMVDs9jpJiwfQ9tpvGlx9 ow== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 35k0ebebew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 06:40:44 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 06:40:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 06:40:44 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 8139B3F7041;
        Wed, 23 Dec 2020 06:40:41 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <ulf.hansson@linaro.org>, <keescook@chromium.org>,
        <ccross@android.com>, <tony.luck@intel.com>, <sgoutham@marvell.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bhaskara Budiredla" <bbudiredla@marvell.com>
Subject: [PATCH v4 0/2] mmc: support crash logging to MMC block devices
Date:   Wed, 23 Dec 2020 20:10:31 +0530
Message-ID: <20201223144033.32571-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_06:2020-12-23,2020-12-23 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch introduces to mmcpstore.

v4:
 - Fix claiming host if host was already held or
   if the device claiming host is not runtime active

v3:
 - Justify new host ops requirement through commit msg
 - Remove 'default n' in Kconfig

v2:
 - Fix modpost issue with ARCH=sh
 - Fix usage of ifdefs in common functions
 - Add justification of new APIs to mmc_host_ops
 - Compile mmcpstore as part of mmc blk

v1: https://lore.kernel.org/linux-mmc/20201112062422.32212-1-bbudiredla@marvell.com/T/#t
v2: https://lore.kernel.org/linux-mmc/6762a763-5284-04dc-e636-486c74dedd34@alum.wpi.edu/T/#u
v3: https://lore.kernel.org/linux-mmc/20201207115753.21728-1-bbudiredla@marvell.com/T/#t

Bhaskara Budiredla (2):
  mmc: Support kmsg dumper based on pstore/blk
  mmc: cavium: Add MMC polling method to support kmsg panic/oops write

 drivers/mmc/core/Kconfig           |  14 +-
 drivers/mmc/core/Makefile          |   1 +
 drivers/mmc/core/block.c           |  19 ++
 drivers/mmc/core/block.h           |   9 +
 drivers/mmc/core/core.c            |  44 ++++
 drivers/mmc/core/mmcpstore.c       | 310 +++++++++++++++++++++++++++++
 drivers/mmc/host/cavium-thunderx.c |  10 +
 drivers/mmc/host/cavium.c          |  67 +++++++
 drivers/mmc/host/cavium.h          |   3 +
 include/linux/mmc/core.h           |   5 +
 include/linux/mmc/host.h           |  12 ++
 11 files changed, 493 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.17.1

