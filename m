Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD407274FFA
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657933; cv=none; b=Hk92o0CYZwxAQIlCh/WiR6PyGX0rOArmvEVszMLQFrBNs7wjuKpsIZ18/Gx1GzLJLQfP43Se/xKfjpjMt7bgFnGm7+VDLE4eKGrekNqXxB/7MgQZLHu0dlYuHORdNJPvxvsGnrb8mqCW8O+ylw7B4d/Dt32EPmEDQaKsXDYV7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657933; c=relaxed/simple;
	bh=HOodb27u5TwtTAPSsy92wrZWNxC37y9Hm9lyvRSe3Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhqqjGfWluvjYoGhjxFneSEzpLx7YdE12+BX0+KelZggUB+WSX1rkTbAB7YxlY42eCJTqoD9HHeR9y5DxrNgd2J/YjYeuhkeSV/gmTMhxBUQJWHure6bC9SUnYYzcoDo7cSnvfR4dTUK1NcUieMR6wNKwVHKNjvIMxdOZzrs89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgLyFcFM; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgLyFcFM"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7b85f1cbacso1947926276.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747657931; x=1748262731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B7Zhmo/JpzcMaAMKKOwzh6ja2t6tkPpPMCDNoaM6o58=;
        b=zgLyFcFMZHKUnYWGl/QEPMah+G87E2XxjK772KjH0ygnR9PKfWIbc/OC/CIL8M593Q
         ZTLnEdc8K9sFZmfAMcpLi2U4orNwdNAv35ccx7H+BY6eCDea60vyl2c+W/vmMWaEgo/1
         lICUVV4iLsKo8LUKRW45kc8PSYkfHztEjLl7zZ4v9odKEjRt5TnVb5dxvVa4CeDZ6aPt
         jQMU7pAMmNQ4WBMqMxwFqrDHxA2tsY9qDSC8O0KCxJlvBnVyyhH3BGj8Gni0F6VWF5dw
         Zz9GQ/rIOM4MRdMHBlBA0wgvbr0DlOMahLyiqIKzzzepICS+hX6v9jn8hnOPMmS/cbZD
         T00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657931; x=1748262731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7Zhmo/JpzcMaAMKKOwzh6ja2t6tkPpPMCDNoaM6o58=;
        b=libP7HMCl4y1gRTYzr93hPHK3FHPI6GJW8kb/okzTkheJZv6jTh2Hn322PPvZNuXNI
         g/LJSEt3uhk9me/YywV+NFd0k9ZmUjLiOawcDSY6jvhH6sndwjvyGjfSGtEd5jVuSIZx
         d/R9twa5KeR3oIJDtuiG3ldqNQBvzLYuotkCgq1JLZ/RTrmUo0qhDvMLdIN0WqeBpDsU
         EzHxPjGb9ecTWUR9y4fAkznYrtmq0edXvLosnpMVjCcgqD2sVpQPPNWEGPoKuH+mPYLN
         0su8EfD7wJIzlGR8aodyoqWpGSkUxyRg//r9bQbZjl1nvRSkDhS90yYl6kSle5AzC/JJ
         YB5w==
X-Gm-Message-State: AOJu0Yz88zAMaLyXPcIl3bTI1TUjhZPSg6rSW+tia1zKQWHPa7r3VkBV
	p3kT2aSIxcU+Jkhzs1Amuc0CJtteGUjZKjsauaj15E8aZG7EqBg3NBPlenaZxrELU7tVoe9vs+O
	c9cbE9tPXS/AVIBoFQsvjFNUMPtYEBGhkBle+Jq7/hQ==
X-Gm-Gg: ASbGncvhHF1rJ48e+LzKRKepI45l+lRlhINVQ3b2OJdhm/fc+ORZWgTHrfcFJbAAWuE
	Ifg7sQgKX9JFk9ATalf3wud0qzNavWN2vn1NgwzpBFxZANruM87lVlCXjd098tCFOwqKFDtDm5w
	x+LpwJtEreabTQLSD5sNcRfrt5dQprbdoSPA==
X-Google-Smtp-Source: AGHT+IHMRf8bcz5aIkiyV4tAaS8tGQtUKO6bhUpbLyg9woenXTM/y8WVzmZJnfWYm+84x/Es23zMYwq7B9ivClzWPz0=
X-Received: by 2002:a05:6902:1b03:b0:e7b:8524:3f5e with SMTP id
 3f1490d57ef6-e7b85243fb8mr12802970276.10.1747657930730; Mon, 19 May 2025
 05:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514094903.1771642-1-ziniu.wang_1@nxp.com>
 <20250514094903.1771642-2-ziniu.wang_1@nxp.com> <0bda0bba-cfc6-403d-b36f-9c625e5bafb2@intel.com>
