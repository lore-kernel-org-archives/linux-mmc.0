Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCE60264
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055449; cv=none; b=szkLAHC8mXDc/lbjGTyb23rTZqTsebMMQjkZEdiHxWAIsrq5GwUJmRLqH+R+5DGa6LKh0H4M7hab19JdwM+kNEZFyAu0ikD485oK0JIRFAt/iaQDnmzg0a+I/ltC1RDqfL1B+wiNOVNcE3NSnA+n6JX1tUmdJg7b2q0uioqKlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055449; c=relaxed/simple;
	bh=gHoQ75tEUAz18cE3RDp8ANaC4trYaLf9aPqTwKkmiAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKpwmLvQamm1gk+oKqJ1N82NBV/ALDKCfBtGyG8jYzejnOAo8/yi9AHSOlLECo2pWCLMIwiKmYj9AoP6OO/Md/gEaLlq8H3+s+uhQSBv24pKNjqe3oB/vJpRB5s2CDRepdvoWsNfdIuE88uTNleMAib9JCJvZyGR+QxC7NxXUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uN8gWhGQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN8gWhGQ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6114c9b4d83so35940007b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055446; x=1712660246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XfVFqQzepl7vYyy7rpSXU5+T0Oy+bjYY8KU84lsoLRM=;
        b=uN8gWhGQDD1+BrLRRwKbbJgHbBSL1HF2pkAy/J9fDTvZTmrvzGnWiyq3xLvnDhYCEH
         eoG4o8XnYOeuWm4yf7DUMpVnfnfmLGpfDd85e7O1cOOZi9uBJIgjRheVl/gNh/y2aijm
         jXQFLB7S44yRFpTDLRGb+acbGDE0Wv8NVa4wz3GDTuduGxFhCpvd/IXAWMsH7PTtC0xN
         f+wemtwgPuPnjdAAvM/5w2wpxDM0icV6wQEMCwbQoeAY3JP/1HN712QsaerAbrDshBrG
         kE+qBgKHaI2PRiICW2MYv+NGUp8WO8hn+eMs2IWlOfdNANXrPNqb3E720WcQIkKvNQ8n
         tksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055446; x=1712660246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfVFqQzepl7vYyy7rpSXU5+T0Oy+bjYY8KU84lsoLRM=;
        b=r2R66SYV7mGThsL7Sp5MLGIbfbL0WlETzDoRttIaW52DgBpRwdKJpcxIIXjmM3ZJkI
         noFFo26oEfvXPgvE1+OPTn893L19W1sAMD5ceFXqHmnVnt+G41AiFldEA846DKh6lecC
         q1jF1fxgB175dBthGk4cwkldOOhkw3u0ByFbj+XfvIn6Xi7MNPvKPPQK3QrhD5lwnPaW
         v1TQcau+9TGNUO6fwUMNEXImUXsQ9LrnxEo+9Ftn0SCc9f+C+R899cZqTsOu2rRe8+Dy
         ob051XZJtQ0PikXJytpZ6LV/w1rHaZ6KZlYw8RJjXrnvr7AloRiyBzuQVi7cKUJMqCAi
         6GFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8H8H2QXdSr5M7q8dZ5ImrUV+efwaY+mvwejDiGI90I7NpyYfirXrOsgbj4Ut5Bj3sQ1fIz7Jq3+4EVwiehJaJ5pi71DLlP2i8
X-Gm-Message-State: AOJu0Yz+FOfsPcHYSO3xPKeggVYMrbk5IoCd1o3x0pjzTUoNi2WjxnMe
	wkhKRRReUd4XSv5RCL4jcVMu2Ey3Jw4CDn86/Vo9dMfrwmgQTKmIOANYg0CEuowPTfDRFeGUKNg
	MitMkVWXfApD4Gw+XfgdsXCkqIBiU56Q6HlwGzmE+Na6OKS2s
X-Google-Smtp-Source: AGHT+IGP7iUCApaJupZ/6tv2Cd+/6crilNBS2gk2mIyPFktAa2R/WouGuZYxpTCouNCX8VebVPyVaFD3DJ7kwBsggxM=
X-Received: by 2002:a05:690c:4482:b0:615:1294:d6b0 with SMTP id
 gr2-20020a05690c448200b006151294d6b0mr3017897ywb.25.1712055446400; Tue, 02
 Apr 2024 03:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
In-Reply-To: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:56:50 +0200
Message-ID: <CAPDyKFqJ8yVMvOai2BkqRETy+QOOoFOu-XkrdPcJM17_UixQwA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: pervent access to suspended controller
To: Mantas Pucka <mantas@8devices.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ritesh Harjani <riteshh@codeaurora.org>, 
	Georgi Djakov <djakov@kernel.org>, Pramod Gurav <pramod.gurav@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 15:30, Mantas Pucka <mantas@8devices.com> wrote:
>
> Generic sdhci code registers LED device and uses host->runtime_suspended
> flag to protect access to it. The sdhci-msm driver doesn't set this flag,
> which causes a crash when LED is accessed while controller is runtime
> suspended. Fix this by setting the flag correctly.
>
> Cc: stable@vger.kernel.org
> Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
> Signed-off-by: Mantas Pucka <mantas@8devices.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 668e0aceeeba..e113b99a3eab 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2694,6 +2694,11 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       host->runtime_suspended = true;
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         /* Drop the performance vote */
>         dev_pm_opp_set_rate(dev, 0);
> @@ -2708,6 +2713,7 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       unsigned long flags;
>         int ret;
>
>         ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> @@ -2726,7 +2732,15 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>
>         dev_pm_opp_set_rate(dev, msm_host->clk_rate);
>
> -       return sdhci_msm_ice_resume(msm_host);
> +       ret = sdhci_msm_ice_resume(msm_host);
> +       if (ret)
> +               return ret;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       host->runtime_suspended = false;
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       return ret;
>  }
>
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
>
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240321-sdhci-mmc-suspend-34f4af1d0286
>
> Best regards,
> --
> Mantas Pucka <mantas@8devices.com>
>
