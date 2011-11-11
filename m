From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH V2 11/14] serial: imx: add clk_prepare/clk_unprepare
Date: Fri, 11 Nov 2011 09:10:26 +0800
Message-ID: <1320973829-4388-12-git-send-email-richard.zhao@linaro.org>
References: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org
Cc: linux@arm.linux.org.uk, amit.kucheria@canonical.com, kernel@pengutronix.de, ben-linux@fluff.org, cjb@laptop.org, alan@linux.intel.com, eric.miao@linaro.org, Richard Zhao <richard.zhao@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/tty/serial/imx.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..8f3709f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1390,7 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 		ret = PTR_ERR(sport->clk);
 		goto unmap;
 	}
-	clk_enable(sport->clk);
+	clk_prepare_enable(sport->clk);
 
 	sport->port.uartclk = clk_get_rate(sport->clk);
 
@@ -1413,8 +1413,8 @@ deinit:
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 clkput:
+	clk_disable_unprepare(sport->clk);
 	clk_put(sport->clk);
-	clk_disable(sport->clk);
 unmap:
 	iounmap(sport->port.membase);
 free:
@@ -1434,11 +1434,10 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 	if (sport) {
 		uart_remove_one_port(&imx_reg, &sport->port);
+		clk_disable_unprepare(sport->clk);
 		clk_put(sport->clk);
 	}
 
-	clk_disable(sport->clk);
-
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 
-- 
1.7.5.4
