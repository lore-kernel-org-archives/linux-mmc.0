From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 5/5] clk: berlin: bg2: remove CLK_IGNORE_UNUSED flag for sdio clk
Date: Mon, 12 Oct 2015 13:46:36 +0800
Message-ID: <1444628796-5484-6-git-send-email-jszhang@marvell.com>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

The axi clock properties already exists, so there's no need to set this
flag for sdio0 and sdio1 clk any more.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/berlin/bg2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index 73153fc..23e0e3b 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -490,8 +490,8 @@ static const struct berlin2_gate_data bg2_gates[] __initconst = {
 	{ "usb0",	"perif",	11 },
 	{ "usb1",	"perif",	12 },
 	{ "pbridge",	"perif",	13, CLK_IGNORE_UNUSED },
-	{ "sdio0",	"perif",	14, CLK_IGNORE_UNUSED },
-	{ "sdio1",	"perif",	15, CLK_IGNORE_UNUSED },
+	{ "sdio0",	"perif",	14 },
+	{ "sdio1",	"perif",	15 },
 	{ "nfc",	"perif",	17 },
 	{ "smemc",	"perif",	19 },
 	{ "audiohd",	"audiohd_pll",	26 },
-- 
2.6.1
