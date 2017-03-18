From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v5 0/2] mmc: host: s3cmci: add device tree support
Date: Fri, 17 Mar 2017 22:13:51 -0300
Message-ID: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33850 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdCRBOY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 21:14:24 -0400
Received: by mail-qk0-f193.google.com with SMTP id v127so11818988qkb.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 18:14:23 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
Cc: Sergio Prado <sergio.prado@e-labworks.com>

This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
controller via device tree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Changes since v4 (as suggested by Jaehoon Chung):
- using just a flag as a data structure for the driver to check for
  s3c2400 compatibility

Changes since v3 (as suggested by Rob Herring):
- describing properties that wasn't documented and removing unnecessary
  comment in the device tree binding

Changes since v2:
- struct "s3cmci_drv_data" and flag "is2440" renamed
- copying the whole driver data struct instead of only its member so
  it will be easier to extend the information in the future
- using mmc_of_parse() to read "cd-gpios" and "wp-gpios" properties
  from device tree

Changes since v1:
- pinctrl description removed from DT binding
- unit and label on DT binding renamed to mmc

Sergio Prado (2):
  dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
  mmc: host: s3cmci: allow probing from device tree

 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  42 ++++
 drivers/mmc/host/s3cmci.c                          | 257 ++++++++++-----------
 2 files changed, 168 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

-- 
1.9.1

