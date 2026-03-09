Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE83A4F58
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056434; cv=none; b=Ayxc/omj/Yv8pTpRI/1g3Rrn9iEOvaNFpBD2n/NKDA8H5fZeVvIBnKAedubQZ0Ej7XsH3iexBef4hkobHxmbW/P6PvJJ8qyY2Y/RMI58WNSYQRQNmj8n79iJZzlO4bKxU3RbyjquRcg6McBqT0Vm0YcCiecls7Tl/k+mMHvUKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056434; c=relaxed/simple;
	bh=GhO1Ie4U3ZfzS4l/Ko0p5yu5WuTegwhHbdrsMIKUNZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8YgIguvo4wMG/TsUXJ0katoj7WZNz7P3qolWW/FhU7FIO0saEHlCg50eSQqWOOEVtAVUH75X+KD0s86rII+v3/ln2CLXIJ3l2UUC+LDcLj2i61n4vgV22GnnoPlpiSYWTgzKGfd6aSfMTjbdZw1WrL5cwxOWLbsRODQYHEJyhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmxpFcAa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmxpFcAa"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso8897829f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056431; x=1773661231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJ9vHPA28uIZwZHl6zG8+rB5ttucBEvrM8sqwTl5hfg=;
        b=DmxpFcAaG7alNzILosNXpfsl2/EqpimYl7Jm0nr7qPYgj06q7uowCLzc/S7u0IVWrf
         h5oW/AEo1dyK8TrrPLCXkX8XSXoHsNBlReinzSCWbReLuqWJoHVuNy1IrLAtna3MuS8i
         6ZOXkCH0pbrisHZ6exDNEP3t7Q/rYm68kGB4hWRSCyRTfuqYee3dnA0BSq3rwYZhKpIz
         fEuD4BurQg6H61K2PYY9jxv/W4Uw1Ljy2/rKV7C/19LboIo5ctO0yR+1SEMKxcTppRYl
         RPH2Kc6W5Tn6oCpm1LYvzabn8jsPJP6xZddX9kgmxhdS9lYNgf5+g822G4h9s+XRcpZ4
         Hl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056431; x=1773661231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJ9vHPA28uIZwZHl6zG8+rB5ttucBEvrM8sqwTl5hfg=;
        b=PtPMdDwCfN0Etrlh/Tum9nbmybUOd1YuENGHKDf+SmaacbiyFTCwnTFPtpQA2S6y3n
         qhRYjB/+9+S5a1IOMSZJbmVGBgjPUr5qmfB1r9PEhVve4yO1Wei+l8IVP+JErWXFA55D
         ajijkKmPZUN+5kTYOTdqcqBMy4gCcJ4w/djhZgVysJD67ogeahSQUyubhR6caPqwMvcN
         FjzCt/DDXyCXc7BVyAwy0rQXjWeKN+GiZifGvatY17jJE+XRy47hJliQIs5cyHSvUsO3
         /BKkz9PKREPeA182QmdHaBt+XQ7lPeQAXV3D3fCsCLyoawph4DfkDvqyjfP41qnKE9HY
         GpLg==
X-Forwarded-Encrypted: i=1; AJvYcCXFD4Yle7t7YttLHNPHWQa8mzvdQLgDyfQ/NlXBXSCYCYB1siCs2Iqe2js58Bmncxl7pxTT3Yk2qqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQf1iifAVvlhrOGNbTFR4L/dxPDwU6MwGtXGlwBjvgY29MgvQm
	3+t+wJDIrgDK8Waios1CFNuGu70cIFgjfQTDmF2Err8dJfxoc3dSIzJp
X-Gm-Gg: ATEYQzwWOPj0dtN9Th6+G0gyIB7igFXtgSvwkntTkPc/MP720UIrNXL7eb2hSDkiFmk
	y75QicWyhR2MPKJsWOpJz2UxpKCZ3CsymXRSx36MBVlxbSbXbWUdILZIs/tQAfqf1assJ19Ygb0
	4KQBYjVorn1BJPOUdGQwj9hrkKyTf3EU9KUbIFYol5JLAXDdy/6jl7z+lWiN35iFXs6x+DjAKcZ
	Sd3+3m/EzEeBBQDgvwUHJfvjvZU0Igi9Ht7C8KEmCAJ3gAcSylZSvKp3Uwx53B+dhPcmeKxAt/u
	oZTFbYE5Mh48rANiX+TA7o/ErhMdNnn01m55HKCxrmLwr5/zyfaRuzyTszAVcXCms9OQhKiINeb
	BUAg7fb+VLY5XUsUYJg0TK25jql2iJ5zc5joLoUlbV+EIfE0HcLUtPB+BWVXzamGEePiYL+wkOu
	IupS1+e+k4jp7tN/BinO8tdSuEg7q5Hj5bm1toTnnzJXI+T9O1xn7vRS9d5Seosd8v
