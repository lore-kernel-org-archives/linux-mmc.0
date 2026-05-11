Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F273CE4A7
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489676; cv=none; b=ZNs2EBXWO9dbeWWW9kWMGk+NZLp9yXeYSlOKIga25loUGQI78oMu/VrjJQ8mv8tn909dH0vAfRE/aW6mcbf/6p1K7nma4AQgn9VzELOc7eNewnhqnIs4jvpCsz1J0XWM5YIXt3WF3G8lNTRI/+ElbA+DFgcM8G7oOnRTL3EXE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489676; c=relaxed/simple;
	bh=9RGpIlc1D936kgYlYrsQ9ImDNx3EFBBX3C/qUpnsSvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puQdMncvr/unu245eDJvgNRJtziiaNL7aw8whOmEMk9Hm1Jd0FCl3GdLkHINnfr+7R57ZSx729zUWGnre2Y1sOo+0nqhh2U8c7BjqngP7MksSRwei3n2ch0wb4pIYCgrCeM1TbmP9H39GdR2QhpM5SJSdyufQkaS7eokPQoOtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6pDWb/0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6pDWb/0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so3204721f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489672; x=1779094472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQW1TmR9evC/67fcZb5WXGa69DfOLAbqQ0G8sRDSbLM=;
        b=P6pDWb/0o3qGAmC529N9Lurkt7JG5HaYxM3cX7oNnulTlw/nqVRb/qc1E8QgfCW/hi
         3O2clTxF9kd6yQw5UZcO6d3R8QYCjmb4D9Z3vEwEFcptBRDZpBDsIjX4fd7NIThQWPZ9
         xVb5mZvnKKM/oAATz5pN9RH1sjhIHiLv3JUuzqtA+Z/wc8jw6cYlhIaRIP2idqbPNHkg
         650Y2gXwoUA+EUGf32TulX2LtU1XQaJ2VWVJbhsODN+Rs5Dn9NG0OwSdL6E1JtlA8Xvl
         qLNnsmg/YG3LlvjWOYYopduY7C9KLT61iKU8Fg7tMhrQH+JKSasRe1cUracPvsTA37ox
         N01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489672; x=1779094472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQW1TmR9evC/67fcZb5WXGa69DfOLAbqQ0G8sRDSbLM=;
        b=Y3WvrjMJ8aLzgLu0DGW1M0QhLAEjONtDEfn0PUvLsO9rMeT0CmW2Hwm8Yv1zwCcEHm
         Ruy3AViG9afvjwnAD8LuEpzKheADv0vGGy3zshym+eQHfiuZC0RAMM76JawjVzk43A0s
         4w9v9idrhS3LfW5dRFHrby6M2/G5TQW4XdW5nOWMFkhWWqaJU+G6nL7nC5v5JzpVbnwh
         b01yo6yUrjx6QnzgA/ILX84Oe8PtVbntG9B+IOQz7F5+zLfoOdxhrr4ya4unBo1V9YZG
         pGSMMgrj6GVVtcTknOB+k30bjGNuix5vbgVc4kbCN7px3rppQoDlRbZ6hDWE8PLMWVwt
         F39A==
X-Forwarded-Encrypted: i=1; AFNElJ+9qG5s04kVfQIStqlTQV6eb6hax4ydOiYvVfL9aLKukgPea4CYNWmEHSOkSv13RTDjPfe5c5r0rY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/CxYLX/zrI94hMM3qA/Nws0QH1TBHRrf0N8UrtXpJLBV8ma0
	MBRrPfSgO0PrbrZEDYCVH4Wee5O8i8Db+572NSHphcVHUwpTQTX2DPzo
X-Gm-Gg: Acq92OEC7UBYjAYrNOTLl5e0U9SarXFYaI9f1y1PnLXAUcGS0y9fTS6DvkVwIhh1gHF
	yLR6Tg1zGxBkOCCqx3d7/EHp0jOMwygvCD3rQp/3Ew7ghg6AV2rjgzQcKN+MuFTM7TS0cNEbAC/
	MoGD8sZXWts5AtTlsHoHNagi4y4Bk87IXYa6qpAx03goAA7+JSpb7hudfPR/tCwW9ftTlIg52l6
	pyGH6vPgZehiGrqSL57Lpa8dyTT6cIbJsDgK11f3oMWBaC1rw1o3mZt5tsHEHBnK5KCAHSphfoc
	1J77UgMf3HPKesXWC6iMJlZjbkeLi4AMy/ozbr2NT+493L5PspvZEyOEQWgtGMRpMLmiBS85qZp
	QWRViRvXiq3lOUjCZDinoY8UEgzh6EDoAaY7jb9Y+4b0n+LIGA/4iwZfJjJ/eUde9Y28sl6E/KE
	rBXxJlvSkjvPSapZSDMcByodvSvwBDg2DWmAmxduppqw6b48uCKsYp3xBFEHFEkGpH7A==
X-Received: by 2002:a05:6000:609:b0:452:bc74:b129 with SMTP id ffacd0b85a97d-452e9ca06b1mr28253152f8f.16.1778489672083;
        Mon, 11 May 2026 01:54:32 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.237.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm24944189f8f.30.2026.05.11.01.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:31 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 11 May 2026 10:53:58 +0200
Subject: [PATCH v9 3/8] mmc: sdhci-of-k1: add regulator and pinctrl voltage
 switching support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-orangepi-sd-card-uhs-v9-3-ae48c0b2b2cf@gmail.com>
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
In-Reply-To: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
X-Mailer: b4 0.14.3

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
2.54.0

