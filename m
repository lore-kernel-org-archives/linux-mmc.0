From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] add dw_mmc-k3.c
Date: Thu, 10 Oct 2013 22:36:51 +0800
Message-ID: <1381415813-9395-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:55692 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab3JJOjH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Oct 2013 10:39:07 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so2666310pdj.2
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 07:39:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Support mmc for k3v2, base on dw_mmc.c

Zhangfei Gao (2):
  mmc: dw_mmc: change definition of get_cd
  mmc: add dw-mmc-k3

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   66 ++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  392 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c                          |    2 +-
 include/linux/mmc/dw_mmc.h                         |    2 +-
 6 files changed, 471 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5

