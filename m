From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 0/2] Init runtime PM support for dw_mmc
Date: Fri, 23 Sep 2016 12:17:43 +0800
Message-ID: <1474604265-29837-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org


Hi Jaehoon and Ulf,

This a patchset going to support runtime PM for dw_mmc.
Basically it is a prototype design with some redundant
code there. But I think it's okay to send it out for sure
I am not heading in the wrong direction.

Still something more need to support:
(1) Support switching sd detect to gpio irq wakeup when calling
    runtime PM.
(2) Then we could disable/enable biu_clk and add off/on genpd
    for runtime PM
(3) remove dw_mci_suspend/resume and migrate dw_mci variant driver
    to use dw_mci_runtime_suspend/resume(Although I am not so sure)



Shawn Lin (2):
  mmc: dw_mmc: add runtime PM callback
  mmc: dw_mmc-rockchip: add runtime PM support

 drivers/mmc/host/dw_mmc-rockchip.c | 57 ++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.c          | 60 ++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.h          |  4 ++-
 3 files changed, 115 insertions(+), 6 deletions(-)

-- 
2.3.7