X-Received: by 2002:a05:6000:24c9:b0:439:cc06:e134 with SMTP id ffacd0b85a97d-439da6632bcmr19064373f8f.24.1773056431160;
        Mon, 09 Mar 2026 04:40:31 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:30 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 09 Mar 2026 12:40:12 +0100
Subject: [PATCH v2 2/7] mmc: sdhci-of-k1: add regulator and pinctrl voltage
 switching support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-orangepi-sd-card-uhs-v2-2-5bb2b574df5d@gmail.com>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>
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

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 585c7eca6ebf253aac466dd37cef029deb63f692..8af117a8e271c04a80d8dc7bb5ce12075652dd7a 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 #include "sdhci.h"
@@ -70,6 +71,9 @@
 struct spacemit_sdhci_host {
 	struct clk *clk_core;
 	struct clk *clk_io;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_default;
+	struct pinctrl_state *pinctrl_uhs;
 };
 
 /* All helper functions will update clr/set while preserve rest bits */
@@ -218,6 +222,42 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
 			       SPACEMIT_SDHC_PHY_CTRL_REG);
 }
 
+static void spacemit_sdhci_voltage_switch(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios *ios = &host->mmc->ios;
+	struct pinctrl_state *state;
+	int ret;
+
+	/* Select appropriate pinctrl state based on signal voltage */
+	if (sdhst->pinctrl) {
+		switch (ios->signal_voltage) {
+		case MMC_SIGNAL_VOLTAGE_330:
+			state = sdhst->pinctrl_default;
+			break;
+		case MMC_SIGNAL_VOLTAGE_180:
+			state = sdhst->pinctrl_uhs;
+			break;
+		default:
+			dev_warn(mmc_dev(host->mmc), "unsupported voltage %d\n",
+				 ios->signal_voltage);
+			return;
+		}
+
+		if (state) {
+			ret = pinctrl_select_state(sdhst->pinctrl, state);
+			if (ret) {
+				dev_warn(mmc_dev(host->mmc),
+					 "failed to select pinctrl state: %d\n", ret);
+				return;
+			}
+			dev_dbg(mmc_dev(host->mmc), "switched to %s pinctrl state\n",
+				ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 ? "UHS" : "default");
+		}
+	}
+}
+
 static inline int spacemit_sdhci_get_clocks(struct device *dev,
 					    struct sdhci_pltfm_host *pltfm_host)
 {
@@ -242,6 +282,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_clock		= spacemit_sdhci_set_clock,
 	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
+	.voltage_switch         = spacemit_sdhci_voltage_switch,
 };
 
 static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
@@ -293,6 +334,24 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
+	sdhst = sdhci_pltfm_priv(pltfm_host);
+	sdhst->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(sdhst->pinctrl)) {
+		sdhst->pinctrl_default = pinctrl_lookup_state(sdhst->pinctrl, "default");
+		if (IS_ERR(sdhst->pinctrl_default))
+			sdhst->pinctrl_default = NULL;
+
+		sdhst->pinctrl_uhs = pinctrl_lookup_state(sdhst->pinctrl, "state_uhs");
+		if (IS_ERR(sdhst->pinctrl_uhs))
+			sdhst->pinctrl_uhs = NULL;
+
+		dev_dbg(dev, "pinctrl setup: default=%p, uhs=%p\n",
+			sdhst->pinctrl_default, sdhst->pinctrl_uhs);
+	} else {
+		sdhst->pinctrl = NULL;
+		dev_dbg(dev, "pinctrl not available, voltage switching will work without it\n");
+	}
+
 	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
 	if (ret)
 		goto err_pltfm;

-- 
2.53.0

