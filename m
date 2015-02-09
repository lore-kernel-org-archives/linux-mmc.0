From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH v2 2/2] mmc: dw_mmc: Don't start command while data busy
Date: Mon,  9 Feb 2015 15:25:26 +0800
Message-ID: <1423466726-20833-3-git-send-email-addy.ke@rock-chips.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
 <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, amstan@chromium.org, djkurtz@chromium.org
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, zhenfu.fang@rock-chips.com, cf@rock-chips.com, lintao@rock-chips.com, chenfen@rock-chips.com, zyf@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zhangqing@rock-chips.com, hl@rock-chips.com, Addy Ke <addy.ke@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We should wait for data busy here in non-volt-switch state.
This may happend when sdio sends CMD53.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b0b57e3..b40080d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1007,6 +1007,13 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
 
+	/*
+	 * We should wait for data busy here in non-volt-switch state.
+	 * This may happend when sdio sends CMD53.
+	 */
+	if (host->state != STATE_WAITING_CMD11_DONE)
+		dw_mci_wait_busy(slot);
+
 	cmdflags = dw_mci_prepare_command(slot->mmc, cmd);
 
 	/* this is the first command, send the initialization clock */
-- 
1.8.3.2
