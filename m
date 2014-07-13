From: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Subject: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Sun, 13 Jul 2014 13:21:06 +0800
Message-ID: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36992 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaGMFWE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jul 2014 01:22:04 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so3572666pab.8
        for <linux-mmc@vger.kernel.org>; Sat, 12 Jul 2014 22:22:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, arnd@arndb.de, olof@lixom.net, linux@arm.linux.org.uk, chris@printf.net, anton@enomsg.org, t.takinishi@jp.fujitsu.com, mollie.wu@linaro.org, Vincent.Yang@tw.fujitsu.com

Hi,
We are adding support for a new Fujitsu sdhci IP.
These patches are preparations and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

These patches are against v3.16-rc4 mainline since nothing in
mmc-next at this moment.

These patches are tested on 3.16-rc4 integration tree.

We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Thanks a lot!

Best regards,
Vincent Yang


Vincent Yang (4):
  mmc: sdhci: add quirk for voltage switch callback
  mmc: sdhci: add quirk for tuning work around
  mmc: sdhci: add quirk for single block transactions
  mmc: core: hold SD Clock before CMD11 during Signal

 drivers/mmc/core/core.c   |  4 ++--
 drivers/mmc/host/sdhci.c  | 15 ++++++++++++---
 drivers/mmc/host/sdhci.h  |  1 +
 include/linux/mmc/sdhci.h |  6 ++++++
 4 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.9.0

