Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6C3A3E88
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067366; cv=none; b=Z7AOl/3NhfK2ytjF9R5LmuLoP0jLp4Gje7FjtXepCWt18IY4XxJAusAybaIueRBtT6yOxxlzkNoWuxAp/2VBi7ovDyqhRj8Bye5pRKs8mM9Fn33kI8qUJec1XuQPlrJECxdNgkDMuhA2KyR+ZoIAK84DbmEQ8PsimPqyVOGEKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067366; c=relaxed/simple;
	bh=lQe/1C1yUclvn5uXddSpw2OgIhgzl5fVc6scliCgVzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WK6RVqECI78jv04q2uxUNT8s2xAjvSYGOQ9XlFl/3dgdCPuKw0GPqCkjWpnLG6ZIclRl8t1KBQE4CqbexRhnNUkBRWNc4LtrQrAW7msCjThMriCFIQxjrdvaFClniezpKHW62VEzpfN4ffP38zgOqjmz7dE8rpjVsaxDnUrniZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDuCQMsQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDuCQMsQ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c11eba219so489503966b.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067362; x=1776672162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/k4mLTIsc5RI8xaNMKymA8VHdibedwqV8+ItxZpomdA=;
        b=gDuCQMsQmnJj8CzWbO7g55RRtzve5AdPf+OW5t0qy8lKtIH9RxdX7H6GTkvB2XeeKH
         RzS6s1mYS88TYFhbJ3LUy1JQ1mwZkDTewFQkojbm66YPFu/E8VZgbcTckbFnI/5dAZ92
         OrV7Jy8ucTZ1KdmZ5oOF0atftuwNzk8mgla8ESaCbZMmoPZJiC8dUM+twFrUEpJTzyBO
         QJN+wLP+38LhzYDqjYuakd8Q7MlMCK1UPz8qA36f7o4ZYeS6/4zM+dpMiWWCDTNtHuhk
         aK2yM75BIlmaYkdLnEL58UfpTmYj2+k/sHvFI157COAfkAKNCgJhvJZ2gJuaxeRF45iQ
         9XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067362; x=1776672162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/k4mLTIsc5RI8xaNMKymA8VHdibedwqV8+ItxZpomdA=;
        b=Ks11DNBqZFTSReOIq5YcfpHxK9ODB+bUEdXxhsj7m9dE/GY/xYo78jBhIsG2LZFR5K
         3h22FBuu9fbLiqsKZn93RH29s2YbmQz9mEa3scHHc1yLIzuxiemlwBsAVwCPvCjw5I3x
         C+293HO1gHv2yqt2CMi3HhpuYrMY7VJdD7knUoX02RUk4UgQpr0DwTUI8goXwg39yauW
         fTN4DKPff0+Og+gZ7tveoHkIaHZW1Gv2uKTzOcvRjt+W+B7+qGtQJUzUURRfrnPcQkKS
         +HY+q4P4HptoyKWJOBP+dhQaj0N8BQmWZAyMVsfNIt72lwOxVY5WjOMPIQruGp8cDpKw
         EVAg==
X-Forwarded-Encrypted: i=1; AFNElJ+izYz5dfbK+d9GaKncaQK05n14NkXyuL6jUGYJULEY8/doS69OLMHAvIdFNUyKfmaacXngBshRv90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEw0bl8uJ/UJI6JbiyJHck6G2hZH1IOPb4z6WDXt9PcgifmlU
	uC7CchDajllVWgR5VfLD+KEuFbBFwNl6HwGtDel56YR/uiWckwNBZs6j
X-Gm-Gg: AeBDiesDI7OESWOZHZXIwg4LT2ZPIvsIx18FINV7XKY3LpRmUKuDOVQSqcpskh/Xoom
	nWrWXTsQjppFkMTorbW29X5boagne2W5Wq8cMBTYzRvLpjamR4PQ2qcqTunYBsrTW2itWdGBxbp
	zjMs20uV3qVuaQlOtCMoto9i2wY1ryQEwqB5Ajx0xbEL2g5eciA3PRXVUUKPwEpaKN1n/PMOagc
	FouJ8emv/3OFvgCmPk0yk8K8a/qx+xFm0D4eMupY55EQBjxJLWedjWUu3BAHME9BXwUWTtzThhO
	y8KNtHoiUyJvbKOAVV1xu+52B2rXmdKlGruoJi9jBUQsFQd4C4zRsTpm4ki493Hq7vXuHiQhNeq
	Yylf9DJqStm5YPELjXbL27V3cPybzyLYl7LQ4sL7cCcSy8wlnYrMc1a7U0aDj/OLjV82SWLEuK+
	L6R+m5Yvy8Eh0XkSpV6Do7GgFGERAc4q6Tzvf7rdwvZal12rmdVVaaEXgM1Z19WH/l
X-Received: by 2002:a17:907:6b8e:b0:b9c:c40d:bd2d with SMTP id a640c23a62f3a-b9d7277c7ddmr642261866b.10.1776067359772;
        Mon, 13 Apr 2026 01:02:39 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:39 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:12 +0200
Subject: [PATCH v8 3/9] mmc: sdhci-of-k1: add regulator and pinctrl voltage
 switching support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-3-c21c40ec16d0@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
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
2.53.0

