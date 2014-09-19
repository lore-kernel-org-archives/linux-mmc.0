From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/7] mmc: sdhci-esdhc-imx: add imx6sx support
Date: Fri, 19 Sep 2014 19:54:41 +0200
Message-ID: <CAPDyKFqBTARHoXskmwkkWqMWytNAohcQksUygz1g8Aky45j=DA@mail.gmail.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
	<1409745903-26550-7-git-send-email-b29396@freescale.com>
	<CAPDyKFo5TfuQyb-ECDR+uzCfwio3guY+7LPxHzHXLNBacMbW_A@mail.gmail.com>
	<20140918053457.GA15363@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:57929 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771AbaISRym (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Sep 2014 13:54:42 -0400
Received: by mail-qa0-f41.google.com with SMTP id f12so2973246qad.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 Sep 2014 10:54:42 -0700 (PDT)
In-Reply-To: <20140918053457.GA15363@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 18 September 2014 07:35, Dong Aisheng <b29396@freescale.com> wrote:
> On Thu, Sep 18, 2014 at 12:29:52AM +0200, Ulf Hansson wrote:
>> On 3 September 2014 14:05, Dong Aisheng <b29396@freescale.com> wrote:
>> > The imx6sx usdhc is derived from imx6sl, the difference is minor.
>> > imx6sx have the errata ESDHC_FLAG_ERR004536 fixed.
>> > So introduce a new compatible string for imx6sx to distinguish them.
>> >
>> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
>>
>> Hi Dong,
>>
>> This one has checkpatch errors due to missing DT documentation.
>>
>
> The original binding doc is writing in the format of:
>  Required properties:
> -- compatible : Should be "fsl,<chip>-esdhc"
> It just provides a rule and does not provide the specific compatible string.
> So i did not update the doc before.
>
> But i think it's better to fix it to avoid future warning again.
>
> Can you help add below patch before this commit or do you need me
> to resend the patch series again with this patch added?

Please make resend, that's easier for me to handle.

Kind regards
Uffe

>
> From 467b84e5ffcba543b9ac88913b1d2dc1159dfa72 Mon Sep 17 00:00:00 2001
> From: Dong Aisheng <b29396@freescale.com>
> Date: Thu, 18 Sep 2014 13:11:03 +0800
> Subject: [PATCH 6/8] mmc: sdhci-esdhc-imx: using specific compatible string
>  in binding doc
>
> Using specific compatible string in binding doc to make the binding
> more clear.
> It's also used to avoid checkpatch warning in the future like follows:
> 0005-mmc-sdhci-do-not-enable-card-cd-wakeup-for-gpio-case.patch has no obvious style problems and is ready for submission.
> WARNING: DT compatible string "fsl,imx6sx-usdhc" appears un-documented -- check ./Documentation/devicetree/bindings/
> +       { .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
>
> total: 0 errors, 1 warnings, 18 lines checked
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 9046ba06..c415d34 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -7,7 +7,14 @@ This file documents differences between the core properties described
>  by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
>
>  Required properties:
> -- compatible : Should be "fsl,<chip>-esdhc"
> +- compatible : Should be "fsl,<chip>-esdhc", the supported chips include
> +              "fsl,imx25-esdhc"
> +              "fsl,imx35-esdhc"
> +              "fsl,imx51-esdhc"
> +              "fsl,imx53-esdhc"
> +              "fsl,imx6q-usdhc"
> +              "fsl,imx6sl-usdhc"
> +              "fsl,imx6sx-usdhc"
>
>  Optional properties:
>  - fsl,cd-controller : Indicate to use controller internal card detection
> --
> 1.7.8
>
> Regards
> Dong Aisheng
>
>> Kind regards
>> Uffe
>>
>> > ---
>> >  drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
>> >  1 files changed, 6 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > index dc0e384..87179c4 100644
>> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > @@ -150,6 +150,11 @@ static struct esdhc_soc_data usdhc_imx6sl_data = {
>> >                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
>> >  };
>> >
>> > +static struct esdhc_soc_data usdhc_imx6sx_data = {
>> > +       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>> > +                       | ESDHC_FLAG_HAVE_CAP1,
>> > +};
>> > +
>> >  struct pltfm_imx_data {
>> >         u32 scratchpad;
>> >         struct pinctrl *pinctrl;
>> > @@ -190,6 +195,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>> >         { .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
>> >         { .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
>> >         { .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
>> > +       { .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
>> >         { .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
>> >         { .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
>> >         { /* sentinel */ }
>> > --
>> > 1.7.8
>> >
