Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AC3090E8
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376948; cv=none; b=izQwMdu3nEDt41Hj1X+WNcCaR027c+VDysuh35dpcVGoBckwSgaSmNcDCGWOn6yogRnvVkyUbPFb46rbxl7kHEKVba6qBdPMBwIR6gE3kE67bHXHnTs74lFBx6NKBbHEGkTqyvEqtZl9HXsqULrgzk+wqngzqBJ4EmsWKsOlFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376948; c=relaxed/simple;
	bh=66pVVMD+SvanDW+g9S1kFS2dmB57MEXPZN1tJbMMoNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHZ+kTK1ju7fHinlXMqiz6f+4B9VNGOrbe05ptk5R372wnpq9UTvgW23IuZsGHtPhQdxXTJd4lsHpppIFya4IypEL1UUMmWxvfxPjKUpY2GuruwsqXabBO1b7xYVbHR+oxQsPwaPKiK4tzVN+Y0XoL/7TTXilp5P8Juc+lmD/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzAa6kXF; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzAa6kXF"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640e065991dso3583279d50.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763376945; x=1763981745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SNi3DUuC4kiwYXI9QG3IaD4ATG29kHjGAl09AB3jH7s=;
        b=fzAa6kXFGvLikESmKwUBUqVrZKTcn8yWwidMiJcWepxIZCmfKSQhFkoGhCV8JLCHDx
         N3e5SIcPxdkV1Xi61ntOR9v8iYzUPZW+fA9NGJsNJG0j06z3r+UwQKSIvLpwZeYc4gJp
         rgDWwGF7awEm+0P6x30L88o9yTYmV2RoO1q4YbowDrt7rk90YpKnmUVRI9oVdTfwAITW
         IIznHz1YlxO6Xlmhq8AXUu7364G8xv0wbZGzOq9t2Rz2xY+Pf9UNBpMvHEJeiRRkvddg
         bdNU+dR4pJHrgyhoQB9iJHGVtLUdxxS8p8kGG+ahYmpPDYvoKgWQfklV9AioKgA2Y16e
         hTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763376945; x=1763981745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNi3DUuC4kiwYXI9QG3IaD4ATG29kHjGAl09AB3jH7s=;
        b=gzH5/PLqWHgGtpGypJptDA8Ou0tnuhQV5j9Mag+uixjneNqlGlhKJ2Pmtt+6NIx1qW
         tPlUYAl3wKBAgr7cxrFuOWZ+ILCAv2SOt2z7Gp+z+ZEzgamp4OwbpYeli2SsRynfSehx
         uHgLylkoWVaOv0YCEmWYGpfyeCgy9LnrHDkQbxjTLGaDRDBsCwvynkYHZRwyqHckMNTM
         s6zHRS1k8t21zxeqj1/8Ci7gg39I6VIamOr7XuiSXucTguKuKmcBdT2yPYCh3joHk8i3
         kNkkPV1/Osa0oBm3UbrnpB/2BiM9HmGkAH0gFyfmzyOke+2A8q3i9X0BA2HYZpPf0D27
         cCiw==
X-Forwarded-Encrypted: i=1; AJvYcCWTHfVaqmkqYDsv6Yc2695/nSbE3VlqO/KXA3Mb8eamIKBZpLL2GFkBOvlUBVncTE+h3auUNEJW8j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAa4g6R6g6fbF+5byzOa6MWwgKKjEJtItqttqvGE/Lo/jqaSzA
	XYzy1eaPiery5FC8fI3Fv2FBQM02aeWNuFO9jyOai3qAQ/i3qnEgAWftrAEv+YLWEH84n1wqrYI
	nk1je8Ojk4fx1ACuM4oDs2Dram2ELse88hMvYVjCVSA==
X-Gm-Gg: ASbGncu3KlOui+J+lIm8LE69L1HtCbtIxDe9eE2nMWpEi/XzrTJj2Sn++0U/i0OHUdI
	I/Rs7rSUkBLpGvIL0GEdSmRIU11A6V4gnBcjNL6MT6EW+OptgIBxDM8pVgjT//wJwQ43YAR/++o
	Q+Sy3yCXDTXoMhqqsEPbLm0w9Cmvajjj11Alpz7eANBfbHoNdtZva77tykOG/SG+EryWN73KWtd
	ThDVBNoFHLWHAKixuvmr7791DrVB6ZGIBlW/0NZvxsOBUPaIjECELxk3VF8bWAuyKVpqK8h
X-Google-Smtp-Source: AGHT+IHSWyBYv/fC9dZTTDOgWOaxaIvPb0/rfvyppfwI0C8aVnJNUBzDoSM8mut90PnbknCQbBjd24ydW1RF2z34MJw=
X-Received: by 2002:a05:690e:23c3:b0:640:caa5:57b2 with SMTP id
 956f58d0204a3-641e76a3c38mr7459702d50.44.1763376945205; Mon, 17 Nov 2025
 02:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114082824.3825501-1-sarthak.garg@oss.qualcomm.com>
