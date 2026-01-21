Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8933C515
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007303; cv=pass; b=B8IE14Z2RorIuTXmgnZaxZNvEsVA+IUk4OPnBa3M6Bg00h3F+0mbNBggcXB3W0UJvvFl+N/Z0mJkKNviBNUpsr2MfE0adJV73ygt/44ceGO40mEAk33ym5TtTDHP0UEzITgqBRzl0rM+5G3W26sNmPEz/aZz2QPHwnQkKGmVcYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007303; c=relaxed/simple;
	bh=yNWgMaR8oi9I8/XxPbf7ddsV49C99BlKrBmh1kPGTcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNSSaYk0LFDGPxUWTiPICKrz8eupPZl86fAP9Q2U+P0mDdiI3SakOlcHIeTo4bJCcgnuSegz4T8ynVIuzqhoEYitX/uXEa9E7LFa7SThMLJWYOlRCp0ciKulEK6FpdIkFdCDolyRelCa/5naFmKHsrA3E1+Cr5jf///FlY1AsII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgyhDwsK; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgyhDwsK"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dd263bfd3so696223e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 06:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007298; cv=none;
        d=google.com; s=arc-20240605;
        b=X7lWOSVCFM2OdrgtRhl8Ncl0/SOGdYnZtOz6pTvioVnmp6F8JKOVDr3PDpEJ8KeEvm
         epNzEAL2DAKpEqD9QCnmmELf/0K2z+Y9XsJkRDYvk5fsKmUjz96rMLxpRxWm6UrcyCrS
         75gDYTXWTz0ZKiRe6eUbGydELmErq4TQzeQDzGYk//JMzPvfSDXs5YDOka9TVMxuiHev
         3CHWqt2utkl1sm84zc9iQQWQ2b5MCZ8kwaBhfwV8j7ygKmXqDeRyNPyjpRNYHs53yvXn
         H1JdOr/DuFTr0Sl7D/5p6cQaorT1djOUC6HqWVZxS2yRt9g5mTP/dFUWlfhFkygfeCG3
         XLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A6330N1LFD4XBCM84aMPcZjMDcowYLAuIIeheUGm2Io=;
        fh=JU2FAnWJdwpdWvQ7vIPEiwtmuaqVEBrNT9yuglPf2VA=;
        b=Jv48n2gB13S+21DgjUG7evrTwWn+RZj5jtVh1oEF33v2f4TOeTauIrgII+NxxUUb2l
         /sUo/L3B4XNOFhObdPRDxHWCi6A8vuUN+KxeM6eM/DQeuxMwOM0KlU2n0MPC3d2n+9gR
         WhKhDQ2lAxQLubsPnvGxntaI7v95L1AU+88zfe6esnNR3s6DhoUbBB6vcqZeqzMoZThc
         fdc5lXBp3IfQ+r3olVpERwtwRzK1TT07LvI1VX4EnjthDirpIknysHczmwHB+Ndo2Jbt
         3RPLyZt1kITXCW2JFRud7jLRyOBzKlj3mY5XMlyzofhqqkY+IoHTdUHr97NFdA7YW6rL
         fkOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769007298; x=1769612098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6330N1LFD4XBCM84aMPcZjMDcowYLAuIIeheUGm2Io=;
        b=FgyhDwsKgrrP5UmJqvirWQO/uKCkovlWtQ1Ss3voJ7tCvyUwrJHN0cQ87A1CVAMWf+
         shmTaO1DZkFfMCypdFYkwyQB3RIHC8NmvXw9FGzYxYdjVWKaBBYquhJgAUIGCk7kXCJ5
         0ZJll1oHKLld5ZBCAqrVF1AZRpStFmF+qXjpWPMZo1HfZXRMWmAeildShh83C3HQQWBQ
         VYXuOss8OYJvbi/4QHkJj1+RVzzVjd56/QSyaFx2tOvJWbdI/YMOg80PnemYh46Dtuij
         XOagpTBq/F1NOleyP4E0fI/JG8SOydwb0raWTqvO8ePomV1C/8n+UJGW4CpVhDa5O5rG
         rueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007298; x=1769612098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6330N1LFD4XBCM84aMPcZjMDcowYLAuIIeheUGm2Io=;
        b=n2TbUlox4bfcBqv2HrOeVCjC9Vyhmo0UKP4X2s4pdix0vS3HVyF3687vd5Ket0QS+P
         VOu+dFfiKcPJFBfU4Fva+tuWtz9cWxKOQqomr1J8ZFrLMrOi23qOpYLNY6wqvnL+722D
         B47wsgkNPX6Q88aFKW7+Epx/aA+TJCzyj4dTPcZAQ2NK68HU9WzWCwOzZRAozcqk9R0J
         IYX0o9XTnpbMfBIVcIJLf4/XFltIBYq+gdNCXcxv+13lRGZnauwabxk82AfZ7X5dPw7F
         NQy1A8kQmOwovd+xyX+ohIhVbiNuykovpgltK2JCESoHA5yymwn0YoNA029/zKWphTi/
         FSfg==
