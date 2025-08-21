Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02470222599;
	Thu, 21 Aug 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775253; cv=none; b=LA3rBaggaZ1Ea9xKsjfVwGkPQQaHz1HQHEkpipscjfDyvEbX1WpXOYTqX6W59vAwWV9EAhAcCNJdTJfk2EyQStj/gI2fUTPJHWKiwUICVUJ7AccPGLHzkTPulF4Qw4C7vTL9Ndjv5ko2Q/WNvVOwpHRM2Fu3z4gUIZiMBV938jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775253; c=relaxed/simple;
	bh=Q4npPNa8PUekFYlhJuH6KQeooA2aD9xYG1c6BK+8yj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2bmSPxtjo74r9ieUb2qAxtQA+VTNlnZwWeIp28BvzhvoM3F91PrA4CGit9xn2NWFmG/QGZ0/65RCPkE+YrbYiExv9Tv81dDdanI8CQyiD4Hbg74//Lf+7/XCwpHpreT+qcj3sic1LqJjI7+qdQd4lE5LKRnlPnJSYXtxkOHcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=cowfdV/1; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="cowfdV/1"
DKIM-Signature: a=rsa-sha256; bh=hV9FzOpgihOnkSeldoBzR9nbpx8CCTOhTT8mRX0CqQI=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755775246; v=1; x=1756207246;
 b=cowfdV/1xWy8OF9JxuuKIIxhf998Dis9BV22MSYmvarRIaWSIFoCbkWdFatf4avZ5a4kMKSs
 QpY+qKBW1frKW4dhV3Sp5daip8J/AljYGssjMSkMvhhxWduGnTKz0fgl9Y2ZOX6zwH/Zi3m9/yn
 gR5un5ORIhAWKYaFip5hvpioJymbxm9JvcbgXLx2KvcL6ht+vXiM5e9FfcA44WgQ5AjWcjqXjl0
 805MoKTGsmeA613rlNM7xIcblmgAhZFQWYPvlJh05NyceF5rPVj+hlCsoJM484HjIVQG8Wqy2+z
 1PnAQo1pc5f9LhH+yIjbHgglodsx/w018f5tG4ZAV3K2g==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 9f9f6c40; Thu, 21 Aug 2025 13:20:46 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Thu, 21 Aug 2025 13:20:36 +0200
Subject: [PATCH v4 2/2] mmc: sdhci-pxav3: add state_uhs pinctrl setting
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-pxav3-uhs-v4-2-bb588314f3c3@dujemihanovic.xyz>
References: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
In-Reply-To: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=Q4npPNa8PUekFYlhJuH6KQeooA2aD9xYG1c6BK+8yj8=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBnLGblDO9+pKPFvn5NrKP1kT9x6l9DVHJ2TJhT0P9Rat
 HG/ZsObjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjIT1NGhgMnrxXYrN5UyxVp
 njhxR8Qd/iWzLjrcjl69wzeSkYf9iAYjw0Sdc+JCmqpGobt+9lv92/vRLl5RRiu00tBq95aWKc6
 abAA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Different bus clocks require different pinctrl states to remain stable.
Add support for selecting between a default and UHS state according to
the bus clock.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v4:
- Fix cosmetic issue
- Update trailers

Changes in v3:
- Move pinctrl stuff out of platdata
- Add helper for pinstate lookup
- Thanks to Adrian for the suggestions

Changes in v2:
- Don't attempt to lookup pinstates if getting pinctrl fails
- Only select pinstates if both of them are valid
- dev_warn() -> dev_dbg()
---
 drivers/mmc/host/sdhci-pxav3.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 1371960e34ebbb955ba2334451ed4734041a7b1b..238f508f2fb0bd1194e42c77420d3748c952039e 100644
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
@@ -440,6 +470,15 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			host->mmc->pm_caps |= pdata->pm_caps;
 	}
 
+	pxa->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(pxa->pinctrl)) {
+		pxa->pins_default = pxav3_lookup_pinstate(dev, pxa->pinctrl, "default");
+		if (pxa->pins_default)
+			pxa->pins_uhs = pxav3_lookup_pinstate(dev, pxa->pinctrl, "state_uhs");
+	} else {
+		dev_dbg(dev, "could not get pinctrl handle: %ld\n", PTR_ERR(pxa->pinctrl));
+	}
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);

-- 
2.50.1

