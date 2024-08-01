Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8541662F1
	for <linux-mmc@vger.kernel.org>; Thu,  1 Aug 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510102; cv=none; b=VvnWeTpA0W2cJphpxQMSCtQcF+SyEJzGhoK/0szCCTALQn8Ky0jauQGzR3on0eYr1uGoURsW44UpjBfgDMUUxToRNd0A1igPwdopnYT4BSgVXvMrSqBqlzDXwnjoqMTNpFLtz7gd/zoBVVFJS/xF+RBOztAU0G3OLaMA+RzvKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510102; c=relaxed/simple;
	bh=R05DKqS1w9uIVMFcvpKFDclE86k9lkrCoWmX9bfJe1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZo5ykUO0mtpGXMBEPyPjYMtgtquF+ZF9QN6qxnmrTpb5OwOTQBM0OCg7UorZKN17snErMpETHo6ns1wXpO5Wc+T9/vbuQtlxM2bnOhyWn6HDu5060i8yyPF3dKN1KGCQDkqoctzpPsOTHoQ3p4khd1IZ3aG73tbArOEWn56fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIPTLMv1; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIPTLMv1"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1677550276.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2024 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510099; x=1723114899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hvEVInb3XjDTInVG42ARV/26R6ebE2gUOo+RJ8/4wBc=;
        b=UIPTLMv13scF61MazmIeN3uyvRfzpFNDGGju0d60AEmK17qr3p+FZ8cSyN8+0/Ta6w
         fI4UwhdxfJCQNhPPPJQtescLMDR9j9TOPQv6H/SmoKQmuZm3JMaxUPSNiX8iJttEmIIq
         5ODOIePiPbxkEnoDknaA7awyC1J9z5Ri0P7e8RxAMnjZE0iUatwsEYr8J50nbAVzFZ2l
         DA7OK1xBJejpL04ovA11VxV4MvIQIixNKQGmAxG4gieH7+8MO8q7AkkWLf35zLiJKfdR
         PuNR5OUPKIOAj8pbDAEod0vWPe+q1MjXCuUi4Mr43uVMO3DeAB/db05QjIPJSAZdd2WJ
         oSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510099; x=1723114899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvEVInb3XjDTInVG42ARV/26R6ebE2gUOo+RJ8/4wBc=;
        b=Vy53ODR/yp53aVNTrdYtQFKoiNM0hu7ij6eHxd8xPUfyMdfP5y/gKcNa9b1EG0p7TH
         gULn+W1B4IDF9CLBBTIE7loI35MI1N/YLvvdoiartIwZv131M01LO6LLJU1vWBx+O4Zh
         qnVxbvyj42i6uUsM3Zjlp3nGox7kk1SzRoFzoN7n8t0lLBLqEh3PAT9bqkWXGEGbJixG
         2Ep16BbY8iz5il+ov4cazAvaQCvRqw8tv9V4hkabjDLEtemlYy9+6qM4AFFZCSkH8M/l
         /T7Mk3HIsKV6avg3q+T2LfmqGLyC6BhTFTIN7FLhVWtBdqUTZ1FZDGCw3Tj7pGPlSImW
         +dQg==
X-Forwarded-Encrypted: i=1; AJvYcCVFRoV6KD58hFUXklyX0ygeAr0GwaBALaoJaYARhw+FhbuWXSRIA3HOPfBswj8QpH91E6cq5anMd8ySHlG1x+JZ/BuwhKioTA65
X-Gm-Message-State: AOJu0Yxy1MaQytUn217jigB9aQB8vsVNEcsXuTko+vPgHazOCFHbQvmm
	qylV3L33dI8luG7iOdJa0lcVNO4pP7Re4G8MmN2oL+aMO/B6hOeEyehyycgd7vWrF4NWrnwo0wy
	VxskBhKQ2jmKx8/4He3PvMAGCQOepOVfGUTW/GQ==
X-Google-Smtp-Source: AGHT+IEMWWDuLSCLxVuVMb2OSeIqnvFCckIeIsKnFAFjoQOPspTTLeiCkBU/fF7EcmInj8+0rp1IhGoCa55ZCvPHsDo=
X-Received: by 2002:a25:90f:0:b0:e0b:bc8f:293 with SMTP id 3f1490d57ef6-e0bd5420f5bmr615793276.0.1722510099291;
 Thu, 01 Aug 2024 04:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716004527.20378-1-shanchun1218@gmail.com>
In-Reply-To: <20240716004527.20378-1-shanchun1218@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:03 +0200
Message-ID: <CAPDyKFreG39wJ85Mz=9MnkG-u=hDFCppsgfmv_mzpPbT3rxpmw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add support for Nuvoton MA35D1 SDHCI
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com, 
	serghox@gmail.com, mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ychuang3@nuvoton.com, schung@nuvoton.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 02:45, Shan-Chun Hung <shanchun1218@gmail.com> wrote:
>
> This patch adds the SDHCI driver and DT binding documentation
> for the Nuvoton MA35D1 platform.
>
> This MA35D1 SDHCI driver has been tested on the MA35D1 SOM board with
> Linux 6.10
>
> v5:
>   - Update to nuvoton,ma35d1-sdhci.yaml
>     - Fixing the same orders as in the list of properties.
>   - Update ma35d1 sdhci driver
>     - Fixing the error path syntax to err = dev_err_probe().
>
> v4:
>   - Update to nuvoton,ma35d1-sdhci.yaml
>     - Fixing overlooked issues.
>
> v3:
>   - Update ma35d1 sdhci driver
>     - Fixing "Alignment" and "spaces preferred around".
>     - Fixing style for multi-line comments.
>     - Fixing double call to sdhci_pltfm_free().
>
> v2:
>   - Update to nuvoton,ma35d1-sdhci.yaml
>     - Remove some redundant descriptions.
>     - Replace 'minitem' with 'maxitem' in the clock settings.
>     - Make corrections to nuvoton,sys description.
>     - Add sdhci-common.yaml.
>     - Remove '|' except where necessary to be preserved.
>     - Keeping one example is sufficient.
>     - Add regulators in the example.
>   - Update ma35d1 sdhci driver
>     - Refer to 'include what you use' to modify included header files.
>     - Replace the number 8 with sizeof(u8), and similarly for others.
>     - Use "dev" instead of "&pdev->dev".
>     - Use the min() macro to improve the code.
>     - Use dev_err_probe() instead of dev_err().
>     - Implement an error reset check mechanism.
>     - Add devm_add_action_or_reset() to help with sdhci_pltfm_free().
>     - Use devm_reset_control_get_exclusive() instead of devm_reset_control_get().
>
> Shan-Chun Hung (2):
>   dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI
>     controller
>   mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
>
>  .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    |  87 +++++
>  drivers/mmc/host/Kconfig                      |  12 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-ma35d1.c            | 314 ++++++++++++++++++
>  4 files changed, 414 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
>  create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
>
> --
> 2.25.1

Applied for next, thanks!

Kind regards
Uffe
