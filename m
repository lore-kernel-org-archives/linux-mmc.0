Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150DA3A3E96
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067362; cv=none; b=W8CYZirqu+8JCM16f94vaWVUBGuSyYUVD02VgMv8x2X/+LhoYjKSuheHamJVHLezHjjGvJ/R0GzKfVbU8MfvcA7bHzbJLd6hauELlBDH066/JHjCgRjaGOT7IhFXUyq3JmizxpNDzJbW3jnVv63+tWGjIkEJT0g5lvgGdya+eJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067362; c=relaxed/simple;
	bh=BQj/LtLtvJAa8qPvNururbfdiFEeQmxim48bMkau+Ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdc/27v3x6oURSlVu2FPo30mGL4FuJo4eR6yMHxO1kWaLxKC1S0NAIYZ8Mt/mahScGQ4/a5X719wG5xjNw2ScwkaSdHoUdIKfjpRywgRRBYn6skRdRiFR7nkUINr1AVli6lf1r0xle0S3RSVDT+e4W2t2CiDDJnB1GQV5Dgb7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDxwhHPC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDxwhHPC"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so4100666f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067359; x=1776672159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ej5PuXGxv2ijMAzQ8gpPPur0ekJN7jy1Kje2MEZFQ7M=;
        b=sDxwhHPC/kAaUPifrhWH+QNatj5I7JEzbeao/+4Tv37OLdp8MJgt6FPk8KfEY3XELl
         +dLTH+ec4tpG/x94DRRBIGmUAuGT6WcPB7Vh5PI3oUONYSEF6if+lB9sNWm3ehbUZdpI
         FJm3pwee9nL5lpUkClaXjWHVONFotu/xayjJ00POFgqAX3lI5zWvgL4JXSeUP0pAholT
         VCWEso+dQB9nTMsfFkdKJoi55NBL8HyR8i8Cl+0VxrV7Fh8ndvYyGb0gT8TBMdBYFDdC
         5KHxGxrJ647epSeainwOK8FAvW80cpPZR/vsIjCfX7xP41/KiJVcK+fZpbhT9zShgncL
         QtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067359; x=1776672159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ej5PuXGxv2ijMAzQ8gpPPur0ekJN7jy1Kje2MEZFQ7M=;
        b=FSg35QQJMn3LVyomkNOZ3kEYGrV66ecC2CnXKjXiYtrVLqydg4aQgISYrTD0X9J+p3
         FmWrp6c7hE1kDnbQ+A22hJKrQ32wRQvktbCfd6RJu7m8HrrShYPBdCxNHKxEgcxnAc64
         Ov4FHw10ULFeR1Pp5rEvJPL6Nf+pXKLkDIkh1UFkSXTN5O+yU076A9+0WXTV9fDAPchz
         dcyK98FMY04vKyRkfhIwR8PbKNJ77AmBQYm+P0T0azlo/BD9BdAHpQThEZpw2b/VgyiN
         yGyI5KaNPyBDGm7TxRXZDKLlG3AALe4EEi8nQWhl3cw1IYN8DBmRVqeunhTl9sHdSIYp
         VQ5w==
X-Forwarded-Encrypted: i=1; AFNElJ9ZN2x6SBFEGdilEJeKkuRBTfHlAULiwcwALM8c9Pq5z5rBoKX+2rNrxGBxwwzH0Xv8+HQsVAXMYDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYg23Goe2dDKA2tDjPSM2gKbfHt05ZB/yi6r68eIs+9gyfAl3y
	8UDXFlZe9/+Mb1GBpxxmsZGY9X6UBsV5NodsUC5f3ieHjTNjE4UK/j2/
X-Gm-Gg: AeBDietco0ABGVbN/2WvlW6/MzpKqgH/iWMCgPX7j36f75Ug5HeUiIaMahvnWmQjbaH
	vzW6BzasjA4JXN4sFJsaZeqRRxxF9rATsJlOJ7O2pBjlswSFq8nteo/ZVzWWHATjS3+C6fJ9NHf
	mTRWtsgSYj7wANXafYEvRbN7N1/EZlymBaziit35Iwt5DWMG9sSkDWRdhfTOF/e/UpyguKnHqOU
	JhTraIGzK6/dDrqc44rMhDOe/UlqdkHNM+Y7tZMq+k+Mka1iG5AQSbMjzvxUfiN7ReRcNibPjkz
	0Vu/OlA++OZ884IKLVnb/epGoOenm2fDAktYYkBISBEOHKhAZT57wiWdvzpYTQSa8zUgjLlz9jo
	Ze2Lgo6Vf4z/5z1sCxSROsDEdIcbMSEqnmVUrE22R15V1B5wI1csWV82pmZUX9l2uZr1hrHgdkz
	MN0mKgRWJLXSYoPhkIK7cH4jb01zJoFBmVLE0SinvTiLyKpQKSLS9pas4m75LBrpHq+tFtpGJiS
	ww=
X-Received: by 2002:a5d:584b:0:b0:43d:7783:c677 with SMTP id ffacd0b85a97d-43d7783c827mr5141524f8f.42.1776067357834;
        Mon, 13 Apr 2026 01:02:37 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:36 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:11 +0200
Subject: [PATCH v8 2/9] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-2-c21c40ec16d0@gmail.com>
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
Tested-by: Vincent Legoll <legoll@online.fr>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 455656f9842d..0dd06fc19b85 100644
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

