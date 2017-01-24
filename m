From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v4 0/2] mmc: pwrseq: add support for Marvell SD8787 chip
Date: Mon, 23 Jan 2017 19:08:28 -0800
Message-ID: <20170124030830.21766-1-matt@ranostay.consulting>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35296 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAXDIj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2017 22:08:39 -0500
Received: by mail-pg0-f54.google.com with SMTP id 194so50444833pgd.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2017 19:08:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tony@atomide.com, ulf.hansson@linaro.org, Matt Ranostay <matt@ranostay.consulting>

Changes from v1:
* split devictree docs from pwrseq changes
* rebase devicetree documents due to filename change
* rebase pwrseq patchset

Changes from v2:
* update device tree bindings to powerdown-gpios and document
  active state

Changes from v3:
* actually update patchset series
* correct overlooked gpio to gpios renaming of properties

Matt Ranostay (2):
  devicetree: document new marvell-8xxx and pwrseq-sd8787 options
  mmc: pwrseq: add support for Marvell SD8787 chip

 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt  |  16 +++
 .../bindings/net/wireless/marvell-8xxx.txt         |   7 +-
 drivers/mmc/core/Kconfig                           |  10 ++
 drivers/mmc/core/Makefile                          |   1 +
 drivers/mmc/core/pwrseq_sd8787.c                   | 117 +++++++++++++++++++++
 5 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
 create mode 100644 drivers/mmc/core/pwrseq_sd8787.c

-- 
2.10.2

