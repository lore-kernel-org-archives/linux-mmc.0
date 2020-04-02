Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA52C43331
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB3C206D3
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="YpVB3Y0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbgDBLy4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:54:56 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:57265 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387722AbgDBLy4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 07:54:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1p09thz9j;
        Thu,  2 Apr 2020 13:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828495; bh=SUZOg/tdo/PI/jczvgr7ZOhvxU+amuVx28JA0/7SYOQ=;
        h=Date:From:Subject:To:Cc:From;
        b=YpVB3Y0Ew1pROTQ2fQHIls1smJnMniRdywu9QNwke2+AA2git5jCCmMilOtF78E2z
         wr1B7bLsRS9IAlWZbulnUKLVQaOs55Q5zc9Tl4gldMHHl/+6ZMaPmp239MwtI4Y8QY
         Vm7t1Ri0KfV+1/hhu9fGSs4s0cgLIyHPaEZVys1vaXXpNIRB3m41Vi0P9jVRrUx8HI
         U+bfYJgDTG1Eb2zvVQEXwkkO3916m3388AU732dnIrpVGBBROlRHSftibYQavam2yk
         9KCwVPq79KUrXkp289+XqZ29LgfzCgpRzfw1jye1E8PvUdIojuRzYk5ro/01rRjmm/
         6Pu6TJY90ujXA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:53 +0200
Message-Id: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/7] SDHCI clock handling fixes and cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set combines a few of code improvements for SDHCI clock handling.
Besides small fixes, most value comes from simplifying the code, so it's
easier to understand.

Michał Mirosław (7):
  mmc: sdhci: fix base clock usage in preset value
  mmc: sdhci: fix programmable clock config from preset value
  mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
  mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN frequency limit
  mmc: sdhci: simplify clock frequency calculation
  mmc: sdhci: squash v2/v3+ clock calculation differences
  mmc: sdhci: respect non-zero div quirk in programmable clock mode

 drivers/mmc/host/sdhci-of-arasan.c |   7 +-
 drivers/mmc/host/sdhci.c           | 126 +++++++++++++----------------
 drivers/mmc/host/sdhci.h           |   4 +-
 3 files changed, 64 insertions(+), 73 deletions(-)

-- 
2.20.1

