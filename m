From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v2 0/2] mmc: host: s3cmci: add device tree support
Date: Fri,  9 Dec 2016 11:14:42 -0200
Message-ID: <1481289284-19919-1-git-send-email-sergio.prado@e-labworks.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33739 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbcLINRW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 08:17:22 -0500
Received: by mail-qt0-f194.google.com with SMTP id n6so1990547qtd.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Dec 2016 05:17:21 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
Cc: Sergio Prado <sergio.prado@e-labworks.com>

This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
controller via device tree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Changes since v1:
- pinctrl description removed from DT binding
- unit and label on DT binding renamed to mmc

Sergio Prado (2):
  dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
  mmc: host: s3cmci: allow probing from device tree

 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  34 +++++
 drivers/mmc/host/s3cmci.c                          | 155 +++++++++++++++++----
 2 files changed, 165 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

-- 
1.9.1

