From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 0/2] Fix eMMC hang on rk3188 and earlier
Date: Wed, 20 Mar 2019 20:48:03 +0300
Message-ID: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Kochetkov <al.kochet@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hello!

I found, that sometimes dw_mmc driver stop transfer data to
eMMC card on my rk3188 based board. One of tranfers hangs then
doing EDMA transfer and controller gives HTO. And here is a fix.

Alexander Kochetkov (2):
  mmc: dw_mmc: add init_slot() hook to platform function table
  mmc: dw_mmc-rockchip: fix transfer hangs on rk3188

 drivers/mmc/host/dw_mmc-rockchip.c |   19 +++++++++++++++++++
 drivers/mmc/host/dw_mmc.c          |    4 ++++
 drivers/mmc/host/dw_mmc.h          |    2 ++
 3 files changed, 25 insertions(+)

-- 
1.7.9.5
