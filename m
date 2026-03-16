Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87B39B95F
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669868; cv=none; b=CGLf+k4fpbljETv5PZDE/EZL1g5QxIoRowbvGoLT/g3IZdtYIUC15z2pv9xTfND46rSQ+ucF5TmFgisG4xi+vuKxJ6jxcvOMkmSLGhJ8NEaJCS+WOYK3E2up/cW/sptbaMQpeGPr60n9qbCbDPlFREO/5pp2Ej5Synxu9aBlca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669868; c=relaxed/simple;
	bh=vmF2pgWK2VUkaN/torpDV5fO5DqEsvTqOvhELAztUNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8gdr3ul7UjKokaf4huKJckNeXPnGf5qhrSQyvFdyyWOH5Aro1+yAp6UnDUC91bi7h/sVRn+Q6BigJRO2wQzfSdu4pRJa4G/iLYSd7fvu2MwbMm5niIJDeHG96VAXRwatx1UlpPMS+J51bdhcaAMmwnZ7tFL7/kUcD30ozHxZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKIgGgLB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKIgGgLB"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439bcec8613so3505557f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669865; x=1774274665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O74WQNc1aV3W+cT5lrJjmSbPvv2lawW0j0OjNB+99fg=;
        b=lKIgGgLB1PMNFm0tt7D4siVQ+lCI5xoPwrzyfbFfhFRjfeqqf2wdBI1LNu6g7riP63
         lssojq286iErkTocLbjWSieYoKjKGgECUnW5M14q70yvJrX4LHcUHelVbHfae/cMIO+D
         G+3hu9gFNVVPzC29E5bN/HfMSIi3/BkaVPIeOnryA1PfMZsgoUZV+9WsoSETRYcXQXRe
         aDQs/5D6JHmZPreEfGMg6ZgrfDuXrRSGuuFcOI3UyvC9ZxeXsbKXZqcYdldK8TwJD6Oi
         67V7YJv9Uk9Cg617m/XSFJu1l3RKSKZ2eufjyEjmjiqpFpX2d2AZIM1Y1GLkPICsjwWN
         8HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669865; x=1774274665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O74WQNc1aV3W+cT5lrJjmSbPvv2lawW0j0OjNB+99fg=;
        b=hPfhpn2VMi/Fz4NA5//H213JoTkz9XCRmmqBm3nW0h0V2c6C2MotVKGo922dy1ff64
         rnvSXGRjkozRnf8mUyVwVEslMTXjeSjY23SiiW/A60FFY1MBoZ7tF4KpneQ6FT43UTjh
         ERchYEi9AKUhkD/PRE6GwJOqG2daIY90xdEZIGLnAdnm7WHlhUOIWQtdGtZWaj9GS26p
         aMG7KNeZvOKgwIDbM0CZggHaI9tHDIjVrdk7JBrMTcH4/tbVIyMZxoRt8lDqQqWHWbrL
         SjYEQuul8xJpjSlO+d7chXflNnU9qMOFVgrbasa8mgQXUAzocQidAuZCRq9R4EVK3FK3
         KHIg==
X-Forwarded-Encrypted: i=1; AJvYcCWGXjXw7ckeP6JS0k8UNDHmqpiqPPPSeJnHx4qG3FkvPCahiQzhwr0MFdIL/8zPLZdBDP7B9SbyUMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kOBUFDPVwoKNxw03nyhHsvrzrZxgFhfyL1BlAjPRgqz+D2f0
	W/PSmlDOCQaAY/NROEdPyS7mDFgtudCso8dsvQe/QrHSC87wqbV3Zvj1
X-Gm-Gg: ATEYQzz76WT1stc7BhgrNQzD56mTopjtb2lCN35AIanst50NYh2KyGnMn2ELlHo/CCR
	qEdcBuKlagLyU4Jj9iDQomjqPlSbGwugaAYd5/9wur5xa7ZRxaapH5hPa+lexopleAVOx4NU5Zw
	4DRNaFQgFyNKbvgqwU0U8Jpuvyk30p3bXSRbNk+ei1iXiPNWv9yYEEJUxqlJQNiW6NajiCCY7Dq
	jnT30rf8sZ+dvanS6JEYsqm8RsTvzBdcIT+/8l8Fz1l6oNrPnR+ZDcnI9+LIS/Z1yoTUwXWM+Oy
	shJhq/O8jZxJCQC7hxBb0LuxDYFH/3hAZiysKKFJQ39zEgQMYjVNWXBvkLAhx62xTrE57HQLuJK
	zAQywJM82fEcY11EKdnJJ1nHGIjcMOzcSZiKFjCrMqGeKFVIWaR7NZaHYDSjX7mvUJ9KGSOCCOE
	LmlAEx/CJOMI0lInCVj85Y1aWcSOkt64c69iM/TiO4qhbQ7XUMhPsYFTYWHYgp4J0g
X-Received: by 2002:a05:600c:698e:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-485566ca5cdmr217587185e9.6.1773669865177;
        Mon, 16 Mar 2026 07:04:25 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:24 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 15:03:29 +0100
Subject: [PATCH v3 1/7] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-orangepi-sd-card-uhs-v3-1-aefd3b7832df@gmail.com>
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

Ensure SD card pins receive clock signals by enabling pad clock
generation and overriding automatic clock gating. Required for all SD
operation modes.

The SDHC_GEN_PAD_CLK_ON setting in LEGACY_CTRL_REG is safe for both SD
and eMMC operation as both protocols use the same physical MMC interface
pins and require proper clock signal generation at the hardware level
for signal integrity and timing.

Additional SD-specific clock overrides (SDHC_OVRRD_CLK_OEN and
SDHC_FORCE_CLK_ON) are conditionally applied only for SD-only
controllers to handle removable card scenarios.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 455656f9842df90c7a94a290aeec22157b378fc1..0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -21,6 +21,13 @@
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
+#define SPACEMIT_SDHC_OP_EXT_REG	0x108
+#define  SDHC_OVRRD_CLK_OEN		BIT(11)
+#define  SDHC_FORCE_CLK_ON		BIT(12)
+
+#define SPACEMIT_SDHC_LEGACY_CTRL_REG	0x10C
+#define  SDHC_GEN_PAD_CLK_ON		BIT(6)
+
 #define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
 #define  SDHC_MISC_INT_EN		BIT(1)
 #define  SDHC_MISC_INT			BIT(2)
@@ -101,6 +108,12 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
 		spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT_SDHC_MMC_CTRL_REG);
+
+	spacemit_sdhci_setbits(host, SDHC_GEN_PAD_CLK_ON, SPACEMIT_SDHC_LEGACY_CTRL_REG);
+
+	if (host->mmc->caps2 & MMC_CAP2_NO_MMC)
+		spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
+				       SPACEMIT_SDHC_OP_EXT_REG);
 }
 
 static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)

-- 
2.53.0

