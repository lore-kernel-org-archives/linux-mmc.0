Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CE392C25
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065169; cv=none; b=XktW0Dmce5vbyya+03fouBF8mYFMkRX13otmmo0SK+S6eLNOSMshyKcpN6pgDoCm9PXq4tK5mLF5wt0WEuHZ7WeI8024Vv+RZ1erTCUZ/oz1H9PUmBxPxj+PPXCvaNEnvt8PYQCi1MB4vc6NP6eSoiUxMIcIPlqKRwKN3yd41tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065169; c=relaxed/simple;
	bh=lQe/1C1yUclvn5uXddSpw2OgIhgzl5fVc6scliCgVzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q09teIySzJ25LV27go2Tks4lPXRtEin3DQD6+27ociRH5vLpchbqusD2T3HcxQx4vyS38Gp1t1GYZqyKAezw/T4LMxs4N/4FgW+06FlHLAzJqIsM8E1+3CkHwQ6/fqTJWy4Hc24o6ALEWh3ZIQbLx9pRwIBHtmZhGjjAefeALdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaAFFG85; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaAFFG85"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso42882285e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776065167; x=1776669967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k4mLTIsc5RI8xaNMKymA8VHdibedwqV8+ItxZpomdA=;
        b=kaAFFG857ayf4pHZykk+D2D0Hpx03GQ3dcSt9jRIoKRjdXYMRvHg1DMQqsNry5qTGE
         /uDLLzykpnQAU46l96VTNyE09xKy2fYk7zuB4n1In7jzaJ32Qf4FD4Y2ojnkmTyurX+4
         epe7AujQ798y3idfsALrEV1y0NzfCJt9f/vNglDLFilgbCNWaxGf8jCBz/G7AbC/CikJ
         u+3k59t3pf++IgQb7kQRXX7/ILbyltvOGae6uTYer5oFZAc6rLaTNrIOfXp0KA1NSFi8
         mdbHDomcGrwWKy0v685FEHBa/BKULeCGfQP+Xqt3igtHHmBjkNPAqoe7ZifLEuGHzcaI
         OZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065167; x=1776669967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/k4mLTIsc5RI8xaNMKymA8VHdibedwqV8+ItxZpomdA=;
        b=h53BS4zsWGqzSVsojgGFoL8TH1BijA2s8zCzIv5VgatAho1ZcOzoARbqD7Moq1FyA9
         Ya5G/WVZqCsFi/E8ng4RKiglSt4XNRLXFr0uAJVce3vPy7aa2Xi4ooC8dbu6lTCoCgbT
         5qXZbyCTwDMP5Syzie1j8aXsA2c6bBUA3uWGRhw9OsjNP3koXfhO1cj2NO4pbOHggU/6
         RV2uWQpy/teR7YygoBLXV6XyMKlknnxKJskNaKMsxYMWDkjAqX1WpAA2/byBrjNG3oUK
         j6DZ2RjBOdfIJYZUPfJgWd17wIUYdg7pTopnk5Iz+U5MstGymlE0g2kSKPcajEwzDgs8
         o5zA==
X-Forwarded-Encrypted: i=1; AFNElJ/kxvG8fmtAtrUXGMAs9L0u8u+FhU6xQawqmLDniNiqQ/ji/jPwThpy33mQdPTj5C47VKOWqZN0VIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KEtNHTCWGJJZEQxeDJzblHvjjOW9UWUD9T5pwXABEhF+eKDI
	TEOnBe0A29WsDa22ZxoaXkPb6J2HIH58rYLVSwyeoX9DNtd6cxVplylB
X-Gm-Gg: AeBDiesBFCh+8a9alkGJb7Mqc6wxMe7xhdGPLtVSLdUuF8z3IDWkFkzz6KQDuX1G0WX
	p4i9Ss/h2EHz/dFyAC+I9XlpIw/VspGxFbyMZhC0zoepthGBtU3k97lYwN7sFZQ76uN3MPIXkHX
	vUoZTOjLgqxVWpJ3qfukIhObZrEIb/KFkzYiRfUbbILe/Tf8XmN921lCnYKk52EM5+f707TO00r
	wtZCLW4b/G0nqdBx5VWVojxAkAuTTVNjsBXiEtOACoZnyoXq7PjdkLlnWAlXb0MQaEz00KX1I5u
	ECJYWKfoRj+ZYYuFwmDEGyhEZ/zVixPX4LjArFwu7jXdE8MhbC1bXKh0Ndnhs47HSNFTW5Vv0AU
	tx2grRREAseseu/MRN/EhxIvHFhi13sUb9+kcHvAS1p8JpP7s3wYwcxkotIJb6E78Gjqz2jCZRR
	kIWdsFFtfmJeuy1x07bcaCRgjVEiSjTrJVgVol7F/SmoAJ187/mMlOvFgN8b8vxTO6B7Q59ffQz
	Gk=
