Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5741162C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464438; cv=none; b=N10mdluY0oLDeZdz3q0i8vNtIE/Cdd7INSZZ21L+dGxtp0vxFvpmcvOG0kJqRJkUgnARS0oyUqgR6ZoigQq7A2UYlonHouTQaMkFI4DkocYhW/TXgh9gyhV/qQZvwpUZ+XkNnKi7PaDzvT1bTzkRmUoTpPbn1nKDiVfeLmXvQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464438; c=relaxed/simple;
	bh=l7yFNiOmqsvt7j2PZxlgkxZHr4AJ1C5sRtgpqni7WX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBZ2h91p+9lVrP/wINiP6POOAJTY575M5aiUG8Jl8oX41MVc9EL2x67/Tohrkb1zQSjPni3Toa9YuCOV+5FkfRD0fR8vE5GOwLF96dNWkzSQ7m7bMDh6hfv4MM+KXiVk4ohHZzB/8tt3MXom+WomfO9yEPuNNtl7M3h0a9SeG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6rACf5v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6rACf5v"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48375f1defeso34473365e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464435; x=1773069235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBh/BEMhIYd7yMIKn9wpAoeG/vOOsjbo+uR3/+VkGQw=;
        b=G6rACf5v3vPEKsMklKuY8ycf0uE252osOOOy9QhPhabf3Pni/0KKP6ZIfHMBaQgqNK
         uOXRpApVWdAqkFHPo3rf0L6lbENq8swBz2XRwuzTNeDIN9QMS5SQqWANq/TTp9pxzzBU
         zgWRrvtF3CDXsALzQvB5soJX+iIlMHxciqYiPZyvxj8Y73980WFsxlQ32WOMBG45VKsk
         QUBRfslhi24c4KxDk9IErxdTcuCmpSQp14kcmFkJF6EiAV+BAs17aTYgaHYUOLNhnmTt
         trcHvh3vPZPD5TenbTOwpsskUReD9R6zzfKwEzyJsMYbSHXMYDICV+yOfmjvzVo5gwJM
         Q5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464435; x=1773069235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eBh/BEMhIYd7yMIKn9wpAoeG/vOOsjbo+uR3/+VkGQw=;
        b=UOdih9klFpeUtOPKCuonBvQC25saGKfohwQPYakPnJJ/Qa0SntQtvnQoz9PkMDgoir
         533/PnT16d4AkldaZTi2schr8OKjVrMJRu82e2vZs2rDF94JPvajRT/EyU6wmyLF54oQ
         17hUvqrN5bmMKR3i7nUAG2FXfp6HwKxOqRMHmeyaK0earztdx5bkmV6NGGuK4OQgNK1I
         /YVps09uS10g+A022MPVgdVioXNHeySnsaeTxB6TRQo/uWG9MB/AnGZr0A4h+8/dbPpL
         5HTzk7ehKq2umvCFOMAyxC9eMBcQ9PlpiA+HuDWN6CSJr43gDYrQW/Ll1kiAuAAwVp/T
         Tf4w==
X-Forwarded-Encrypted: i=1; AJvYcCXpqcluRO3S+CDLSiLs30AheEP5lhkMjM+kgxOCoi0h2i+Xelgk+s+cXPX8ge8Rs+twowB3drWIAOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyio2V6qzAwPNgH/kYYgCz7c9umCJhD92eVV/UjSSb7oE5O7YPt
	4NUd2q+E1veFS5EIh4vE3p36pWYEFdlqmMocruDBDEtAH8fUGdYQbsUq
X-Gm-Gg: ATEYQzykhfASOfP6nTUKID+q1VUBnJkC54EuopGwnOxvXpG8pCE80x4n3daFZ/P46bZ
	YJOGgtCh2qcyESC/DpZ9X+oXYgoqRgXKfhaYCX4zqsWpdJ59+wO1KYnsogGtEpLquwubyZrLAmd
	+s2kJuqiXuyDUd5ePD7P40Jb3He4HZ8KXMGFpBNVwLpcgpIHn/mF3JNcGD4pRqjVIGLyc/z7E8s
	xLoeHbJjepLm3s56tJMdrtI+k3p5WZuSj2pDbp9nZe+cvPrMXtzEbH2COCT4zc/m8d+/dIyeZjd
	0Tewgr9V8wjnrsnxAOzBESllfJS+dyubTQUXkZy6pEGJOeAbK3GSCsHxeYnUVAWGfcxn9W6F+vs
	Itt4vuFd6sRGHrtBVbndD726Awn2+OEqaIJu3+w+wjM5wBV8XpfIPXIZzCNmDGM928HPXg+eG5C
	g2KaLgxa6oDRi6RDAHPF5HI1s3WZrjF12f98Oa5EtnDgHr73Fgt945r8CbGEsCQmU6Kg==
X-Received: by 2002:a05:600c:3b18:b0:483:b01c:9508 with SMTP id 5b1f17b1804b1-483c9bb7c0bmr236115405e9.2.1772464435275;
        Mon, 02 Mar 2026 07:13:55 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:13:54 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:25 +0100
Subject: [PATCH 04/10] mmc: sdhci-of-k1: add pinctrl state switching for
 voltage changes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-4-89c219973c0c@gmail.com>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add support for switching pinctrl states during voltage transitions to
ensure proper pin drive strength and configuration for different I/O
voltage domains (3.3V vs 1.8V).

Pinctrl states are optional and the driver degrades gracefully if they
are not defined in the device tree. This allows boards to enable proper
pin drive strength optimization for UHS-I modes without breaking
existing functionality.

The pinctrl setup uses:
- "default" state for 3.3V operation (higher drive strength)
- "state_uhs" state for 1.8V operation (lower drive strength)

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 59 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index c260cb89704ae7a25bec0f07831d495553405bbd..2a982bca2a50ca96f43af7b4de5bc4fb4b5b195b 100644
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
@@ -219,7 +223,42 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
 static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 						      struct mmc_ios *ios)
 {
-	return sdhci_start_signal_voltage_switch(mmc, ios);
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
+			dev_warn(mmc_dev(mmc), "unsupported voltage %d\n", ios->signal_voltage);
+			return 0;
+		}
+
+		if (state) {
+			ret = pinctrl_select_state(sdhst->pinctrl, state);
+			if (ret) {
+				dev_warn(mmc_dev(mmc), "failed to select pinctrl state: %d\n", ret);
+				return 0;
+			}
+			dev_dbg(mmc_dev(mmc), "switched to %s pinctrl state\n",
+				ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 ? "UHS" : "default");
+		}
+	}
+
+	return 0;
 }
 
 static inline int spacemit_sdhci_get_clocks(struct device *dev,
@@ -301,6 +340,24 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(dev, "Failed to get regulators: %d\n", ret);
 
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
 	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;
 
 	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);

-- 
2.53.0

