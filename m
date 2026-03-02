Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417B40F8D8
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464435; cv=none; b=utK5r+dGTNUHdSogU1Fvmx3vQyigCKMQE+rwdIvhRldiT1A7UE4+oUoqY1MTWW31YtDNTqBrKkOdUeB3zb3FpiddOUnP9wr/BiKeuZDarfB2EbCHwgidltEzOwlsfolagQZWQgXV0ag9QWmAATW5UzmQmGlUhOaqD/Q2IrFKv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464435; c=relaxed/simple;
	bh=d7a13S6dF61g9+cfR4EleR8xvtk9XXvgHgcgm1c6KYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JV+sbTVJEOrFbGpC6f1R8+uQc2OeQ19Y0tyKTAowwZB1jun9QeGRgpjulDYa1ganxl4j571Ng6/GecpEkkcdzSNAM23UpJnAj1mPT0kU1BDYEehwCEOsfkc/Vsz4PHMb1YrIx9+Uh5xCUR8kZCfE4zZ7+K6lKE83yWR2wz74TKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnCiMNbV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnCiMNbV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48372efa020so39364665e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464432; x=1773069232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjMmH3TKAZLFeVk2hH9QgAPKoSKsH6HVvsl5OwBldO4=;
        b=QnCiMNbV539UrhE36Qmb7phytvOnIfxnFJ781sYgOlgwNJN/zkURmPTLZvbeafDnZJ
         kvGhLWJPdl31Oa72XOPj47K6G1kxqVu9KwM/RfjiwjmP8YHlTsfXU1hDLIsBToJ9cDmZ
         /b/O0FIa3fFZFWzDIUlTgfhyUcRZKprD2sRMhwdIhX2Kl2iisInEi4HLDtYzQdILzcIb
         PVaah8eSr0Aij9wkJ8Y3hFgorbmh6tMvwJcxxE86Zr9/vOnP6ixEjRxbhLr74fiN31zS
         sl7wAp7VfC5vIINOG4mZU0ipngPYM1g2dXgISInqSeaioVFJbfUZAEnlSmXHOiYAsaiD
         cCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464432; x=1773069232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjMmH3TKAZLFeVk2hH9QgAPKoSKsH6HVvsl5OwBldO4=;
        b=S9DmPc3PqqAKIBD0zhNQz10Dua82Ypm34zJyPnlVSS/IaibevTdmFrOaTlywWeABEp
         roLeNUiozbZlZwM0B2ms3RA84KG6UPyjYag5q2Ey8TQ0btouY5aloSjmCsKc7ePAEfx3
         toOjmC+UgcqXx91Rn0+oKEAtUoiLjHM8s9AtwdY1tkcfVTbXVNDbxQ4KUzErfiINLUs/
         QpvR2+T21bPz9/mxYsmPPd6gUW9MVDWd7fhyi0n976Ucz1kw4/PxavAJ6lAQ46oPSFHh
         1NYSMqdB3S0WydcM8tNpwK6dGzjAkSPKD/q3mU/TwZbLbIbxj7BvQUd9Au005rRhLsJ2
         r+vA==
X-Forwarded-Encrypted: i=1; AJvYcCUiDoQ/5jJRqHcMLJoCTPFWBRCy26LbGQQJFyf7s/TUgG6/L3GRO+s5BRu+YZTnLWa1AdVxVOckZ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVAHSnSgg4JX1FQ9tJ0MtCLi3xpdRCKLkvAEjFQNb99DEfsSo
	jeeXBruP9xTZ6ZLBrhiCoO3WnUxRy4lZ16ph/4T6hHyk3ABXg4GyGTYt
X-Gm-Gg: ATEYQzyK3RAMI40xkXaNZEkhzv1FNkvl0b6zpb7Onr/yThXzGMuzhobWsBQtPgIV8zu
	z7wPd5O1tE4Iht4nJvrteI5UIzI9jYuSrNeGtaYb67/kSXEbnnBIbI/lH6bQerbQaL4F5jsZHrI
	/2Kd47H5Ojx7PnxH3QuQWUH7e8Vujy1lNxLr6U+4Fbm6tpK5g7YL5flmqWBVzSYxZxiFkgk24y1
	fU1nHQyVxn0+xd4cH5Cncl2f5voNtRZnloi/bIsD1IOU8rhjty9eT6CDtoczOF6swyXiIBg/7aD
	uRyZutu8QWMlFm7+vfdphcFGzdZ9qWf8ZD9FUv9USN299l9KwmAji7GFKr3ueU//vlnTnfMLktf
	hRp/vgdCiykz6EtPxIg7O/gTrJ7Jd87+Dg1z/o7YRndGYONIhCtWIPCo29Q1ULWhmbolW2WuA8U
	32nNhZ/PkPi+wJqL/oQcfEz9IKe4GzqOsAUXZTq8gzSIcboosOnIKVIrj+VjaSU0W9iGJ93cwsQ
	dp1
X-Received: by 2002:a05:600c:3e86:b0:480:6941:d38b with SMTP id 5b1f17b1804b1-483c9c1bc0bmr208716755e9.30.1772464431872;
        Mon, 02 Mar 2026 07:13:51 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:13:51 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:23 +0100
Subject: [PATCH 02/10] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-2-89c219973c0c@gmail.com>
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

Ensure SD card pins receive clock signals by enabling pad clock
generation and overriding automatic clock gating. Required for all SD
operation modes.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0cc97e23a2f9c7b2f9376318a8a7ebb860571504..b703b78282ed8d89183c816477c149c0a565618a 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -20,6 +20,13 @@
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
@@ -100,6 +107,10 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
 		spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT_SDHC_MMC_CTRL_REG);
+
+	spacemit_sdhci_setbits(host, SDHC_GEN_PAD_CLK_ON, SPACEMIT_SDHC_LEGACY_CTRL_REG);
+	spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
+			       SPACEMIT_SDHC_OP_EXT_REG);
 }
 
 static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)

-- 
2.53.0

