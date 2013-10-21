From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [v2 PATCH 0/2] mmc: dw_mmc: add dw_mmc-k3
Date: Mon, 21 Oct 2013 15:13:57 +0800
Message-ID: <1382339639-16764-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39352 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab3JUHOL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2013 03:14:11 -0400
Received: by mail-pd0-f169.google.com with SMTP id q10so5833482pdj.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2013 00:14:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

v2:
Follow Jaehoon's suggestion
Use slot-gpio.c handle cd pin
Move table out to dts
other suggestion

Zhangfei Gao (2):
  mmc: dw_mmc: add dw_mci_of_get_cd_gpio to handle cd pin
  mmc: dw_mmc: add dw_mmc-k3 for k3 platform

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   77 +++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  298 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c                          |   34 +++
 5 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5

