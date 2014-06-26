From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [RFC PATCH v2 0/6] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Thu, 26 Jun 2014 14:23:26 +0800
Message-ID: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:63819 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaFZGXk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jun 2014 02:23:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, andy.green@linaro.org, jaswinder.singh@linaro.org, Vincent.Yang@tw.fujitsu.com

Hi,
We are adding support for a new Fujitsu sdhci IP.

These patches are against v3.16-rc1 mainline since nothing in
mmc-next at this moment.

These patches are tested on 3.16-rc1 integration tree.

We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Changes from v1:
- Add sufficient description in DT binding ducument
- Remove one patch "mmc: sdhci: add quirk for broken 3.0V support" and use
  voltage-ranges = <> in the device tree instead

Thanks a lot!

Best regards,
Vincent Yang


Vincent Yang (6):
  mmc: sdhci: add quirk for voltage switch callback
  mmc: sdhci: add quirk for tuning work around
  mmc: sdhci: add quirk for single block transactions
  mmc: sdhci: host: add new f_sdh30
  mmc: core: hold SD Clock before CMD11 during Signal Voltage Switch
    Procedure
  mmc: core: add manual resume capability

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 ++
 drivers/mmc/core/core.c                            |   8 +-
 drivers/mmc/core/sd.c                              |   4 +
 drivers/mmc/host/Kconfig                           |   7 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci.c                           |  15 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 435 +++++++++++++++++++++
 drivers/mmc/host/sdhci_f_sdh30.h                   |  40 ++
 include/linux/mmc/host.h                           |  14 +
 include/linux/mmc/sdhci.h                          |   6 +
 11 files changed, 561 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h

-- 
1.9.0