In-Reply-To: <0bda0bba-cfc6-403d-b36f-9c625e5bafb2@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 14:31:34 +0200
X-Gm-Features: AX0GCFtU3S8coUHVXTKQU7bBOE0kHTmWJQ63OQyAYKI9Qe1enSPXNA1WeuzFizU
Message-ID: <CAPDyKFp+ATxghU2g1XxVLB1Oy4TkFvUqj6SpyKCV_ro9bayXtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: host: sdhci-esdhc-imx: refactor the system PM logic
To: ziniu.wang_1@nxp.com, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, haibo.chen@nxp.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 14:53, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 14/05/2025 12:49, ziniu.wang_1@nxp.com wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > Current suspend/resume logic has one issue. In suspend, will config
> > register when call sdhci_suspend_host(), but at this time, can't
> > guarantee host in runtime resume state. If not, the per clock is gate
> > off, access register will hang.
> >
> > In sdhci_esdhc_suspend/sdhci_esdhc_resume, remove sdhci_suspend_host()
> > and sdhci_resume_host(), all are handled in runtime PM callbacks except
> > the wakeup irq setting. For wakeup irq setting, use pm_runtime_get_sync()
> > in sdhci_esdhc_suspend() to make sure clock gate on.
> >
> > Remove pinctrl_pm_select_default_state() in sdhci_esdhc_resume, because
> > pm_runtime_force_resume() already config the pinctrl state according to
> > ios timing, and here config the default pinctrl state again is wrong for
> > SDIO3.0 device if it keep power in suspend.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
>
> Looks OK to me, at least, although Ulf may still have comments.
> Otherwise, for both patches:

Looks good to me too!

>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Both patches applied for next, thanks!

Kind regards
Uffe


>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 50 ++++++++++++++++++------------
> >  1 file changed, 30 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index c0160c69a027..7611682f10c3 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -2009,11 +2009,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
> >       struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> >       int ret;
> >
> > -     if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > -             ret = cqhci_suspend(host->mmc);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     /*
> > +      * Switch to runtime resume for two reasons:
> > +      * 1, there is register access (e.g., wakeup control register), so
> > +      *    need to make sure gate on ipg clock.
> > +      * 2, make sure the pm_runtime_force_resume() in sdhci_esdhc_resume() really
> > +      *    invoke its ->runtime_resume callback (needs_force_resume = 1).
> > +      */
> > +     pm_runtime_get_sync(dev);
> >
> >       if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
> >               (host->tuning_mode != SDHCI_TUNING_MODE_1)) {
> > @@ -2021,9 +2024,6 @@ static int sdhci_esdhc_suspend(struct device *dev)
> >               mmc_retune_needed(host->mmc);
> >       }
> >
> > -     if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> > -             mmc_retune_needed(host->mmc);
> > -
> >       /*
> >        * For the device need to keep power during system PM, need
> >        * to save the tuning delay value just in case the usdhc
> > @@ -2033,9 +2033,13 @@ static int sdhci_esdhc_suspend(struct device *dev)
> >           esdhc_is_usdhc(imx_data))
> >               sdhc_esdhc_tuning_save(host);
> >
> > -     ret = sdhci_suspend_host(host);
> > -     if (ret)
> > -             return ret;
> > +     if (device_may_wakeup(dev)) {
> > +             /* The irqs of imx are not shared. It is safe to disable */
> > +             disable_irq(host->irq);
> > +             ret = sdhci_enable_irq_wakeups(host);
> > +             if (!ret)
> > +                     dev_warn(dev, "Failed to enable irq wakeup\n");
> > +     }
> >
> >       ret = pinctrl_pm_select_sleep_state(dev);
> >       if (ret)
> > @@ -2043,6 +2047,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
> >
> >       ret = mmc_gpio_set_cd_wake(host->mmc, true);
> >
> > +     /*
> > +      * Make sure invoke runtime_suspend to gate off clock.
> > +      * uSDHC IP supports in-band SDIO wakeup even without clock.
> > +      */
> > +     pm_runtime_force_suspend(dev);
> > +
> >       return ret;
> >  }
> >
> > @@ -2053,16 +2063,19 @@ static int sdhci_esdhc_resume(struct device *dev)
> >       struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> >       int ret;
> >
> > -     ret = pinctrl_pm_select_default_state(dev);
> > +     pm_runtime_force_resume(dev);
> > +
> > +     ret = mmc_gpio_set_cd_wake(host->mmc, false);
> >       if (ret)
> >               return ret;
> >
> >       /* re-initialize hw state in case it's lost in low power mode */
> >       sdhci_esdhc_imx_hwinit(host);
> >
> > -     ret = sdhci_resume_host(host);
> > -     if (ret)
> > -             return ret;
> > +     if (host->irq_wake_enabled) {
> > +             sdhci_disable_irq_wakeups(host);
> > +             enable_irq(host->irq);
> > +     }
> >
> >       /*
> >        * restore the saved tuning delay value for the device which keep
> > @@ -2072,11 +2085,8 @@ static int sdhci_esdhc_resume(struct device *dev)
> >           esdhc_is_usdhc(imx_data))
> >               sdhc_esdhc_tuning_restore(host);
> >
> > -     if (host->mmc->caps2 & MMC_CAP2_CQE)
> > -             ret = cqhci_resume(host->mmc);
> > -
> > -     if (!ret)
> > -             ret = mmc_gpio_set_cd_wake(host->mmc, false);
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_put_autosuspend(dev);
> >
> >       return ret;
> >  }
>