In-Reply-To: <20251114082824.3825501-1-sarthak.garg@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Nov 2025 11:55:07 +0100
X-Gm-Features: AWmQ_bkD_4W_7qzohW4osy5X31ib5ETai0yHEpXe6geNQnjx-rPhkUSP9My8SYQ
Message-ID: <CAPDyKFqssyDuyRFxRUurudWLYGiZ1AXTWV6isyYc8Wz0NLriWw@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-msm: Avoid early clock doubling during
 HS400 transition
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 09:28, Sarthak Garg
<sarthak.garg@oss.qualcomm.com> wrote:
>
> According to the hardware programming guide, the clock frequency must
> remain below 52MHz during the transition to HS400 mode.
>
> However,in the current implementation, the timing is set to HS400 (a
> DDR mode) before adjusting the clock. This causes the clock to double
> prematurely to 104MHz during the transition phase, violating the
> specification and potentially resulting in CRC errors or CMD timeouts.
>
> This change ensures that clock doubling is avoided during intermediate
> transitions and is applied only when the card requires a 200MHz clock
> for HS400 operation.
>
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>

It sounds to me that we should add a fixes/stable tag for this, right?

Kind regards
Uffe

> ---
>  Changes from v1:
>  As per Bjorn Andersson's comment :
>  - Pass "timing" as an argument to msm_set_clock_rate_for_bus_mode(), and
>  then pass host, clock, and timing to msm_get_clock_mult_for_bus_mode() to
>  align with the original intent of the prototype.
> ---
>  drivers/mmc/host/sdhci-msm.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4e5edbf2fc9b..3b85233131b3 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -344,41 +344,43 @@ static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
>         writel_relaxed(val, host->ioaddr + offset);
>  }
>
> -static unsigned int msm_get_clock_mult_for_bus_mode(struct sdhci_host *host)
> +static unsigned int msm_get_clock_mult_for_bus_mode(struct sdhci_host *host,
> +                                                   unsigned int clock,
> +                                                   unsigned int timing)
>  {
> -       struct mmc_ios ios = host->mmc->ios;
>         /*
>          * The SDHC requires internal clock frequency to be double the
>          * actual clock that will be set for DDR mode. The controller
>          * uses the faster clock(100/400MHz) for some of its parts and
>          * send the actual required clock (50/200MHz) to the card.
>          */
> -       if (ios.timing == MMC_TIMING_UHS_DDR50 ||
> -           ios.timing == MMC_TIMING_MMC_DDR52 ||
> -           ios.timing == MMC_TIMING_MMC_HS400 ||
> +       if (timing == MMC_TIMING_UHS_DDR50 ||
> +           timing == MMC_TIMING_MMC_DDR52 ||
> +           (timing == MMC_TIMING_MMC_HS400 &&
> +           clock == MMC_HS200_MAX_DTR) ||
>             host->flags & SDHCI_HS400_TUNING)
>                 return 2;
>         return 1;
>  }
>
>  static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
> -                                           unsigned int clock)
> +                                           unsigned int clock,
> +                                           unsigned int timing)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> -       struct mmc_ios curr_ios = host->mmc->ios;
>         struct clk *core_clk = msm_host->bulk_clks[0].clk;
>         unsigned long achieved_rate;
>         unsigned int desired_rate;
>         unsigned int mult;
>         int rc;
>
> -       mult = msm_get_clock_mult_for_bus_mode(host);
> +       mult = msm_get_clock_mult_for_bus_mode(host, clock, timing);
>         desired_rate = clock * mult;
>         rc = dev_pm_opp_set_rate(mmc_dev(host->mmc), desired_rate);
>         if (rc) {
>                 pr_err("%s: Failed to set clock at rate %u at timing %d\n",
> -                      mmc_hostname(host->mmc), desired_rate, curr_ios.timing);
> +                      mmc_hostname(host->mmc), desired_rate, timing);
>                 return;
>         }
>
> @@ -397,7 +399,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>         msm_host->clk_rate = desired_rate;
>
>         pr_debug("%s: Setting clock at rate %lu at timing %d\n",
> -                mmc_hostname(host->mmc), achieved_rate, curr_ios.timing);
> +                mmc_hostname(host->mmc), achieved_rate, timing);
>  }
>
>  /* Platform specific tuning */
> @@ -1239,7 +1241,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          */
>         if (host->flags & SDHCI_HS400_TUNING) {
>                 sdhci_msm_hc_select_mode(host);
> -               msm_set_clock_rate_for_bus_mode(host, ios.clock);
> +               msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
>                 host->flags &= ~SDHCI_HS400_TUNING;
>         }
>
> @@ -1864,6 +1866,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       struct mmc_ios ios = host->mmc->ios;
>
>         if (!clock) {
>                 host->mmc->actual_clock = msm_host->clk_rate = 0;
> @@ -1872,7 +1875,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>
>         sdhci_msm_hc_select_mode(host);
>
> -       msm_set_clock_rate_for_bus_mode(host, clock);
> +       msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
>  out:
>         __sdhci_msm_set_clock(host, clock);
>  }
> --
> 2.34.1
>
