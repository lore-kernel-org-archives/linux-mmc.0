Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F653AE6F5
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859910; cv=none; b=DPcoWDkUEBXF8ghCJly3qPPM+2O0W85q2HiOqTX9QTF0awAhgldJgkKg8U7NYVMEQEMIkx52uyRqdR5JU1QVxl7WwcxJ9Kk2Rt/OHYOZ9gqOUDxbPs96DtkcRIz3I1hotWZxENuXL6o2ZmeBtsZajpnQOAjSUMGEdyIFh7NN2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859910; c=relaxed/simple;
	bh=qUA8SRWMHXak4DMGjiU5xSTobYDglxv6lNBrFgz1elQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfg9RzX5cw7+MvQAYqo3EOupyb9Rl5vifbY+cL4jAuTgjkxJbkykHCkyuf/TYuFIyUDclPVVy5ulUqYI9VvXA/8EVei6OKp0QsiaoC88Dz83LWUOltT13KVVTRmjpHMkKG71hfuKm/BU8OkeHgYv/S7z57ML7Ytu1OqZOalJtCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNQ95Wne; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNQ95Wne"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so55854945e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859906; x=1775464706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvVWaFSwZuIIuqOAIjURBh3MX19UZqagVH7905iJLbY=;
        b=HNQ95WnedpGSm0dsrYuIiHdmuQCNr8KQAZGjunr+GGeChI2Ptk5qCY59hZxDtJ6Qvu
         6UqVmzXbTSQY7XRi0HABmYmWE79SL9/FzHk/zAk0xBiY1BnD5/6wI11TjqBtmY6xRBRB
         o8dtdPsdGaJ59A70DlVdTcUxEcliR/pmIQeSNaXK7Z7d/oWT5rwBoIvsnB61hpSx3HgJ
         4vFfXNpGH5m/lH4f/ceT7tc12AdBlPlUC+I+nLLnyizh+ljNg6jpbvmobMcmFUw9mWuO
         D79dSgusqDBhaccKQagzRZBy0qoUdBlipFfd6712+ztQFGDmyPfHCJTqCu+9JMeNHpsL
         Z1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859906; x=1775464706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AvVWaFSwZuIIuqOAIjURBh3MX19UZqagVH7905iJLbY=;
        b=e6dHL/soIbfKVH1e4vaJ9Zuh5AytkQDX77tvfb0TbZnZ4eWxoXRhH+lULtKnnuKiyl
         +1KqIAEtaF9932ggNo4kdEMWo365OZP9TDISQq3yVo/4xaZUPUDbdo6fmnCKHg6ZfcDw
         ENWrbt95dlE5AJpYTTn36gii5GXdyH1w1wTDHy99lUuK8R28JTp305s3kjji/oV5z3Pu
         jXNN8ht730rt2YfZy2Y/dgzfflfqZdEFbNKxUh4ukK4WfFxeQ+k3f+J/6TuYDdWAr1N6
         HccsVm6cYc2NdptcTvP0qmus4kJK61TMwLy4gQkj+ctO4I632hOSkLUHSmakXqUVYKTU
         4fhA==
X-Forwarded-Encrypted: i=1; AJvYcCWrARunVl0L/bSmTnDmWV/OCWE4k43Ne/iMiRcCpFYoYN0A/tV9yKuqC2mp+nL5RNAnbN5vDU8PaH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAdMqiCRyy9J7lHsmrvzEaUlzqYabWwAFMIzVdlHUiUuqKJKU
	fYyK/ZcpT/nSk/xiOv9VLACGVSqI56SyXULerDbgBg4aZ2J6PvYycVAT
X-Gm-Gg: ATEYQzzazTkjvlUi63T0HB3DkQpyui/5iI/1QJyYCkyuv+JoUM/7JKhNHxjzVcy9fBN
	tBfx/tvg8RxrGtWfQpibtAOJakxjwW72XPklsixaMOnqPC8MCjHy/tthyB+SB2vqywW7U+P1B3E
	h7Kzp9kUbJw9ut053IoQzhHxNvTKbHLUe2unGBU6t/VIVCXPUidGOBtPH4/h3E34O/M2IuAhQe3
	m7fhSrqQ1X1T85iCAEWbuk91n/FTPsSwCudwEbsnVVgJs3gFGeIK9cFuW3pgWeMXJTijSjweubx
	WNG271OT2DfCYG+MTBdMabnnKDRD2zHdoAg7PW9ktzxMTyOJHgJBVXRju++QF8gM/ycPSWLFZ6l
	71e8LXWvuz5G0CluxxbE8itrFJjazhIis3j9u4znQ7wHImFXUiJJ2KwxwipBqza66jkfrOI32J9
	YOes0lcR4Rz5ikl2X/k6R8lxWFSN2XRIQCJhnanQRKQdHWSE7x77PcYWtQ3HcaZsVxnNw+2n7X1
	cs=
X-Received: by 2002:a05:600c:1d0e:b0:485:a4de:f4f9 with SMTP id 5b1f17b1804b1-48727ee54bcmr204093705e9.27.1774859906374;
        Mon, 30 Mar 2026 01:38:26 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712c236sm74063315e9.14.2026.03.30.01.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:38:25 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 30 Mar 2026 10:38:03 +0200
Subject: [PATCH v5 2/9] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-orangepi-sd-card-uhs-v5-2-bd853604322d@gmail.com>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
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

