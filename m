From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [RFC PATCH 0/7] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Fri, 20 Jun 2014 17:35:21 +0800
Message-ID: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57959 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933582AbaFTJfe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jun 2014 05:35:34 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so2913906pbb.22
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jun 2014 02:35:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, andy.green@linaro.org, Vincent.Yang@tw.fujitsu.com

Hi,
We are adding support for a new Fujitsu sdhci IP.

These patches are against v3.16-rc1 mainline since nothing in
mmc-next at this moment.

These patches are tested on 3.16-rc1 integration tree.

We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Thanks a lot!


Best regards,
Vincent Yang


Vincent Yang (7):
  mmc: sdhci: add quirk for broken 3.0V support
  mmc: sdhci: add quirk for voltage switch callback
  mmc: sdhci: add quirk for tuning work around
  mmc: sdhci: add quirk for single block transactions
  mmc: sdhci: host: add new f_sdh30
  mmc: core: hold SD Clock before CMD11 during Signal Voltage Switch
    Procedure
  mmc: core: add manual resume capability

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  25 ++
 drivers/mmc/core/core.c                            |   8 +-
 drivers/mmc/core/sd.c                              |   4 +
 drivers/mmc/host/Kconfig                           |   7 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci.c                           |  18 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 429 +++++++++++++++++++++
 drivers/mmc/host/sdhci_f_sdh30.h                   |  40 ++
 include/linux/mmc/host.h                           |  14 +
 include/linux/mmc/sdhci.h                          |   8 +
 11 files changed, 550 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h

-- 
1.9.0

