From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH v5 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Tue, 20 Jan 2015 16:05:14 +0800
Message-ID: <1421741118-18743-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41141 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbATIFj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 03:05:39 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so44124096pab.4
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 00:05:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, chris@printf.net, ulf.hansson@linaro.org, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

Hello,

  Fujitsu have an sdhci IP which is implemented in a SoC we're 
adding to mainline, the most recent series for that was sent 
here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317580.html

  We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Changes since v4:
* Corrected Kconfig help text.
* Fixed checking of required clocks.
* Removed an unnecessary "else".

Changes since v3:
* Cleaned out unnecessary include files.
* Removed unnecessary goto and error message.
* Changed both clocks from optional to required.
* Removed runtime PM support.

Changes since v2:
* Removed voltage-ranges because it is no longer a required property.
* Removed unnecessary error message.
* Used the devm_* managed functions and updated the error handling
accordingly.
* Removed #ifdef CONFIG_PM_RUNTIME and also updated some other #ifdef.
* Moved vendor specfic stuff prior to sdhci_add_host().
* Handled runtime PM on module removal.

Changes since v1:
* Thanks to Uffe, removed ARCH_MB86S7X dependency and separated
mmc patches to this patchset.
* Node name changed from "fujitsu,mb86s70-sdh30" to
"fujitsu,mb86s70-sdhci-3.0".

Thanks.

Vincent Yang (4):
  mmc: sdhci: add a voltage switch callback function
  mmc: sdhci: add a quirk for tuning work around
  mmc: sdhci: add a quirk for single block transactions
  mmc: sdhci: host: add new f_sdh30

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  30 +++
 drivers/mmc/host/Kconfig                           |  11 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci.c                           |  14 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 239 +++++++++++++++++++++
 include/linux/mmc/sdhci.h                          |   4 +
 7 files changed, 297 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c

-- 
1.9.0

