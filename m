From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 08/13] mmc: mediatek: add busy_check support
Date: Mon, 9 Oct 2017 19:35:21 +0800
Message-ID: <1507548926-9555-9-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1507548926-9555-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

bit7 of PATCH_BIT1 has different meaning in new design, to
compatible with previous platform, clear this bit in new
platform.

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e7462fe..555824d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -315,6 +315,7 @@ struct mtk_mmc_compatible {
 	bool pad_tune0;
 	bool async_fifo;
 	bool data_tune;
+	bool busy_check;
 };
 
 struct msdc_tune_para {
@@ -379,6 +380,7 @@ struct msdc_host {
 	.pad_tune0 = false,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
@@ -386,6 +388,7 @@ struct msdc_host {
 	.pad_tune0 = false,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
@@ -393,6 +396,7 @@ struct msdc_host {
 	.pad_tune0 = true,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
@@ -400,6 +404,7 @@ struct msdc_host {
 	.pad_tune0 = true,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = true,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -1276,6 +1281,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
 	writel(0xffff4089, host->base + MSDC_PATCH_BIT1);
 	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
+	if (host->dev_comp->busy_check)
+		sdr_clr_bits(host->base + MSDC_PATCH_BIT1, (1 << 7));
 	if (host->dev_comp->async_fifo) {
 		sdr_set_field(host->base + MSDC_PATCH_BIT2,
 			      MSDC_PB2_RESPWAIT, 3);
-- 
1.8.1.1.dirty
