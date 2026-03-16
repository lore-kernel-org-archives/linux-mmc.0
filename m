Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D864204E
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669873; cv=none; b=tNO7WQkxlN8K/u+FMu1EKQjv1+IwC+Jv506WAMn6AL2umg80Q97pD0QLWo8pu/XOjrQDw/cDFPN/bPhZTrYfQpx3CxxaQSYc4eCIyX3/qgLE3OooQzwl4MqWqf/BxKTqW1NWnKyvASEbFpSC6U11amxD9zm1VJSU8TYmFKQwkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669873; c=relaxed/simple;
	bh=epbnSIRFEcgFtseIgir8HKOEck/DcrGNKZLBIi+3AcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+6g8b9AtrX0M3K0FsSXHzKVoJRRcKzFFcBTNnw8LsJp4ktP63pZCMFf+dC/bcAYWscmcE7ZiaKG6VF2T/9IcE9Nx09F/Xg7mC8vTfDAvz16c2uWjJSRqi7HMyLlmWYWKCZA1BvXvXeRr8zqei0n7SbnJYsZqsXqWQSeKlsPQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE3Eo1RC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE3Eo1RC"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439bcec8613so3505610f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669868; x=1774274668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IatXzbXfYasV7clQDZ74AZFa+ggBYqSvKjib0f90qgA=;
        b=eE3Eo1RCYJK1C+/a3vbyx/q9uB8XQjN58P/y7fvIpo3tNUehZKpTii/jRVqKsvSiTE
         YMmJlU3g/aSHPaHMLOGerCpvRbJ7ynJAL4xGNpOrp4bpXNkWvjIUo0XVOHFCk51K5soO
         0lFJ9ba5lU2JdU4x00y8q4mj2CdnfqzELNTkxNnPEoiNinUQI2gipwgDz2HhPLZLaQYm
         DyVzJfynPS48+lpH8GFt6JgqalHOOFcR/nN5ZocvS5/zXC8JogSXbG+TKTfy5WEFMLrp
         VY80GTA3m5Sf1a4L+v39c/lqileu08vz0QAxJ29Pv1cggqfA5TmqxdZJITrupbLPQljS
         nEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669868; x=1774274668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IatXzbXfYasV7clQDZ74AZFa+ggBYqSvKjib0f90qgA=;
        b=RfoEgRWXFAatyNZnonyCwRX2k2zRRB1jk5q08LOM/XzfO0IcuoKcNir6en46X71vU+
         j3ZI5k6s3lB2c5EmsbC0dFlbyox4/3IrAXCjef08e03ejO/ZIW8jq+77kPn/FKrqGrnY
         hNGg2U4e4qYjfOu0+w6ppazkO14lDnWoQZc2CED2s6p3VkcgRWMFBYMvQPNWPJW/lAWa
         dhxvebXZYFezuqae5A9hM3DO9TPOdfQ5kSB+/GN7PJlV1uC/MiVsK9XTa5q7b+Wg51Wo
         JQrICFOVjNdCww9pI1JWApyUkyDayHRs/g39TDJes1OEeRx1qJWF0IvV+3wiuE5G1FoM
         ZpiA==
X-Forwarded-Encrypted: i=1; AJvYcCWtsaMyHbYvraKAhOwPjO/nfteKwTQYBi7Y9S51Ela6J+AUIxicwveN2KmlCf9u2n6e/bble7ayzTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJfeRieUAALaw98/xRCOA0h2k6Cocu9s5rqQHGqh/yc7REme4
	CoYrapCitL99zLeAFIQDOgGwC/+B7Uy8SUqb144oR4DTjXO7fxF/oWAm
X-Gm-Gg: ATEYQzzIn72c2gnfaFlily3j4Tf12WLx28bf46IJB1WCu7d7Gdlu8KyY8aw/NCzsUSS
	cRuByVnc9csst6rOp/Y9OG3RH5exY8G9GjVqvhyqLuZUdsOX8hvAF0OlFaikYz3+w7q+dcE+8Rf
	defPYoap1otSTMc2pri+NXEgANzWsCAOaTDr6V3RZ6wnDaqUy0ulFxT4z5SJgxxxG8mwPhWAoIx
	EdTALXOo9ZJbyklOkBBv64kaechXVJY/mxUJUuMJsn52QlrIkog6xccIFUabkFCxlkcfpVg9CAd
	LojZkegRPwAqVnHttzhfqL3+hIqDPhHfwTUrmftoh0wuqPUTPsrzJjeTTu41pCPgb0dQoo1O3de
	4t0fNu+ES55A6JKmSScmkyin+lCvjNsoo81wgYTrYTqmvMoXOKQ1OJj/F7wmmHEkjmyXUNZ+YYt
	GPDsmsocOARTVRp3d9PCickNP2vD/EopuglH0BW80mC2PDIPkTxjTxR7AX1/vxl7iY7br8/PQml
	gw=
X-Received: by 2002:a05:6000:4313:b0:43b:3e40:2223 with SMTP id ffacd0b85a97d-43b3e4024dcmr9315126f8f.19.1773669868020;
        Mon, 16 Mar 2026 07:04:28 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:26 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 15:03:30 +0100
Subject: [PATCH v3 2/7] mmc: sdhci-of-k1: add regulator and pinctrl voltage
 switching support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-orangepi-sd-card-uhs-v3-2-aefd3b7832df@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>
X-Mailer: b4 0.14.2

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
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770..01afdadcf70796704b272ee5a31543afd5e01188 100644
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
@@ -219,6 +223,33 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
 			       SPACEMIT_SDHC_PHY_CTRL_REG);
 }
 
+static void spacemit_sdhci_voltage_switch(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios *ios = &host->mmc->ios;
+	int ret;
+
+	if (!sdhst->pinctrl)
+		return;
+
+	if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
+		dev_warn(mmc_dev(host->mmc), "unsupported voltage %d\n",
+			 ios->signal_voltage);
+		return;
+	}
+
+	if (sdhst->pinctrl_uhs) {
+		ret = pinctrl_select_state(sdhst->pinctrl, sdhst->pinctrl_uhs);
+		if (ret) {
+			dev_warn(mmc_dev(host->mmc),
+				 "failed to select UHS pinctrl state: %d\n", ret);
+			return;
+		}
+		dev_dbg(mmc_dev(host->mmc), "switched to UHS pinctrl state\n");
+	}
+}
+
 static inline int spacemit_sdhci_get_clocks(struct device *dev,
 					    struct sdhci_pltfm_host *pltfm_host)
 {
@@ -252,12 +283,37 @@ static inline int spacemit_sdhci_get_resets(struct device *dev)
 	return 0;
 }
 
+static inline void spacemit_sdhci_get_pins(struct device *dev,
+					    struct sdhci_pltfm_host *pltfm_host)
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
+	sdhst->pinctrl_uhs = pinctrl_lookup_state(sdhst->pinctrl, "state_uhs");
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
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_clock		= spacemit_sdhci_set_clock,
 	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
+	.voltage_switch         = spacemit_sdhci_voltage_switch,
 };
 
 static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
@@ -324,6 +380,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
+	spacemit_sdhci_get_pins(dev, pltfm_host);
+
 	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
 	if (ret)
 		goto err_pltfm;

-- 
2.53.0

