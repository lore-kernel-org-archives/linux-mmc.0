From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Fri, 21 Nov 2014 08:51:36 +0800
Message-ID: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48859 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640AbaKUAwI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 19:52:08 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so3682743pad.13
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2014 16:52:07 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, chris@printf.net, ulf.hansson@linaro.org, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

Hello,

  Fujitsu have an sdhci IP which is implemented in a SoC we're 
adding to mainline, the most recent series for that was sent 
here: 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304522.html

  These patches are against v3.18-rc5 mainline and tested on
v3.18-rc5 integration tree.

  We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Thanks.

Vincent Yang (4):
  mmc: sdhci: add a voltage switch callback function
  mmc: sdhci: add a quirk for tuning work around
  mmc: sdhci: add a quirk for single block transactions
  mmc: core: hold SD Clock before CMD11 during Signal

 drivers/mmc/core/core.c   | 13 ++++++++-----
 drivers/mmc/host/sdhci.c  | 14 +++++++++++---
 drivers/mmc/host/sdhci.h  |  1 +
 include/linux/mmc/sdhci.h |  4 ++++
 4 files changed, 24 insertions(+), 8 deletions(-)

-- 
1.9.0

