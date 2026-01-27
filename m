Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3A30AD06
	for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511718; cv=pass; b=YmDlLLvcivpXhiqUeCQd3mrPIMu8qcQHNmHvCYpDTzZwX8XKC6pfXnyFHFGLoyi2S3q+xnjEjKl5Rh3ybNA1jSPEgD/UvDbyx2sCrrW3OuBfI90k2v9ladla+NNovkmoLg5M3gxc+TuVfT4vJDv/DcMt638U27lcSuHwoh5jeSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511718; c=relaxed/simple;
	bh=Zh3MtVvElCyR7i2oKDMC1exZ7K3A0CEScZDN6YRR3oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idEHS5ZzWQvU3MiOJxZMOc4Z9/Ld4p5QFcPTUxiZBqQ47ThgSp1/5THLqmyoiL+nG4N4RYpSw1s7XK9UjJiXM9uoOwRKNefUYSx3+GA2sJhKLVhGDsiCNU5f1SUw13fm8rk8xCMjs1dD8CTZr4knOgMRPqW2dSUNrfUbRTE6hxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bwRSGhDi; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwRSGhDi"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59de66fdb53so3702434e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2026 03:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511715; cv=none;
        d=google.com; s=arc-20240605;
        b=K547P76Tsr2r61lvP+Nxg36ZGDzpBF8ppoY5pB8DUxw8G28yUrc0bHcxqMcEtRvpkW
         N6i4vwtlbxrLfqU6OMJRvWMHrRCoxupwOb/W/IBHP6RP+LCzGy6KWVzHtVLn5g4TMMsY
         18d1imXBkBZyWsjkZpT1XEB0hcfcYdE+ovRqVNM8rOFjLZO8jSqfFr/YtshEC+f+ZJKZ
         HYZXH1P+BPjTAutu4Ffs40464c2c5DIHzTiW9voNhxrdavAt8F31x+ZaAtiGIvMgkPSt
         MuMItkRp1XJZOlMDzx4jnpT+niYcJ3h0LO8hi76aGAggimsVb8h7NMkB2htp+NfTZfi5
         X+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PhbuZflrYoZI1s9xrK2220SYSdiXayJsomDwy3Z3JgA=;
        fh=g2w5TbI4I3sboZT8biKAcbCJRMsG7Dgt/hb8jv1wH1A=;
        b=Yuv2yQBPwL/vk/YhPqA7NfuYAFEBup/KQ23/ekIgVxEXKAIJoKMppyGwNS91azgxAK
         51sSzr1IadShxxMPmiybwnW6kQG87lzqCAptfcd2k8G2wZnQLLf484XhVwg6d8WELOw4
         54CWtGSQlzzmABsYE6ks3KMZh6t/NVcynJo8MvMu6lrE/HSNlmg5gF7LF7t6N49awxW/
         AbUAGq0W4ettJdZFQ3aQ9b8++sDcpHGB7LSgOouvFJf2oHJ8GmC4uxJm6YzyFVMDXNKd
         xxAmXQoXbqGIygNfMahpURAHt16SNUZSYS/ibEBlLwqEh6AHX+X4DF/uMn1yDUL78e1i
         c8KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769511715; x=1770116515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PhbuZflrYoZI1s9xrK2220SYSdiXayJsomDwy3Z3JgA=;
        b=bwRSGhDi3Y+/vNbpp2EgZndpbRo0VPl099SLE9vj/LAXaHQRa3GG15cDL2NxcQYh+M
         95O7kN7IDn6Bj/O747Ux+Y6l9iP2Vg1rHWS+4x2EH6ch53NuawcdHFLX0Csxf/giIanT
         9PXJ0c1SLAb/fJtlkQ9D0bT6LqdmZebyl+t5fSowDBkz/qAUE4nfopyfgEt7wStqv4wM
         waySXYFxxHWE1GKujq07By9kzo2X7nvF471MQjPuWT/kumop/eCB47CUEFSC7+8W+YGs
         TanwQ1HJ16P/sT6VA/Dpf3uD7PlRfhUMmzh3ZEGiRxnBRw1QLhqWI4F2/F9O+3Rjdc/1
         Ezfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511715; x=1770116515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhbuZflrYoZI1s9xrK2220SYSdiXayJsomDwy3Z3JgA=;
        b=T9qD2hufp3h5dFlLyY1t/ztclz2E8M3My7P0TbGdOQAiM47MVwo6WizIgvIagn3oWF
         /XSe8YKwDhKeBGsbiqqRwqK0qh7XqFSYk6lqXf/YaayCrnLQGic8q4t9oITMGNdJPE7E
         /eNLBrnNsaFPabJDmRge1Xz0DZ8hnZwzmp0hEVtfqOywSLjZXhocdyPZsjmZaAkfsmiG
         wg4fR7juT3wzlyz5IvQyBaRzA9WzDI8OvbyL+guYaCEwdGKE6rQ2IP1RrVRa2A2NENuz
         6TsttP5a+BoE9CjvvtirsxrNj7w0WuyDZONa6NLvNrmk8nAbbepe/PpQdx9ZXksGJZEJ
         1oFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPUR4dKq3jOR05pzwNwEXGw4heSsHEHFvnGbrEM+Ouj2CMgPuwBwq1B1rIBnCCP/qkciewaKdsrk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPwraCTI1gIh4kBU52+GvJjkjQna3LvZyysHFuAp4zjzA796+
	LQkey8Y5W8wJsUn8DLDgSDFXO7NekOTCRF7dT1oRVT94XsQUaV+jXgIGfSDY3QQKg5d+2PKcdr5
	nrwA0lEf2fwpiKXzGOfVo81mAlAzHkj/omTbXjV6UoQ==
