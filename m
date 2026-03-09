Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4623A5E88
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056433; cv=none; b=KCeNMN7IjURXoEwoHh/19AJGOFdwtF5RAWwoxet3+IQ5JK0gYu56roEAaWOElDoxdAGaasC5tk4aCMeoMd2rt+xYInhGDSTlsGB0JIOhar99hSxSmHyI8tco5RVY91lxSyMp7Wz0je6P8m45l04ZsR31X+AkwxssJ627AY/hHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056433; c=relaxed/simple;
	bh=ZjPfOEay4iJtYw/Yc+++kB4+JFWKKrhSslqGPOY6h3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EM22Yjy/V5BmRvD5gXASpzzxNR45PbBEwJeti36M4jB4huftvcvMr7+u3Uhf0guDL4/YyF6siQIu/ecPkQR97CMTNXsYfYptF6JzWo42rkNZSP+04hB2+Gigft0h0XSlFDqc13HBnQ8NNbQFMI9GnVHAxkEHxoEp0S5jsnJ3048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZX1mTv4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZX1mTv4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so1529113f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056429; x=1773661229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENoXAlYlr/CKB5p2K9cJMvCPGqe7WoN4P4jGKMHaZJw=;
        b=aZX1mTv4BcFETrP8V766dzYE1sW5H2vUQLZmfEuPz8pOpv9l+YItQQI0oZiuSiTPYO
         FEHXb/fiw+5BPgkmgDcq5mPKz2iSQGhQ21wIuB6MDl7n6FdyNF5zE1tL7ZEv4HjKo8jZ
         vKRrr8iCvqVkmFEB3E7/Ptthmo+KenDqqos+HeMveUn65rpWgceCcdDrZL4y+qdjxhsQ
         +R6IzucsSplUPWoFjlRh6F4QNk1cufh+/be/sCAtoYLVO/eRTX1I/NtVp9E/901fa7G2
         hX5MHt2ujtSaN4xgT9pN8+gXQUzxUZQat+QiNWd4wctgOFBMRpFMx+itJ+1gpCn0hToz
         2bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056429; x=1773661229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ENoXAlYlr/CKB5p2K9cJMvCPGqe7WoN4P4jGKMHaZJw=;
        b=OlEgCHPa4essu+zmCArQQD4GP4y+20pUk2gvdUBo/OfaL5MDiJ7zsDKfE8JpsbNo1v
         R/PIAumOCJyQmI7k2APSWjDI6FE1Rj53S207/ff2beL8xDz18CUkLgCdr0ByM+xe04pu
         T+1NEWF2V0RsSlBFgqqFzDO+QGRTFkHW5BJRl3wfNBgkP188t2s0DCjHPWweslRX/vb6
         kOhZkF9wuAxxH5yGkvxqA2+rUzCAf+p4g/rXLN7Z0kpMr8YWtGJ8DDJBJUfYMr8i7URN
         BpYWClZpbsfBpoebY8JIUAkYrM0dC7h8Nzj44URAd6BcAKoGdRWM9oA0ZAGAM+hRnydm
         Dp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdvjuLsUnf5kdio/9FaItSzArIMlZyED2FaUHGsprCUnO+vxWpFgryeQi+9+gFbdByHqPhimKAwZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7alG3c5JhqL6b2DnjsTebIFwfaOV+2PX8bdRFOTIFqzDvjg8
	qxhtBQWiaAsdqf3HcnuASq15kTgX6sIpPvAVqsVv8kFd0aVGRMXS8bI1
X-Gm-Gg: ATEYQzw8Kb54/97oayy52IqeMJuAc87CDaScVMepClEQIG8aHTieVYB2WCLFOioq0O3
	JIHbHVw2u95CfBqCW2hjvBr9I7BBv0X5KdF0mxGROWhDM9OcvqAkUavHd3UIXDP5Dy3Lr/yW2Ef
	iTts7F/9Tc9DYZ0Llrd2cMyiLJoww3zXeObQGCCXR4ecL8R6UcwvGiRGePGPGsmlMumyNiyMIjR
	HaPa6H6i3VwUNvB8t9+b3nvki9aaWlDKwNMTlWLXHXjLnDY72perTJsNVj60MBdddCVVaKqtNSU
	MDfo9QUcl2Le5Ajfu/bQa/X8YneoHjniSQ/qnC2939b2eyeT8LR90DItFDI9Lhko7UHXb8CwWVk
	PavUI5CFU8/G38mC7Ymw58ld09BB68m7eTaMIfLlGJa1bIQ5Yf5vDPwJGT4gSXVr/nQuUFanGDl
	Kr2Hx89fX7LsacAbG78VV+Jus5t/Wf76wDZKAOYoIDl28tSzSYb9EhOsMsMW8tvs4V
X-Received: by 2002:a05:6000:49:b0:439:be67:a02d with SMTP id ffacd0b85a97d-439da67c0c9mr15289084f8f.31.1773056429202;
        Mon, 09 Mar 2026 04:40:29 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:28 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 09 Mar 2026 12:40:11 +0100
Subject: [PATCH v2 1/7] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-orangepi-sd-card-uhs-v2-1-5bb2b574df5d@gmail.com>
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

Ensure SD card pins receive clock signals by enabling pad clock
generation and overriding automatic clock gating. Required for all SD
operation modes.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0cc97e23a2f9c7b2f9376318a8a7ebb860571504..585c7eca6ebf253aac466dd37cef029deb63f692 100644
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
@@ -100,6 +107,12 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 
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

