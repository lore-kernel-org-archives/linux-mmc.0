Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A026A0D5;
	Fri,  1 Aug 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057690; cv=none; b=UHbCOwLL9XdofG6Y8WED0DgaVsEqJd/u+ioCx4TCvKrb8wVd13jzSV9fViDRKu0ieisjqOKSnZBoWfd7ZCGWYGlfJ+PFYV/khfFc7HacZaTcIGdI5VFOp80Ti4MMALgwBAt+JsZ4H6RsKH99C6RP67Tog8CQ3Y3iEyQcbyy3bQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057690; c=relaxed/simple;
	bh=foJl8uzAJuFQqQ+PCaXvTP3D2rE0lPDeDwyI/xMymi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIObxIFpiUnTy7BvOmGSnTMCdwD9tQgOx1guhAXpfxXYHNKGR061GGJcqWNSa6CtCl3m6cRKk2lO4BrdTaifcqOcMS8V9RQtTAwodb39xjqF4qMmtcUG68U3cjz2PL+n2NnUf7Vd13dtufb3ZoDZkfRZ/pv9XJkJNdKaE+z3k9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Uz7lqb6I; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Uz7lqb6I"
DKIM-Signature: a=rsa-sha256; bh=WfI/drTmX8KsyfpWpr1+Sg8ZNPmXVshUsQqSJlSBCvc=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754057670; v=1; x=1754489670;
 b=Uz7lqb6I5TYO+NdSCegOuLWEd/jQpNJvn5Dk+eiCc1Oi15J0gSTW5splWfWKskWe1pAMbCzc
 4OL8YKB2SEw6rBqaamzmx/QO0i2zFuKSsHBHCi4kLIwdoojETZpcAdqE5uX6rpQkIHBitY/DkW8
 zM3zGXAiF0zlNG5uxaaXrpEpwwAsxa0AbxHNEFsODB0KuQFIwt/sj7m+OupMd3u37jkymQZxsZB
 zi53AllIMbxXChwiWHu4CYh6gxNB5ycPBrdULs7ICFm9vT8h7jWLjfHQ4UbyRS4Dw11yLMaYOSE
 PvTdeyZRAbDQcgCCmmDukWGcdAzGYkqUz3gC9kPCQMP6w==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id c5c0c4f6; Fri, 01 Aug 2025 16:14:30 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 01 Aug 2025 16:14:16 +0200
Subject: [PATCH RFC v2 2/2] mmc: sdhci-pxav3: add state_uhs pinctrl setting
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250801-pxav3-uhs-v2-2-afc1c428c776@dujemihanovic.xyz>
References: <20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz>
In-Reply-To: <20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3797;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=foJl8uzAJuFQqQ+PCaXvTP3D2rE0lPDeDwyI/xMymi0=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBk9p4+ISEndjp27rmRaqRKrYsK6d/b+pstPMBsKJmzmO
 cnw4GpuRykLgxgXg6yYIkvuf8drvJ9Ftm7PXmYAM4eVCWQIAxenAExESZyRoeXlxAUi651y7DXn
 yhrcOujG8N/7zrZKEYdJ02dfrt54h4/hr9wpn1qB1efOXm2wN5vM9mz5/+ae+HUzXp6dvy63JcE
 8gBMA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Different bus clocks require different pinctrl states to remain stable.
Add support for selecting between a default and UHS state according to
the bus clock.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v2:
- Don't attempt to lookup pinstates if getting pinctrl fails
- Only select pinstates if both of them are valid
- dev_warn() -> dev_dbg()
---
 drivers/mmc/host/sdhci-pxav3.c          | 31 ++++++++++++++++++++++++++++++-
 include/linux/platform_data/pxa_sdhci.h |  7 +++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3fb56face3d81259b693c8569682d05c95be2880..fc6018de92fb19f028b776df0f87937846621e95 100644
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
@@ -313,8 +315,23 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 }
 
+static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (!(IS_ERR(pdata->pinctrl) || IS_ERR(pdata->pins_default) || !IS_ERR(pdata->pins_uhs))) {
+		if (clock < 100 * HZ_PER_MHZ)
+			pinctrl_select_state(pdata->pinctrl, pdata->pins_default);
+		else
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
@@ -441,6 +458,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			host->mmc->pm_caps |= pdata->pm_caps;
 	}
 
+	pdata->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(pdata->pinctrl)) {
+		pdata->pins_default = pinctrl_lookup_state(pdata->pinctrl, "default");
+		if (IS_ERR(pdata->pins_default))
+			dev_dbg(dev, "could not get default state: %ld\n",
+					PTR_ERR(pdata->pins_default));
+		pdata->pins_uhs = pinctrl_lookup_state(pdata->pinctrl, "state_uhs");
+		if (IS_ERR(pdata->pins_uhs))
+			dev_dbg(dev, "could not get uhs state: %ld\n", PTR_ERR(pdata->pins_uhs));
+	} else
+		dev_dbg(dev, "could not get pinctrl handle: %ld\n", PTR_ERR(pdata->pinctrl));
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

