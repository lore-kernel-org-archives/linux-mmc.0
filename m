Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D421CA02;
	Fri, 18 Jul 2025 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873212; cv=none; b=ZrKsHaC4WlNReervL+AB7x8x687BAfA1aXpUEgTpHmSCrRTcwfHSnGObKJzh56EMqJa3eO5Wol5qLaECtHsaVqtueIt1Qn3SBL06/TeUpJVbAGj25+99QXjKNd7qhjkZjFz7vqdWW6B8yo+hucsMPPb0aYzDM4vUZ7vH7tt+7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873212; c=relaxed/simple;
	bh=3RYvkarqfHdoc1OgLllqlLng0i6a19ZDq3zI5M3B0aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bn2khkIN24dGBZwXy4h1W6aG6y/QaT7t73jMtPwtEriTdsPI0XH4iU/DBOG02UsQXFQ9Mj4+OjEpPt+9/M9pxtgHttKfdGlNc31TspU32zA0oMWtXqfy4G5x8B9JTOXSajeIZ7bdHSoQ32pjpoRv5ap0KWoqCThe/afPeDaGvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=DDfPeXbV; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="DDfPeXbV"
DKIM-Signature: a=rsa-sha256; bh=gOjp3wQjJ3AE6k78BMHRLvaT8uRUMtnV0AD3Afp4oe8=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1752873185; v=1; x=1753305185;
 b=DDfPeXbVCBvhb7ZGTPiKJV+pOmX67OglQeZPg6nRg7KtNVqIzyCH9gUDE4+AjwnoDf55OlqK
 RPgFUJ5MvsIF16pfLEbtR3uvbLgh0kvLjmkIR5VSc2W5oIj6kblw3kkkFg+wWgoUEjV1SNKdBFK
 ffWpiz/pJGD/PeL8cVAUDbLS2OaMELidr2J5/Lc1tfDsLR9bdvqVxrmSZ7ruX6iOPQmvisbwDop
 +EF+REX2INqioiu/bnUO4IHU7HKLqx59KunJCiwArfrVfuXVxBs0DmBNXeAI+8xiNiAdSxzI7x2
 YtuxlzRzSJcVCz3jfSS7es+XAfldMPwhg0M+BFklwE5gw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id e2145e2d; Fri, 18 Jul 2025 23:13:05 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 18 Jul 2025 23:12:39 +0200
Subject: [PATCH RFC 2/2] mmc: sdhci-pxav3: add state_uhs pinctrl setting
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-pxav3-uhs-v1-2-2e451256f1f6@dujemihanovic.xyz>
References: <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
In-Reply-To: <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=3RYvkarqfHdoc1OgLllqlLng0i6a19ZDq3zI5M3B0aY=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlVO+6zci4QbZHIm/DLQ1UoWInhAbP5s96Gp11mGqtzn
 c3SVvh0lLIwiHExyIopsuT+d7zG+1lk6/bsZQYwc1iZQIYwcHEKwERyJjMyzF7aNW3+irDTlkej
 evMVLc8F7jtoV91jpcxzdNZdCR3Gvwz/c9gc//4VqpPxuFljsruaics0fnZ4tppIfOCvIoHsRRf
 4AQ==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Different bus clocks require different pinctrl states to remain stable.
Add support for selecting between a default and UHS state according to
the bus clock.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 drivers/mmc/host/sdhci-pxav3.c          | 30 +++++++++++++++++++++++++++++-
 include/linux/platform_data/pxa_sdhci.h |  7 +++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3fb56face3d81259b693c8569682d05c95be2880..0e1bd75a1252e5559deb0b3caabcdc75919aee3d 100644
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
@@ -313,8 +315,24 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 }
 
+static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (clock < 100 * HZ_PER_MHZ) {
+		if (!IS_ERR(pdata->pins_default))
+			pinctrl_select_state(pdata->pinctrl, pdata->pins_default);
+	} else {
+		if (!IS_ERR(pdata->pins_uhs))
+			pinctrl_select_state(pdata->pinctrl, pdata->pins_uhs);
+	}
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
@@ -441,6 +459,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			host->mmc->pm_caps |= pdata->pm_caps;
 	}
 
+	pdata->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(pdata->pinctrl))
+		dev_warn(dev, "could not get pinctrl handle\n");
+	pdata->pins_default = pinctrl_lookup_state(pdata->pinctrl, "default");
+	if (IS_ERR(pdata->pins_default))
+		dev_warn(dev, "could not get default state\n");
+	pdata->pins_uhs = pinctrl_lookup_state(pdata->pinctrl, "state_uhs");
+	if (IS_ERR(pdata->pins_uhs))
+		dev_warn(dev, "could not get uhs state\n");
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 899457cee425d33f82606f0b8c280003bc73d48d..540aa36db11243719707bdf22db23a8e2035674d 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -35,6 +35,9 @@
  * @quirks: quirks of platfrom
  * @quirks2: quirks2 of platfrom
  * @pm_caps: pm_caps of platfrom
+ * @pinctrl: pinctrl handle
+ * @pins_default: default pinctrl state
+ * @pins_uhs: pinctrl state for fast (>100 MHz) bus clocks
  */
 struct sdhci_pxa_platdata {
 	unsigned int	flags;
@@ -47,5 +50,9 @@ struct sdhci_pxa_platdata {
 	unsigned int	quirks;
 	unsigned int	quirks2;
 	unsigned int	pm_caps;
+
+	struct pinctrl	     *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_uhs;
 };
 #endif /* _PXA_SDHCI_H_ */

-- 
2.50.1

