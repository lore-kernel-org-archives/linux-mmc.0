From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH 0/2] add runtime pm support for xenon
Date: Thu, 24 Aug 2017 15:19:36 -0700
Message-ID: <1503613178-26912-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34389 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753411AbdHXWQc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2017 18:16:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

These two patches added runtime pm support for xenon and
re-implemented standby support based on runtime pm API.

Zhoujie Wu (2):
  mmc: sdhci-xenon: add runtime pm support
  mmc: sdhci-xenon: implement system standby base on runtime pm

 drivers/mmc/host/sdhci-xenon.c | 76 ++++++++++++++++++++++++++++++++----------
 drivers/mmc/host/sdhci-xenon.h |  1 +
 2 files changed, 60 insertions(+), 17 deletions(-)

-- 
1.9.1

