Return-Path: <SRS0=inFY=2O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECC3C3F68F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A32E208C4
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLXHZH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:25:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfLXHZG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Dec 2019 02:25:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A040E223CA7032CD301C;
        Tue, 24 Dec 2019 15:25:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 15:24:55 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/6] mmc: use true,false for bool variable
Date:   Tue, 24 Dec 2019 15:32:09 +0800
Message-ID: <1577172735-18869-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

zhengbin (6):
  mmc: core: use true,false for bool variable
  mmc: sdhci-tegra: use true,false for bool variable
  mmc: sdhci-msm: use true,false for bool variable
  mmc: omap_hsmmc: use true,false for bool variable
  mmc: davinci: use true,false for bool variable
  mmc: owl: use true,false for bool variable

 drivers/mmc/core/core.c        | 2 +-
 drivers/mmc/host/davinci_mmc.c | 6 +++---
 drivers/mmc/host/omap_hsmmc.c  | 6 +++---
 drivers/mmc/host/owl-mmc.c     | 4 ++--
 drivers/mmc/host/sdhci-msm.c   | 4 ++--
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

--
2.7.4

