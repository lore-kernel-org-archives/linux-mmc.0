Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01DBC3F2D1
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A9B24658
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+dHif6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgCDPfH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:35:07 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45247 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbgCDPfG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:35:06 -0500
Received: by mail-vs1-f65.google.com with SMTP id m4so1396075vsa.12
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onLoHv5Ms+4AzZ821JcEV0O5UG1JPs1cK0tJlERjAAQ=;
        b=m+dHif6cWAhNpvfUPUtJ8bg8npAAbe3Y0SdBgPuCLrgKAty+3VDSzuayGtPAFXEh96
         d3A5tIF0NrKJfs/U/Yddw2wk3lDqzH+XizvOSbFCw1507ROYd/8Z7wl7kc9tlpcdLJZB
         8qFWvI7ZzsYxIAS0lC+tb0tLpN5Rfg1IoYOPX++hcJvuQtF1T/WvNJAm0lQ7pfQD+VM0
         sVDJjrng7+HT0qlSMY1Fn7gwGOhDhmBqR9qtuPQMfrxa6OpGijM14phfR4VfXVGrkGfC
         gFGo7DPU0rCtPBQ/qLfSFpnjzrn0/KtH7VJywaWSKnxNhxOczJOW3mZLOlhSKG88bosh
         DdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onLoHv5Ms+4AzZ821JcEV0O5UG1JPs1cK0tJlERjAAQ=;
        b=kX1YLu2zX5Gf2hymyaYjOoqTVK5cMfRMeDb/GcZhzCKS3rQtTpzCqrTvUOkDM209Ak
         49RzcU6cwjfnvMO+dFBYypFmBcQjUtZKxvOOG2YgFQVN1Mo7Fr9E7kwIOXIEGAaqfvyP
         dtGJaDEb8EGajVVj2rxlixhFRybsvdyHnfErwsQVgLjBf9SIFwyZd7CtTsRiUwBe9GuE
         +9PSqKnSZV7kzzNtja4wiH26lMtoD6Ogn1SZ/h/BXnlUi1VTU+Hg2I2OLBM1w6fryJov
         ndkMljc0c8mhd5xDj0XSnbA1K7Z5TWLbp7xyGjSwlLWBdHLKmy5f+axReaT8pNIheGAx
         gBfw==
X-Gm-Message-State: ANhLgQ1phjM1x0NtOOE4vPfix6clkon8cbFSuPdJzVdbCmqiqvWhpz91
        wdTlG0Knk9Bv0kUMjJZMEBIBBsgsUej9AhV+IQNH3E8W
X-Google-Smtp-Source: ADFU+vtETTmLUCopUJ0sb9jdFffuDWlaNhSB3DL9zpUBToCJK3mx9X4u/fBMgACCt37teT7kHgPNKAJFxU+nOCWg3s0=
X-Received: by 2002:a67:800e:: with SMTP id b14mr2057435vsd.191.1583336105439;
 Wed, 04 Mar 2020 07:35:05 -0800 (PST)
MIME-Version: 1.0
References: <1582181100-29914-1-git-send-email-sbhanu@codeaurora.org>
In-Reply-To: <1582181100-29914-1-git-send-email-sbhanu@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:29 +0100
Message-ID: <CAPDyKFqSJ4h7UvQfQzWmSq9gg97A0MXvdcuXXaY7b-YUHs=V2g@mail.gmail.com>
Subject: Re: [PATCH V4] mmc: sdhci-msm: Update system suspend/resume callbacks
 of sdhci-msm platform driver
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Feb 2020 at 07:45, Shaik Sajida Bhanu <sbhanu@codeaurora.org> wrote:
>
> The existing suspend/resume callbacks of sdhci-msm driver are just
> gating/un-gating the clocks. During suspend cycle more can be done
> like disabling controller, disabling card detection, enabling wake-up events.
>
> So updating the system pm callbacks for performing these extra
> actions besides controlling the clocks.
>
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes since V3:
>     Invoking sdhci & cqhci resume if sdhci_host_suspend fails.
>     Removed condition check before invoking cqhci_resume since its a dummy function.
>
> Changes since V2:
>     Removed disabling/enabling pwr-irq from system pm ops.
>
> Changes since V1:
>     Invoking pm_runtime_force_suspend/resume instead of
>     sdhci_msm_runtime_suepend/resume.
> ---
>  drivers/mmc/host/sdhci-msm.c | 47 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3955fa5d..3559b50 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2159,9 +2159,52 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> +static int sdhci_msm_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       int ret;
> +
> +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +               ret = cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = sdhci_suspend_host(host);
> +       if (ret)
> +               goto resume_cqhci;

sdhci_suspend_host() can't be called on a device that has been runtime
suspended, as that would lead to accessing device registers when
clocks/PM domains are gated.

Depending on how the corresponding cqhci device is managed from a
runtime PM point of view, it could also be problematic to call
cqhci_suspend().

> +
> +       ret = pm_runtime_force_suspend(dev);

It looks to me that perhaps you could make use of solely
pm_runtime_force_suspend(), then just skip calling
sdhci_suspend|resume_host() altogether. Do you think that could work?

And vice versa for sdhci_msm_resume(), of course.

> +       if (!ret)
> +               return ret;
> +
> +       sdhci_resume_host(host);
> +
> +resume_cqhci:
> +       cqhci_resume(host->mmc);
> +       return ret;
> +}
> +
> +static int sdhci_msm_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdhci_resume_host(host);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cqhci_resume(host->mmc);
> +       return ret;
> +}
> +
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend,
> +                               sdhci_msm_resume)
>         SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend,
>                            sdhci_msm_runtime_resume,
>                            NULL)
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Kind regards
Uffe
