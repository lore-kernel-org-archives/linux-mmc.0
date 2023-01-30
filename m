Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9591C54EED
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 07:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjA3Hnw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 02:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjA3Hnw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 02:43:52 -0500
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 23:43:50 PST
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659581630A
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 23:43:50 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 82B8228022C;
        Mon, 30 Jan 2023 15:38:07 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Some features and fix for sdhci-of-dwcmshc
Date:   Mon, 30 Jan 2023 15:38:02 +0800
Message-Id: <1675064285-25425-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUlPVkkaT0JDQkpCTUlJT1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhA6Mww5Aj0UNjg5OBJJTSM6
        CSgaFENVSlVKTUxOS01PSUNDSk5IVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpITEw3Bg++
X-HM-Tid: 0a86019ca1a62eb1kusn82b8228022c
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patchset has 3 patches. The first one is a signal improvement
actually. Then we add runtime time support and hsq support which have
been tested in vendor kernel for a long time.



Shawn Lin (3):
  mmc: sdhci-of-dwcmshc: Update DLL and pre-change delay for rockchip
    platform
  mmc: sdhci-of-dwcmshc: Add runtime PM support
  mmc: sdhci-of-dwcmshc: Add host software queue support

 drivers/mmc/host/sdhci-of-dwcmshc.c | 90 ++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 6 deletions(-)

-- 
2.7.4

