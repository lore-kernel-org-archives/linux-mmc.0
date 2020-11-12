Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA2EC2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C76208B8
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 06:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ctqfrRRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKLGYf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 01:24:35 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20690 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgKLGYf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 01:24:35 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC6B7QO014707;
        Wed, 11 Nov 2020 22:24:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=Fmdq64XIv0emoK67PuTV4iIe1S1N2OSxDkMtbVXC1R8=;
 b=ctqfrRRbekB6yJdd9D3HOZ+87VrPah/IKLcNsH3873fV7CayibEzleTBuzOpfa52Vo/M
 DdVyo5nOal/rpTuprHAmvqwJOKEDvXZVIJLH6SXo8NkbvLztGJeL5utIkTQPa0jnPmjs
 po0rcK9zmERYDMei9PLbtDwCaWfOp9pc/H9wGfOjB1GbaqeY+TZWPaB5EjgPBYsDNpzT
 z6XsKGW5ngs/PtwfOUDkbAKrSkX2AwSo0HsEs1vIdp8zMiYHFVThxnbJA3tFCku0/mzp
 le0UsCUkfeymY78+wDRhP4N7HyoVphh81+0pKtAyRPkYHsGFRIIwLXc/eDBx0pcQUs+q jQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 34nuyssw7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 22:24:31 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Nov
 2020 22:24:29 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Nov
 2020 22:24:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 22:24:28 -0800
Received: from hyd1soter3.caveonetworks.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 3651C3F703F;
        Wed, 11 Nov 2020 22:24:25 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <ulf.hansson@linaro.org>, <keescook@chromium.org>,
        <ccross@android.com>, <tony.luck@intel.com>, <sgoutham@marvell.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bbudiredla@marvell.com>
Subject: [PATCH v1 0/2] mmc: support crash logging to MMC block devices
Date:   Thu, 12 Nov 2020 11:54:20 +0530
Message-ID: <20201112062422.32212-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_12:2020-11-10,2020-11-11 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch introduces to mmcpstore.

Bhaskara Budiredla (2):
  mmc: Support kmsg dumper based on pstore/blk
  mmc:cavium: Add MMC polling method to support kmsg panic/oops write

 drivers/mmc/core/Kconfig           |   7 +
 drivers/mmc/core/Makefile          |   1 +
 drivers/mmc/core/block.c           |  20 ++
 drivers/mmc/core/block.h           |   3 +
 drivers/mmc/core/core.c            |  24 +++
 drivers/mmc/core/mmcpstore.c       | 318 +++++++++++++++++++++++++++++
 drivers/mmc/host/cavium-thunderx.c |  10 +
 drivers/mmc/host/cavium.c          |  67 ++++++
 drivers/mmc/host/cavium.h          |   3 +
 include/linux/mmc/card.h           |   4 +
 include/linux/mmc/core.h           |   4 +
 include/linux/mmc/host.h           |   6 +
 12 files changed, 467 insertions(+)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.17.1

