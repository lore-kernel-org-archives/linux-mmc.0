From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] mmc: dw_mmc: k3 remove clk_table
Date: Mon, 13 Jan 2014 17:14:27 +0800
Message-ID: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57820 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaAMJOk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 04:14:40 -0500
Received: by mail-pa0-f48.google.com with SMTP id lf10so5056129pab.7
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 01:14:39 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

clk_table is used to set clock source in each mode, as well as limitation, max_rate and init rate.
It concerned many experts though, and Seungwon recommended some limitation can be hide in clk.c.
Also soc is updated as the limitation now same as max_rate, so directly using ios->clock.

Zhangfei Gao (2):
  clk: hisilicon: add hi3620_mmc_clks
  mmc: dw_mmc: k3: remove clk_table

 .../bindings/arm/hisilicon/hisilicon.txt           |   14 +
 .../devicetree/bindings/clock/hi3620-clock.txt     |    1 +
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   14 -
 drivers/clk/hisilicon/clk-hi3620.c                 |  267 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc-k3.c                       |   41 +--
 include/dt-bindings/clock/hi3620-clock.h           |    5 +
 6 files changed, 289 insertions(+), 53 deletions(-)

-- 
1.7.9.5

