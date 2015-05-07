From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/3] dw_mmc-k3 support hi6220
Date: Thu,  7 May 2015 15:56:38 +0800
Message-ID: <1430985401-12202-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35341 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbbEGH4w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2015 03:56:52 -0400
Received: by pdbqd1 with SMTP id qd1so34331345pdb.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2015 00:56:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

v2: 
fix comments from Jaehoon
fix some issues in sdr12 & sdr25 mode


Zhangfei Gao (3):
  Document: dw_mmc-k3: add document of hi6220 mmc
  mmc: dw_mmc: add switch_voltage
  mmc: dw_mmc: k3: support hi6220

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |  28 ++++++
 drivers/mmc/host/dw_mmc-k3.c                       | 101 ++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.c                          |   4 +
 drivers/mmc/host/dw_mmc.h                          |   2 +
 4 files changed, 133 insertions(+), 2 deletions(-)

-- 
1.9.1

