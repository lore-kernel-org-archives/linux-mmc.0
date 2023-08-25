Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4452DC3DA66
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Aug 2023 09:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHYJSv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Aug 2023 05:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjHYJSV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2023 05:18:21 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2511FD5;
        Fri, 25 Aug 2023 02:18:18 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37P9Htsn015607;
        Fri, 25 Aug 2023 17:17:55 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RXDnW623Bz2PXDCV;
        Fri, 25 Aug 2023 17:15:27 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 25 Aug
 2023 17:17:54 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V3 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
Date:   Fri, 25 Aug 2023 17:17:41 +0800
Message-ID: <20230825091743.15613-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37P9Htsn015607
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Change in v3:
- Move changes in include/linux/mmc/host.h and drivers/mmc/core/sd_ops.c into patch1
- The callback is executed when timing is equal to MMC_TIMING_SD_HS
- Rename prepare_hs_tuning to prepare_sd_hs_tuning
- Rename execute_hs_tuning to execute_sd_hs_tuning

Change in v2:
- add mmc_sd_switch() and mmc_send_status() to the header file
- split up core changes from host driver changes
- Use pr_debug instead of dev_info and dev_dbg
- Optimize the best sampled value algorithm

Wenchao Chen (2):
  mmc: core: Add host specific tuning support for SD HS mode
  mmc: sdhci-sprd: Add SD HS mode online tuning

 drivers/mmc/core/sd.c         |  14 ++++
 drivers/mmc/core/sd_ops.c     |   1 +
 drivers/mmc/host/sdhci-sprd.c | 149 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h      |   8 ++
 4 files changed, 172 insertions(+)

-- 
2.17.1

