Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958613A545D
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550367; cv=none; b=kmDgZ84hV8WZEPB9q+YUEpZbCwp3v/h1qK1EBZjJVhcB3KeQOgSKtsWl9PVSs+xyagwbkzbkTfRneWoXV3q4HlSgXyYqN91bvdkRQWGeTJQGX8uXmMgli/LYZos8fAud3owKP6gi5g8cNyY+nFlCoXX7P1xybIEs4vtAHyS7S9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550367; c=relaxed/simple;
	bh=pYJvYi3wGayZHU9DE3xysB2ygNEcNECfzw4JJTA9oS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvIeMHX2jAQ63EB9hpni+eg6YJSTpJvVKQh2emnnxtyvh0+zozL8/RgHF0Z/CGfKHn2N/bjLdnVcxgK9Nd63daAfPZkCOU7ikUgmju41F5vcs90pUCOfCChRb+QR6qJDUzpHIPFVLmABEOBNc47N4n/XuoymtMTfe/N2j4srAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UosiLVRO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UosiLVRO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b87970468so3702658f8f.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550364; x=1776155164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peA/baapFwTx+WaActDGaVNbab5ZZYgiEvN0ikh1DXM=;
        b=UosiLVRO0f/NtnSvQ3BS0HsaRY0kpZZtGQdEGUEzT1MqivhX++fFHNBDAm2JNhnRkV
         KF+xqA+rXUSuFQPpHxiPLxNY/MveA/idy46IDYReNUbdkFxzjaBtOzphVOhePToeofJJ
         ecKUxV76J/j+uwywMRMs3BUGfkLj5Iprb+cPFrhZBsGTGQC3GB3hCKMKTdU4F0wNRCnx
         N5eTumlAccWimGNYnIJRruehJQirfLSTnL/005zHyyekm1ilN0PcQ29gg0+sw1KP2/n9
         rBS8eBbdaWNoACF+MTJiPcBlIjC4gnzc4NRrhYB/gn9JKkk5KD6xBfMGCsVRayk1fhbZ
         ODjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550364; x=1776155164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=peA/baapFwTx+WaActDGaVNbab5ZZYgiEvN0ikh1DXM=;
        b=ekiWBIkQMCOD2h1IF8gIJjELDmOhq6y06fcQKHLkAkgzeS0R6GONOJqBfh+boOyLSD
         X/LJCTG443hUsO56AvFoNeW0Q8r+zUUn/LrMh2mueK94rf5fRuMEqPWrnSd9NLn5uRo7
         fNjkaQYmrtabxD2eGZVrlbAgLttoOJTTqRomq7ISr56vbBVyAyqlTDyNIAN6mvPzw4x3
         eELdSjnF8Ld9e3zp7ZzeGMzYP2+KfQkQ+3cFjG2kzb9oPwBnyEOlkREd/QsdnyffWl5y
         A0b+RMpRNt6UpqiJKk/IvJ9pYHqot0W9Hk5lPS4gW/GmEohB9d800MUy+FO1C8oNzDil
         w6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUfxqFzmOeFzijKzJglDS8YArPWgqXnJs/AKFOqrZtj+8lYxTL/Lw0YNUb4BZfWDVyQq3YrwHcSnsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49ml23aSGv5rZ8oq/KfVFXGQra4IRaFeIfVeiRgipXpUAN6cJ
	ou/U7z72mmkhGfewgHgHUVrB6c3GGnnLDNMFfDQQTF642uY71o/Sbmz9
X-Gm-Gg: AeBDiev0KLWsyrzKfg9l4FMKpIGCwjcbtJ+IebIuL7uaPpc83bzOUShf/XGQk1sQfwL
	oNUVQ93ZHGMQebwcPAU87d0LQ+USxCVH4slBO9W3qVtFifry/RN5Y3VOPt+2vWjQ23x4O9Vu+Is
	GTGP1r3rPUZn+c92UvTxBZTG1mOhIcZMNuf7HI0SOpLvo4ChOyqbB14DNqe8QagiPv74kAIidd+
	2O4EgCk7PHtzccR26eo+3pAixck3O2b6xSu+I/l4sOwHXi07jkq0OILZMUwxzQYj1gGMPtB8yiy
	4cmMpnNsMfuO9+ajXYy4eWn1ZNgSzw7veV4ZE/X+RXOUHl7ZUEs/XYfKFmOcdbEifmv4FaQaacq
	IyKthIT5UW+c/SES5suXN5Z5BkJVX4Xm1xgry6+ETPLMceRCGde7oZxIENEZ2/KMMa/f7dHluR1
	ZC/+QX0evxUG1dKONrtL/WTjCQFRXJ8+JOrOmd7iOvsgJ0GMt/gwScZi9sPNHl7J9j
X-Received: by 2002:a05:6000:1446:b0:439:dfae:8083 with SMTP id ffacd0b85a97d-43d292dbc56mr23436623f8f.38.1775550363826;
        Tue, 07 Apr 2026 01:26:03 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm48669958f8f.21.2026.04.07.01.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:03 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 07 Apr 2026 10:25:22 +0200
Subject: [PATCH v6 2/9] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-orangepi-sd-card-uhs-v6-2-b5b8a1b2bfc8@gmail.com>
References: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
In-Reply-To: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
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
 Trevor Gamblin <tgamblin@baylibre.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
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

