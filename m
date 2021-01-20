Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBFC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3944B2333C
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 12:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbhATM6w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:58:52 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36460 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389286AbhATMLq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 07:11:46 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10KCB3BB029315;
        Wed, 20 Jan 2021 04:11:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=uDCwteCVReYY7s4IxoAqqlecXUbtb1Gyu6EiEuDRKGE=;
 b=kLfu5+8fdL7iajsBtDxPubuIM4mhvPw+ikFsA/JEK728L9GDyLg7N0xphgu2DE0CFucm
 M6unzCxH5M5+9gVBb79BwsudXPTYogyyo4SNjUwrTFCP6tn5o4iUniTx98P6O84D6Qrf
 1LdzPvxxRKNapA6gxsf0k5e0A9ohGAPTHMM2LS/fB7N+DneHkqTS9/LKHPS7Erix1+kD
 au5+3R6K1XCzRsClp7A3NlVJvRc2lTKJovpL6snzH/iMB/CnhdTN6rvEHn5QNXwwyZir
 AafABzeBcAoDWEe4Rv0TjGLdvWGGMpXVnvVXQ3kgea9YmMMlk5WrCYTGb+HkXadVXzvq 8g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3668p2t35h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 04:11:03 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Jan
 2021 04:11:02 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Jan
 2021 04:11:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jan 2021 04:11:01 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 11B253F7041;
        Wed, 20 Jan 2021 04:10:58 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <ulf.hansson@linaro.org>, <keescook@chromium.org>,
        <ccross@android.com>, <tony.luck@intel.com>, <sgoutham@marvell.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bhaskara Budiredla" <bbudiredla@marvell.com>
Subject: [PATCH v5 0/2] mmc: support crash logging to MMC block devices
Date:   Wed, 20 Jan 2021 17:40:45 +0530
Message-ID: <20210120121047.2601-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_05:2021-01-20,2021-01-20 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch introduces to mmcpstore.

v5:
 - Implement non-panic read/write support through pstore callbacks

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
v4: https://lore.kernel.org/linux-mmc/20201223144033.32571-1-bbudiredla@marvell.com/T/#md9fce2de5b6aaa66e8ff7cb04d138a548426a8e3

Bhaskara Budiredla (2):
  mmc: Support kmsg dumper based on pstore/blk
  mmc: cavium: Add MMC polling method to support kmsg panic/oops write

 drivers/mmc/core/Kconfig           |  14 +-
 drivers/mmc/core/Makefile          |   1 +
 drivers/mmc/core/block.c           |  19 +++
 drivers/mmc/core/block.h           |   9 ++
 drivers/mmc/core/core.c            |  44 ++++++
 drivers/mmc/core/mmcpstore.c       | 227 +++++++++++++++++++++++++++++
 drivers/mmc/host/cavium-thunderx.c |  10 ++
 drivers/mmc/host/cavium.c          |  67 +++++++++
 drivers/mmc/host/cavium.h          |   3 +
 include/linux/mmc/core.h           |   5 +
 include/linux/mmc/host.h           |  12 ++
 11 files changed, 410 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.17.1

