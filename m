From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 2/6] pinctrl: sh-pfc: Add set_mux operation to struct
 sh_pfc_function
Date: Sun, 17 May 2015 01:28:43 +0100
Message-ID: <1431822523.4222.169.camel@xylophone.i.decadent.org.uk>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

In some cases a change of function requires changes in more than just
the GPSR/IPSR registers.  In particular, changing the SDHI between 3.3V
and 1.8V signalling also requires modifying IOCTRL6.

Add this optional operation so that such special cases can be handled
in each SoC's code.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |    4 ++++
 drivers/pinctrl/sh-pfc/sh_pfc.h  |   10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 072e7c62cab7..068b1cdeddde 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -317,6 +317,7 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct sh_pfc *pfc = pmx->pfc;
+	const struct sh_pfc_function *func = &pfc->info->functions[selector];
 	const struct sh_pfc_pin_group *grp = &pfc->info->groups[group];
 	unsigned long flags;
 	unsigned int i;
@@ -340,6 +341,9 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
 			break;
 	}
 
+	if (func->set_mux)
+		func->set_mux(pfc, func, grp);
+
 done:
 	spin_unlock_irqrestore(&pfc->lock, flags);
 	return ret;
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index c7508d5f6886..0ce4f5c7add8 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -28,6 +28,8 @@ enum {
 #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
 #define SH_PFC_PIN_CFG_NO_GPIO		(1 << 31)
 
+struct sh_pfc;
+
 struct sh_pfc_pin {
 	u16 pin;
 	u16 enum_id;
@@ -50,17 +52,23 @@ struct sh_pfc_pin_group {
 	unsigned int nr_pins;
 };
 
-#define SH_PFC_FUNCTION(n)				\
+#define SH_PFC_FUNCTION_SPECIAL(n, set_mux_fn)		\
 	{						\
 		.name = #n,				\
 		.groups = n##_groups,			\
 		.nr_groups = ARRAY_SIZE(n##_groups),	\
+		.set_mux = (set_mux_fn),		\
 	}
 
+#define SH_PFC_FUNCTION(n) SH_PFC_FUNCTION_SPECIAL(n, NULL)
+
 struct sh_pfc_function {
 	const char *name;
 	const char * const *groups;
 	unsigned int nr_groups;
+	void (*set_mux)(struct sh_pfc *pfc,
+			const struct sh_pfc_function *func,
+			const struct sh_pfc_pin_group *grp);
 };
 
 struct pinmux_func {
-- 
1.7.10.4




