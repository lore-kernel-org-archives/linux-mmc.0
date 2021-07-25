Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55EBC4338F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7BC6023F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhGYIkS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jul 2021 04:40:18 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:8332 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhGYIkS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 25 Jul 2021 04:40:18 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXcwt6CCbz83;
        Sun, 25 Jul 2021 11:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627204847; bh=AZX4jQMPp4itNQAWYqyQgf8lZ107duacDRUb5dMUrFw=;
        h=Date:From:Subject:To:Cc:From;
        b=BvdF8oeBa5T0aLU2PcJSjnAFd5MxV/hEStSw/3T85G4JMeuvv1wSS9e1h5AnHqtGw
         M0+9vBMmceTjAyYDf4V3kxcokH6dakNRzk/dIek5r0nFqGLiUoc6+zhJD2FLLmGWtJ
         hh3Ykw58by65pz/u9ZUEJOzt/gbuxAD3mWQErlIElv/pq2E5lBcovpZjm9J4Xa9a58
         7AQUvVovOSfxdH/c7aCxWDyHolA5NOSr9YURmeeecqDLTkn7f1Krdrqm7KDurBnx6B
         XE8Y3XyTP/juoVbDztVep6w6RKWKjNNHMu7Be2HeKLftcVjkri6D6IleSomfXOWMx1
         8KLNQd64gVpnA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 11:20:45 +0200
Message-Id: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 0/5] SDHCI clock handling fixes and cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set combines a few of code improvements for SDHCI clock
handling. First three are small fixes to the code, next two make
the clock calculation code simpler.

Michał Mirosław (5):
  mmc: sdhci: fix base clock usage in preset value
  mmc: sdhci: always obey programmable clock config in preset value
  mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
  mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN frequency limit
  mmc: sdhci: simplify v2/v3+ clock calculation

 drivers/mmc/host/sdhci-of-arasan.c  |  11 +--
 drivers/mmc/host/sdhci-of-dwcmshc.c |   8 +-
 drivers/mmc/host/sdhci.c            | 123 +++++++++++++---------------
 drivers/mmc/host/sdhci.h            |   4 +-
 4 files changed, 67 insertions(+), 79 deletions(-)

-- 
2.30.2

