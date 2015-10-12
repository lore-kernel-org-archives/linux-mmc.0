From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 4/5] clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag for sdio
 clk
Date: Mon, 12 Oct 2015 13:46:35 +0800
Message-ID: <1444628796-5484-5-git-send-email-jszhang@marvell.com>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: Jisheng Zhang <jszhang@marvell.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Since we have added the necessary axi clk properties in dts, we can
remove the "sdio" clk's CLK_IGNORE_UNUSED flag now.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/berlin/bg2q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 221f40c..243f421 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -283,7 +283,7 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
 	{ "usb2",	"perif",	13 },
 	{ "usb3",	"perif",	14 },
 	{ "pbridge",	"perif",	15, CLK_IGNORE_UNUSED },
-	{ "sdio",	"perif",	16, CLK_IGNORE_UNUSED },
+	{ "sdio",	"perif",	16 },
 	{ "nfc",	"perif",	18 },
 	{ "pcie",	"perif",	22 },
 };
-- 
2.6.1