X-Gm-Gg: AZuq6aK27z6ZxiEsoBIfdKmVBtEyXiPRmBJAncsQAVY3LNlbRbaoX1BeQWSJcVV+wEd
	N4E/tjK+FnrWzbqDMt+ZYggn5tDKtcTkf45iVTh60QAIU1X1iihoi7qea95VH7E1mAwPZkrehK8
	u7uWKaTroJmktkds6iYNUlFgrkvTEIt7AGZoCj5dXcTE/e5B9fQwP9sJwe1YEbHhH8NlUWIMl30
	w+GiUYQ9ms6WGwyd3t0mgo5KNeu0nqJF9BJozwzq3kA5+mJDA1pM1+AyKFxagkwan5zow90
X-Received: by 2002:a05:6512:2510:b0:59d:fbea:2c05 with SMTP id
 2adb3069b0e04-59e04025390mr519384e87.24.1769511714445; Tue, 27 Jan 2026
 03:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123095342.272505-1-yangzh0906@thundersoft.com>
In-Reply-To: <20260123095342.272505-1-yangzh0906@thundersoft.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 12:01:18 +0100
X-Gm-Features: AZwV_QjQJQRTg1ti0bxzkqTQwuY-jbSIMpY2vglnNnSJTkeJy2p56e4qMngTfno
Message-ID: <CAPDyKFroOi-7Dir_H2fPX9Ne6zFeM4=XD0eMMrX+iJ_si1n2sA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] mmc: add support for BST C1200 SDHCI controller
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ge Gordon <gordon.ge@bst.ai>, 
	Arnd Bergmann <arnd@arndb.de>, BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 10:53, Albert Yang <yangzh0906@thundersoft.com> wrote:
>
> This series adds MMC/eMMC controller support for Black Sesame Technologies
> C1200 SoC. BST is a leading automotive-grade computing SoC provider focusing
> on intelligent driving, computer vision, and AI capabilities for ADAS and
> autonomous driving applications. More information: https://bst.ai
>
> == Background ==
>
> This is the MMC portion split from the original v4 series [1] following
> feedback from Arnd Bergmann [2]. The platform support (vendor-prefix,
> SoC bindings, Kconfig ARCH_BST, base DTS, defconfig ARCH_BST) has already
> been merged into Linux 6.19 through the SoC tree [3].
>
> == Series Overview ==
>
> Patch 1: dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
> Patch 2: mmc: sdhci: allow drivers to pre-allocate bounce buffer
> Patch 3: mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
> Patch 4: arm64: dts: bst: enable eMMC controller in C1200 CDCU1.0 board
> Patch 5: arm64: defconfig: enable BST SDHCI controller
> Patch 6: MAINTAINERS: add MMC files to BST entry
>
> == Testing ==
>
>   - checkpatch.pl: PASS (all patches)
>   - dt_binding_check: PASS
>   - dtbs_check (CHECK_DTBS=y): PASS
>   - Build tested with ARCH=arm64 defconfig
>
> == Changes since v4 ==
>
>   - Split: Platform patches merged separately via SoC tree; this series is
>     MMC-only, submitted to MMC maintainers
>
>   DT binding (patch 1):
>   - Rename file from bst,dwcmshc-sdhci.yaml to bst,c1200-sdhci.yaml
>   - Fix example compatible string to match property definition
>
>   Driver (patch 3):
>   - Fix compatible string to match dt-bindings (bst,c1200-sdhci)
>   - Simplify clock divider calculation with clearer frequency range logic
>   - Add linux/bits.h and linux/bitfield.h headers
>   - Remove unused linux/ioport.h header
>   - Rename SDHCI_TUNING_COUNT to BST_TUNING_COUNT
>   - Rename BST_EMMC_CTRL_BIT2 to BST_EMMC_CTRL_RST_N
>   - Fix BST_DEFAULT_MAX_FREQ from 2MHz to 200MHz
>   - Convert kernel-doc to regular comments (per Adrian Hunter)
>   - Add sdhci_bst_free_bounce_buffer() helper (per Adrian Hunter)
>
>
> == References ==
>
> [1] v4: https://lore.kernel.org/lkml/20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com/
> [2] Split: https://lore.kernel.org/lkml/09b1318e-21dc-4354-8733-866b70696295@app.fastmail.com/
> [3] Merged via soc-newsoc-6.19
>
> Albert Yang (6):
>   dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
>   mmc: sdhci: allow drivers to pre-allocate bounce buffer
>   mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
>   arm64: dts: bst: enable eMMC controller in C1200 CDCU1.0 board
>   arm64: defconfig: enable BST SDHCI controller
>   MAINTAINERS: add MMC files to BST entry
>
>  .../bindings/mmc/bst,c1200-sdhci.yaml         |  70 +++
>  MAINTAINERS                                   |   2 +
>  .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    |  19 +
>  arch/arm64/boot/dts/bst/bstc1200.dtsi         |  18 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/mmc/host/Kconfig                      |  14 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-bst.c               | 521 ++++++++++++++++++
>  drivers/mmc/host/sdhci.c                      |   7 +
>  9 files changed, 653 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/bst,c1200-sdhci.yaml
>  create mode 100644 drivers/mmc/host/sdhci-of-bst.c
>
> base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
> --
> 2.43.0
>

Patch 1 to 3 and patch 6 applied for next, thanks!

The DTS patches (patch 4 and patch 5) should be picked up by the SoC maintainer.

Kind regards
Uffe