X-Received: by 2002:a05:600c:8717:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-488d6816f5amr164955675e9.3.1776065166673;
        Mon, 13 Apr 2026 00:26:06 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488df2a1237sm322180555e9.6.2026.04.13.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:26:06 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Vincent Legoll <legoll@online.fr>
Subject: [PATCH v7 3/9] mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
Date: Mon, 13 Apr 2026 09:24:45 +0200
Message-ID: <20260413-orangepi-sd-card-uhs-v7-3-16650f49c022@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit

Add voltage switching infrastructure for UHS-I modes by integrating both
regulator framework (for supply voltage control) and pinctrl state
switching (for pin drive strength optimization).

- Add regulator supply parsing and voltage switching callback
- Add optional pinctrl state switching between "default" (3.3V) and
  "state_uhs" (1.8V) configurations
- Enable coordinated voltage and pin configuration changes for UHS modes

This provides complete voltage switching support while maintaining
backward compatibility when pinctrl states are not defined.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
Tested-by: Vincent Legoll <legoll@online.fr>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0dd06fc19b85..d9144537032a 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/reset.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 #include "sdhci.h"
@@ -71,6 +72,9 @@
 struct spacemit_sdhci_host {
 	struct clk *clk_core;
 	struct clk *clk_io;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_default;
+	struct pinctrl_state *pinctrl_uhs;
 };
 
 /* All helper functions will update clr/set while preserve rest bits */
@@ -219,6 +223,46 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
 			       SPACEMIT_SDHC_PHY_CTRL_REG);
 }
 
+static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+						      struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+	struct pinctrl_state *state;
+	int ret;
+
+	ret = sdhci_start_signal_voltage_switch(mmc, ios);
+	if (ret)
+		return ret;
+
+	if (!sdhst->pinctrl)
+		return 0;
+
+	/* Select appropriate pinctrl state based on signal voltage */
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		state = sdhst->pinctrl_default;
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		state = sdhst->pinctrl_uhs;
+		break;
+	default:
+		dev_warn(mmc_dev(mmc), "unsupported voltage %d\n", ios->signal_voltage);
+		return 0;
+	}
+
+	ret = pinctrl_select_state(sdhst->pinctrl, state);
+	if (ret) {
+		dev_warn(mmc_dev(mmc), "failed to select pinctrl state: %d\n", ret);
+		return 0;
+	}
+	dev_dbg(mmc_dev(mmc), "switched to %s pinctrl state\n",
+		ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 ? "UHS" : "default");
+
+	return 0;
+}
+
 static inline int spacemit_sdhci_get_clocks(struct device *dev,
 					    struct sdhci_pltfm_host *pltfm_host)
 {
@@ -252,6 +296,30 @@ static inline int spacemit_sdhci_get_resets(struct device *dev)
 	return 0;
 }
 
+static inline void spacemit_sdhci_get_pins(struct device *dev,
+					   struct sdhci_pltfm_host *pltfm_host)
+{
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+
+	sdhst->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(sdhst->pinctrl)) {
+		sdhst->pinctrl = NULL;
+		dev_dbg(dev, "pinctrl not available, voltage switching will work without it\n");
+		return;
+	}
+
+	sdhst->pinctrl_default = pinctrl_lookup_state(sdhst->pinctrl, "default");
+	if (IS_ERR(sdhst->pinctrl_default))
+		sdhst->pinctrl_default = NULL;
+
+	sdhst->pinctrl_uhs = pinctrl_lookup_state(sdhst->pinctrl, "uhs");
+	if (IS_ERR(sdhst->pinctrl_uhs))
+		sdhst->pinctrl_uhs = NULL;
+
+	dev_dbg(dev, "pinctrl setup: default=%p, uhs=%p\n",
+		sdhst->pinctrl_default, sdhst->pinctrl_uhs);
+}
+
 static const struct sdhci_ops spacemit_sdhci_ops = {
 	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
 	.reset			= spacemit_sdhci_reset,
@@ -324,6 +392,10 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
+	spacemit_sdhci_get_pins(dev, pltfm_host);
+
+	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;
+
 	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
 	if (ret)
 		goto err_pltfm;

-- 
2.53.0

