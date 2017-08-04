From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH 2/2] mmc: sunxi: fix new timings mode on A64
 EMMC (MMC2) controller
Date: Sat,  5 Aug 2017 05:35:55 +0800
Message-ID: <20170804213555.6024-2-icenowy@aosc.io>
References: <20170804213555.6024-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBTORSPGAKGQEB7GSRAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170804213555.6024-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The configuration struct of A64 EMMC(MMC2) compatible used to
have the needs_new_timings variable missing, which lead to NULL
pointer dereference now when trying to set up the old timings mode, as
the old timings mode doesn't exist at all on A64.

Fix this issue by adding this variable and setting it to true in
the configuration struct.

Fixes: 4fb3ce07eafa ("mmc: sunxi: Add EMMC (MMC2) controller compatible")

Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 59aba93beffb..4ad643e37014 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1142,6 +1142,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.idma_des_size_bits = 13,
 	.clk_delays = NULL,
 	.can_calibrate = true,
+	.needs_new_timings = true,
 };
 
 static const struct of_device_id sunxi_mmc_of_match[] = {
-- 
2.13.0