X-Forwarded-Encrypted: i=1; AJvYcCXStgRhJfaNnHApl1W9QwnucmHJMReJQBaDACcY33SSj0w3Hh4ohuL8Oaw9NRzgDgADJyEu9K9cJj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40KIsxKR5VzM7Wu1lNqFE1RdfWwkgMOw/52phMyEdUu1vDiiF
	pPZcWdAsi91QKfra++P96LC6Lbhn4icKqqFU0RV4jgXpgEGfUqDiMP7MhVSnAdRDNOEvg/ORDZk
	uef6K/2mZnD/05+cjnJge97INZbMiu8ggD0lIVSKKsw==
X-Gm-Gg: AZuq6aKm0Aa/pcmolr9sRoKFndh9GI4N6G7FA7+/IAVFBAN31BFYpPm+WN4R/sHl4rz
	TuiuWqzQPTpr+CXuCp2c55kh4RygLTH4zNWEDbgk2B9LOh00s4wE3L3bI4Wq6rhkD0eUYfKL6LL
	xJpwztjHWCyO9D1eZHD9jvCQSg5cOigYfBnhZMbTW6wlUoFw+Gg7oYasAKpn6PBKcxYSX51w2/C
	80jVBaOL8JtFA1boxKcL18TzEGo5tXuE0YD3SACW9iGQ6SbuXXV9DTqYgibf87vxTO3R+bL
X-Received: by 2002:a05:6512:3b07:b0:59b:b3e3:c7fb with SMTP id
 2adb3069b0e04-59bb3e3c825mr5593429e87.9.1769007298426; Wed, 21 Jan 2026
 06:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com> <1768524932-163929-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1768524932-163929-4-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 15:54:21 +0100
X-Gm-Features: AZwV_QhAFWP6FlwdmN7VDr70aTTu8jbqo16cWKBC4DG2eUryPHPCQFlBbqWCxU4
Message-ID: <CAPDyKFqbv0Vrb8a2bHN8gAdY7iEh_Sx8iWF7VWiQ71rjbWGBsg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] mmc: dw_mmc-rockchip: Fix runtime PM support for
 internal phase support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	FUKAUMI Naoki <naoki@radxa.com>, Marco Schirrmeister <mschirrmeister@gmail.com>, 
	John Clark <inindev@gmail.com>, Tianling Shen <cnsztl@gmail.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 at 01:56, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> RK3576 is the first platform to introduce internal phase support, and
> subsequent platforms are expected to adopt a similar design. In this
> architecture, runtime suspend powers off the attached power domain, which
> resets registers, including vendor-specific ones such as SDMMC_TIMING_CON0,
> SDMMC_TIMING_CON1, and SDMMC_MISC_CON. These registers must be saved and
> restored, a requirement that falls outside the scope of the dw_mmc core.
>
> Fixes: 59903441f5e4 ("mmc: dw_mmc-rockchip: Add internal phase support")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>

Following Heiko's approach, applied for next and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 879188f..2fe0896 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -36,6 +36,8 @@ struct dw_mci_rockchip_priv_data {
>         int                     default_sample_phase;
>         int                     num_phases;
>         bool                    internal_phase;
> +       int                     sample_phase;
> +       int                     drv_phase;
>  };
>
>  /*
> @@ -573,9 +575,43 @@ static void dw_mci_rockchip_remove(struct platform_device *pdev)
>         dw_mci_pltfm_remove(pdev);
>  }
>
> +static int dw_mci_rockchip_runtime_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct dw_mci *host = platform_get_drvdata(pdev);
> +       struct dw_mci_rockchip_priv_data *priv = host->priv;
> +
> +       if (priv->internal_phase) {
> +               priv->sample_phase = rockchip_mmc_get_phase(host, true);
> +               priv->drv_phase = rockchip_mmc_get_phase(host, false);
> +       }
> +
> +       return dw_mci_runtime_suspend(dev);
> +}
> +
> +static int dw_mci_rockchip_runtime_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct dw_mci *host = platform_get_drvdata(pdev);
> +       struct dw_mci_rockchip_priv_data *priv = host->priv;
> +       int ret;
> +
> +       ret = dw_mci_runtime_resume(dev);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->internal_phase) {
> +               rockchip_mmc_set_phase(host, true, priv->sample_phase);
> +               rockchip_mmc_set_phase(host, false, priv->drv_phase);
> +               mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
> +       }
> +
> +       return ret;
> +}
> +
>  static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
>         SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> -       RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
> +       RUNTIME_PM_OPS(dw_mci_rockchip_runtime_suspend, dw_mci_rockchip_runtime_resume, NULL)
>  };
>
>  static struct platform_driver dw_mci_rockchip_pltfm_driver = {
> --
> 2.7.4
>
