From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH v3 0/3] about data busy
Date: Fri, 13 Feb 2015 19:52:45 +0800
Message-ID: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
References: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:60741 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbBMLxP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Feb 2015 06:53:15 -0500
In-Reply-To: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, olof@lixom.net, alim.akhtar@gmail.com, a.hajda@samsung.com, dianders@chromium.org
Cc: heiko@sntech.de, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Addy Ke <addy.ke@rock-chips.com>

patch 1: This patch can fix bug that controller is still data busy after
	 reset all blocks. After this patch, I still get data busy in
	 set_ios().

patch 2: This patch fix bug 'Timeout sending command'. After patch1 and
	 patch2, there is no mmc errors after:
	 cd /sys/bus/platform/drivers/dwmmc_rockchip
	 for i in $(seq 1 10000); do
  		echo "========================" $i
  		echo ff0c0000.dwmmc > unbind
  		sleep .5
  		echo ff0c0000.dwmmc > bind
  		sleep 2
	done
 
patch3: This patch fix bug that there is data busy before sdio send CMD53.
        But This patch is necessary for sd and mmc too.

Addy Ke (3):
  mmc: dw_mmc: update clock after host reach a stable voltage
  mmc: dw_mmc: fix bug that cause 'Timeout sending command'
  mmc: dw_mmc: Don't start command while data busy

 drivers/mmc/host/dw_mmc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

-- 
1.8.3.2


