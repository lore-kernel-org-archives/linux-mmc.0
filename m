Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24528A1E6;
	Wed,  6 Aug 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473470; cv=none; b=cgb4dY1McQEkJ7pDQTka7hFx3CC9nG0EoYGUQygCGsi5C9ddDI1XoM5Xw2iAB36PwZNhRR9jPyfZoX1Yt23PXGS2figKDfPOGEo/2/LGw/eMQYjfS1ZWV4AdM1DaImH/aPyL1YtasrsLgA+vfOzNmBOqw0nd3u5joMX8Yj3xhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473470; c=relaxed/simple;
	bh=u/Tn+A6diotaqys1c9iYH8Z2AYljLLraPst/MX8tZNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZsT/Lr8PX86IjTNMmOhaKFuz2+qW3QDkH7q9f8nca1M6mAdq9sjoGulx6Aab2bU6NyG0jGl93ulfx21bOzpw1HLR2y5RKDDAH131HdMpWersGoXGQK7oApoGMQpwiEhjeC0DmxNbGnSixVFKz/OGmlKv6O809lUriX7Bfb8ZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=tfE4rBTy; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="tfE4rBTy"
DKIM-Signature: a=rsa-sha256; bh=VsdEDTQz5mNEccwWC/xjHwJT4LECnNHlR21b+AgE4fw=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754473445; v=1; x=1754905445;
 b=tfE4rBTyG4K0c8GCFnAs+ENpB5IjCIo04ZjH6jA/oPRH/UlZs3kCXU41irItzIeeFdZVFgoX
 TOcgQvFBUl8dhqS1hJhsFdGnqfyIiQPpoCvkK4ZlIYMr0dfvry0+fhhf5XHONlZjxWic77iN2mE
 zjtrQYuypMQeRG/ihx3PzAocvp98FtsYuGtXoZUQLwxw67kqXEP0X3+RC0cJc5YG2ZnZAIg0Gs3
 I3wXRFNMnNPz+6b/5/RB8W2ej5YeyWiCYUUNwkvVfru1PmNkqU5yRlRN66hlGENu2vGKdP3Q7Kf
 5Rz0DtsY46sBPF73AyEd80ugD0gtz4aPvvuK4iTRqs3aQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id cdd574cd; Wed, 06 Aug 2025 11:44:05 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Wed, 06 Aug 2025 11:43:54 +0200
Subject: [PATCH v3 2/2] mmc: sdhci-pxav3: add state_uhs pinctrl setting
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250806-pxav3-uhs-v3-2-2f03fee380b0@dujemihanovic.xyz>
References: <20250806-pxav3-uhs-v3-0-2f03fee380b0@dujemihanovic.xyz>
In-Reply-To: <20250806-pxav3-uhs-v3-0-2f03fee380b0@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=u/Tn+A6diotaqys1c9iYH8Z2AYljLLraPst/MX8tZNU=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTlR8/MA2fn6hQnJt0Qdtm7dLK1otir7//Six4Gr6yP
 3Diep65HaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjCRbEuGv3LPsnSa5wgd3Mfv
 8kL2msephntLb/Lu9v9xpJ6p2VyJj42RofvmQS0N5cWqbrEnU0+afjetllfgUtl5fKrM7QUsnzL
 ZuQE=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Different bus clocks require different pinctrl states to remain stable.
Add support for selecting between a default and UHS state according to
the bus clock.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v3:
- Move pinctrl stuff out of platdata
- Add helper for pinstate lookup
- Thanks to Adrian for the suggestions

Changes in v2:
- Don't attempt to lookup pinstates if getting pinctrl fails
- Only select pinstates if both of them are valid
- dev_warn() -> dev_dbg()
---
 drivers/mmc/host/sdhci-pxav3.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3fb56face3d81259b693c8569682d05c95be2880..ceb06f1c18146eac296c6d20483a9f006567a978 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -20,9 +20,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/mbus.h>
+#include <linux/units.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -51,6 +53,9 @@ struct sdhci_pxa {
 	struct clk *clk_io;
 	u8	power_mode;
 	void __iomem *sdio3_conf_reg;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_uhs;
 };
 
 /*
@@ -313,8 +318,20 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 }
 
+static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *phost = sdhci_priv(host);
+	struct sdhci_pxa *pxa = sdhci_pltfm_priv(phost);
+	struct pinctrl_state *pins = clock < 100 * HZ_PER_MHZ ? pxa->pins_default : pxa->pins_uhs;
+
+	if (pins)
+		pinctrl_select_state(pxa->pinctrl, pins);
+
+	sdhci_set_clock(host, clock);
+}
+
 static const struct sdhci_ops pxav3_sdhci_ops = {
-	.set_clock = sdhci_set_clock,
+	.set_clock = pxav3_set_clock,
 	.set_power = pxav3_set_power,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -366,6 +383,19 @@ static inline struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 }
 #endif
 
+static struct pinctrl_state *pxav3_lookup_pinstate(struct device *dev, struct pinctrl *pinctrl,
+						   const char *name)
+{
+	struct pinctrl_state *pins = pinctrl_lookup_state(pinctrl, name);
+
+	if (IS_ERR(pins)) {
+		dev_dbg(dev, "could not get pinstate '%s': %ld\n", name, PTR_ERR(pins));
+		return NULL;
+	}
+
+	return pins;
+}
+
 static int sdhci_pxav3_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -441,6 +471,14 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			host->mmc->pm_caps |= pdata->pm_caps;
 	}
 
+	pxa->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(pxa->pinctrl)) {
+		pxa->pins_default = pxav3_lookup_pinstate(dev, pxa->pinctrl, "default");
+		if (pxa->pins_default)
+			pxa->pins_uhs = pxav3_lookup_pinstate(dev, pxa->pinctrl, "state_uhs");
+	} else
+		dev_dbg(dev, "could not get pinctrl handle: %ld\n", PTR_ERR(pxa->pinctrl));
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);

-- 
2.50.1

