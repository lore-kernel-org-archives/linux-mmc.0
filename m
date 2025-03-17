Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07910235354
	for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208718; cv=none; b=U94howMXKAPa9SowstKXtXmFLJVW6xBENQaGEE2qJif39m7cCap5r0ppcUNR0E7EfkzCbnTQ3/n+DFMs4rTahy9BFh8Gg37E/DIqoro+dk+VIVld03/Brz0dnqxaqEQQTLuj3FFErSCQpBQUcDUEaAqQ8/YDVZc1ymM85nDuaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208718; c=relaxed/simple;
	bh=9QI//LPCNtLBsXPXDl5fXPWjOCldy5bw6wjeMAKK2ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFM/osCeju/rRfgrTxJRnYesrZU4qkjumubG2h8uQqmxjram6T1UFxk1N7QtUA10ySh5pHQpve/33Qw395mahJDpfBdwkWKcmWlp+1HgDm2ngnHgejsa46EITdW1yceF8BIkKKw/IvGHyiTALF8iCVJfmXlaSbDZKhkr8Jhcedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gliBOS/1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gliBOS/1"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fed0620395so37493017b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208716; x=1742813516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FX4+nDjPa97pvqp6xc2jGfEChrIN3m+xL1+vCvUQBXc=;
        b=gliBOS/1/vdNxgFn7xA7Z4Iint83yZqOICWgKYP8CajW1+nH1PQe2PnXZ2KwAvi0K1
         5pS0UwwCQSalGSe33s14/6gcaCznPr1jS9ge2gxbpspFwHLCOY9wGD0bYZzTdrcLd+Lj
         wv5U1u2Wv92TVt72BPX3/t5713mMofaRW/BRI1luOKT3hKm+wep86xb9dsjAA5NM/FCq
         RBIO+8jM+iwUmv3d4d5Ngh7Uyygw61gIQHaxqCxfyYWtgTgk8x8GpgmcqF84yqc2+weZ
         Om7fPIFOUBrdaK9nifbEqMlqBkjPBQh0jezK2ixg7naLk/ES6Js396FX9kHTfx9XS7xi
         Bgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208716; x=1742813516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX4+nDjPa97pvqp6xc2jGfEChrIN3m+xL1+vCvUQBXc=;
        b=vXQUor7+R9kLLg2oqsvGe5IhVFPFdApDlPW8Czl0WpMQbMYj7Acz82+WzgUAMwT4Hx
         HpIwQVvFq7E+3tbtAzOhLU2N4sH2c5hTFcqvKEkuqWclAfp8ITKDAsVtwQQV72BZwXAV
         r1JGfPUY3JGonwIeye2rP9G4k0FthN8/sYh2ABmDDtOlzvSTgzQlOHEunVjH+N/jug58
         bpMCn8PAAVxX+8G0xloa+P6haiF//0jCLZsCOehngRCytJa8cdI2SvtpXOSRHBFPwCdb
         pEXbKh6SGEAG3IEgpdHd6wp1mw35Aj/SR1DRXuj8g9qfdL66ATo5hw6pqu8EMpKAycV0
         cmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHydLE6fWPaDmQ8fYfiUmXifi4xOU0Gwerbq3A1IQHt/zDF56zWxxBR/AAPCRk0KNbpOkxeRu8hl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAsq0fhRM0JAW5IwYKZieu4NdQmYDS38qWx4ZxkV+luIHBzqs
	0WFZdhuaVhodYsgfYyQhUyZJ2doZN89YkPkJ6NWVkZQBbf8kfzpO1q2RX+X6fCL576sN5BOuZ78
	vQE1rHVv1BoPW/o5h0vNzK4h5yZTimj+naXneeg==
X-Gm-Gg: ASbGncsqHdyrTFmCKS0znRyCbd5dgmTx7XwR/68vFO0+hWgAZdDQB9bv5cy02Ubv1op
	B0fr16GUY+dua0kK6/AYqloxT8u1hn+smM7z+AbaTMdlO3ypg6xKaoEER90wEFh+sCuPVsKNpwJ
	KCy5aDcB59AFyNNXuUkwVCZZfuzIM=
X-Google-Smtp-Source: AGHT+IFZ/UCb9MAufxXsxDOXjmjeGY1kTReIoU2wd9M3G+bvTRZCBrdHJdToart9NFB/Ee7YBzyERYwjT+84mB4ubDo=
X-Received: by 2002:a05:690c:48c4:b0:6f5:4304:fb8 with SMTP id
 00721157ae682-6ff45ef2016mr162355087b3.18.1742208715994; Mon, 17 Mar 2025
 03:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311165946.28190-1-kamal.dasu@broadcom.com>
In-Reply-To: <20250311165946.28190-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:51:20 +0100
X-Gm-Features: AQ5f1Jr1xpf9ZmYsy9fSxESDDI1HTBIwGCZnYOTiOa6oMo4jyXPgFf1L5kdmj9g
Message-ID: <CAPDyKFoDh-9L49Yh+Xv10t9Dt_Vyvn7dGCb5dKV0RiNJi5aoZg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 17:59, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> cqhci timeouts observed on brcmstb platforms during suspend:
>   ...
>   [  164.832853] mmc0: cqhci: timeout for tag 18
>   ...
>
> Adding cqhci_suspend()/resume() calls to disable cqe
> in sdhci_brcmstb_suspend()/resume() respectively to fix
> CQE timeouts seen on PM suspend.
>
> Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 0ef4d578ade8..48cdcba0f39c 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
>
>         clk_disable_unprepare(priv->base_clk);
> +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +               ret = cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return sdhci_pltfm_suspend(dev);
>  }
>
> @@ -529,6 +536,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
>                         ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>         }
>
> +       if (host->mmc->caps2 & MMC_CAP2_CQE)
> +               ret = cqhci_resume(host->mmc);
> +
>         return ret;
>  }
>  #endif
> --
> 2.17.1
>
