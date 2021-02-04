Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69420C433DB
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E40264F51
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 12:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhBDMJY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:09:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26332 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235635AbhBDMJW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2021 07:09:22 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114C6q3W029267;
        Thu, 4 Feb 2021 13:08:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=JVizouHpERDxnp0Pvrg/BABCeBC1rdtimLXFBGntSH4=;
 b=cqJ2wZpqzmrm085DrfRl8YQWjnmoZNnCv66PcRMAZProUYHXKluzhIfqMtRpJ/s8Pj71
 hkFhqEeA6gqeWYNrpBs4ycF0TVHarf244M+2NS2tE5TPBG6VVR2oN62pS+5P8DDMptNR
 jjifSs0lyZvB5ZTWaA+oTjPH38MXixduoKD2y1YackfYjTvMaBAp+dS+xm7WopWHB/i7
 86VwsxfOLnw1ZkgytNWKZA35hlx7E+HbZIObUGhQBS2+x0h3YZqgzmxKvgDb7T3XNtyh
 U10HOe2dR/MfvskSgMvVrU28R6JxFNPVR2Pq+U7xlWlxfkA+2MJaQ5KbZcSXH5nx+ElU Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0ns7x88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 13:08:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3AFDA10002A;
        Thu,  4 Feb 2021 13:08:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03C62244F9D;
        Thu,  4 Feb 2021 13:08:15 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb 2021 13:08:14
 +0100
From:   <yann.gautier@foss.st.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <ludovic.barre@foss.st.com>, <per.forlin@linaro.org>,
        <huyue2@yulong.com>, <wsa+renesas@sang-engineering.com>,
        <vbadigan@codeaurora.org>, <adrian.hunter@intel.com>,
        <p.zabel@pengutronix.de>, <marex@denx.de>, <swboyd@chromium.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yann.gautier@foss.st.com>
Subject: [PATCH 0/2] mmc: mmci/mmc_test: update mmc_erase management
Date:   Thu, 4 Feb 2021 13:05:45 +0100
Message-ID: <20210204120547.15381-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_06:2021-02-04,2021-02-04 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yann Gautier <yann.gautier@foss.st.com>

We are facing issues when testing STM32MP157C-EV1 board with latest MMC
developments.

The commands with R1B responses weren't correctly managed, needing
MMC_CAP_NEED_RSP_BUSY.
The Ux500 platforms have the same busy detection feature, so this
flag is enabled for them too. But this change has only been tested
on STM32MP1 boards, as I don't have ux500 hardware.

The mmc_test should rely on the erase argument set in the framework,
when using MMC_ERASE command.

Yann Gautier (2):
  mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
  mmc: mmc_test: use erase_arg for mmc_erase command

 drivers/mmc/core/mmc_test.c | 2 +-
 drivers/mmc/host/mmci.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

