Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E9149001
	for <linux-mmc@vger.kernel.org>; Tue, 27 Feb 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047187; cv=none; b=KsmveoeSXnUrlbW/pI6i3l49WnMMGLlTgCM+DjUtT/t5j0neyeJrP2O66TlfxdwdzYcICJf0YcX0hTACIcZeGMo280tBw6iGLj72RTopjPmdVcZ35V7FgsNIge2W3SqlWyiSdI+RjJ+Oh6puDqP5qjHSmZ1/dRiMbxx56JJkgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047187; c=relaxed/simple;
	bh=1eNIzp2hVyu86ifPWamS4GJF+6ehiaBwAfMIgJI98O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc19ND9D6kq25nklTYEOSpXkpukrwoGCM3cWVhh5dWWZ/UjkaoCEp1W5nToW2t2+47fGtZGfGW/wOAoTIiwxA6V6jPOGtlERCvX79m5UQeO7rtBAm37lq86KWn3iVugIMIoUJc0EgAzDnhxhtVcMJd+KJ5Yy+vaGbwMLwKMdtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aE64fVmN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aE64fVmN"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60925c4235eso8262057b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 Feb 2024 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709047185; x=1709651985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SQHtHx9/7D+RJHlwNQ3ZmvXdbc7JG9vTHxtAChltzg=;
        b=aE64fVmNGIjZhNMl20RnJ1Z2vNik3IIUBO1amccpbHT4pH8oEB8ulxHSOO2WoN4mLr
         ADGwefDOnlhk8Fse/HYl12Woa+Utw+/A9hfexP96r2pmuYqRf4wJSZod4y5G0SGcmT4a
         kj/+Pe0Dv6odiC7qWIGjLA9N9htLUbOZvTNxxc3xE3SCOj/jWnDWoZF7Y/iKzX9CRntn
         gCeobmLT4nrL+zeuFT1Z3Jq/Psw5IgHaw7n2C615nTNK7jVcSCS5eo08ZzjpRBx0TSBk
         DKH/pCCIeOlh6FUt8k672fmorGBEcqNlHU2bPsm01Jl5GOOd7CkCByoIXD8YQvxxV5dG
         OpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047185; x=1709651985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SQHtHx9/7D+RJHlwNQ3ZmvXdbc7JG9vTHxtAChltzg=;
        b=P9T2Xgakf8eP8fUqKDiToSNnHaJG6g5Med2VaEJiVlI8rgRLPodUuDpVXD9Acq0va1
         I4vtAt2IpjoG4faDBXztocRaVuF/7QIp4YylBaJIJYmMhNUi9WMCMGjJgg71NxYYU0Pb
         gesAbw5s/+NAkfV2q3HWr8w7e7Y1ZZus8mclUwfbwP9ExiqpEC1DRwpEgm2poWgyboad
         m9N2Ov7sPSoSy4Ijjh1PSwqrAAXHSg3sEAydFQI8LEV/ZvzB1hwkotNBSyf01I9g4LXO
         9oQZRvd3Bs18ez2zyakuYFdkrZSYgGu9QOCrMUhuomL7d9sHwYqOv2y2SSDG3Ax8KHOp
         oaMA==
X-Forwarded-Encrypted: i=1; AJvYcCXhwfM+i/YCLu+4rbw9uh69kp4EXqoif5M/Njy4G9LE4ASlqcuFKKMaiCC1sseAU2OccKjtH9DPwqMyMU+g+Tkwbu/YH90Kcixs
X-Gm-Message-State: AOJu0YwVU7uzzwCx4CEVxVcGHA2J/ns6GQP4kgB+8mhEw76UE1ZJ2y+Y
	qb/s+yl/ElxYB7I+ONYT0yt/hVQjRobeDyeW4toutmRQNIL4JChmCmIbuT1obDGJuaUtvbGuvM6
	mOVaBKvcvgSx+qJ4kCLWC7Mr3npQr6l+DlChEfg==
X-Google-Smtp-Source: AGHT+IGb/gVl0DDdpeDrbG9O373vERg8t5XzgPbPswqg0c18k4mhJ043qddt56IRCGHrvdFkGSVOxmCdtVn3OngFE5w=
X-Received: by 2002:a81:5d84:0:b0:609:23fd:a3b5 with SMTP id
 r126-20020a815d84000000b0060923fda3b5mr2212466ywb.40.1709047184552; Tue, 27
 Feb 2024 07:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
In-Reply-To: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Feb 2024 16:19:08 +0100
Message-ID: <CAPDyKFoq=MXVdUP9hqMgOYN84aog1htYeWQzd9v0vWcU-TfVdQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] mmc: add hi3798mv200 specific extensions of DWMMC
To: forbidden405@outlook.com
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Igor Opaniuk <igor.opaniuk@linaro.org>, 
	tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 13:45, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> it's modified from hi3798cv200 driver, but quite a lot of code gets
> rewritten because of the hardware differences. Actually cv200 DWMMC core
> is called HIMCIV200 while mv200 DWMMC core is called HIMCIV300 in
> downstream.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Please re-order the patches in the series so the changes to the DT
bindings come prior to the driver changes that use the new bindings.

Other than the above and the few comments I had on patch3, this looks
good to me.

Kind regards
Uffe


> ---
> Changes in v6:
> - apply the comments to the first patch, add their trailers
> - Link to v5: https://lore.kernel.org/r/20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com
>
> Changes in v5:
> - pick the dependant patch: https://lore.kernel.org/all/20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com/
>   to fix the bot build error.
> - edit the semantic meaning of hisilicon,sap-dll-reg property (Rob Herring)
>   The suggestion is from the CRG driver side:
>   https://lore.kernel.org/all/20240218205741.GA1561527-robh@kernel.org/
> - Link to v4: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com
>
> Changes in v4:
> - rename dw_mmc-hi3798 back to hi3798cv200 - Suggested by Krzysztof Kozlowski.
> - add r-bs to patch 1 and 2 - Reviewed by Krzysztof Kozlowski.
> - Link to v3: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com
>
> Changes in v3:
> - dw_mmc-hi3798: fix bot error (Rob Herring)
> - Link to v2: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com
>
> Changes in v2:
> - dw_mmc-hi3798mv200: use dev_err_probe() helper - Suggested by Krzysztof Kozlowski.
> - dw_mmc-hi3798mv200: add missing err=0;
> - dw_mmc-hi3798c(m)v200: remove unused MODULE_ALIAS() - Suggested by Krzysztof Kozlowski.
> - binding: rename the binding, a lot of tweaks suggested by Krzysztof Kozlowski.
> - Link to v1: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com
>
> ---
> Yang Xiwen (5):
>       mmc: host: mmc_of_parse_clk_phase(): Pass struct device * instead of mmc_host *
>       mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
>       mmc: dw_mmc: add support for hi3798mv200
>       dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
>       dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: add Hi3798MV200 binding
>
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
>  .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         |  97 +++++++++
>  drivers/mmc/core/host.c                            |   4 +-
>  drivers/mmc/host/Kconfig                           |   9 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
>  drivers/mmc/host/dw_mmc-hi3798mv200.c              | 239 +++++++++++++++++++++
>  drivers/mmc/host/sdhci-of-aspeed.c                 |   2 +-
>  include/linux/mmc/host.h                           |   2 +-
>  9 files changed, 349 insertions(+), 46 deletions(-)
> ---
> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
> change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c
>
> Best regards,
> --
> Yang Xiwen <forbidden405@outlook.com>
>
