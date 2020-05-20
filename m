Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3868C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728A3207C4
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iY3vTkxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETL1b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgETL1b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 07:27:31 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24966C08C5C0
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:27:31 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id p5so674207vke.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bK70iXgwtoTYU2+kxEkYS2dPmfYEzUvYbO5p+9cOsao=;
        b=iY3vTkxPVUWFZAoKbgr6fycybDoVLlukU2vKTCC4y0p3egIArgw2DOi3MtEAas4jjd
         xkKVVRg/NEtDskAHckyfyT9UcFM7q072/qWRCIZ2eGkUij9SxkM37dnegWCBnlnNFokj
         a+vgg/PlOgZmGgJ0crTeiqkLATt9X3NiPgfKTRP+5MLW+IlSDtQUliwSXsrGF/voQKjh
         XltAcrvk7xvpiJjR2rvJuhIvQQHMf/+ns8PPIaUGE+IKrp46xJ2DNqjFmSzOIf69qLJr
         dDQ1fEbYOJuSIMJcPVyUMC2Ivvz6eoVcCAke+qrlSpohIhnD3bC/sshNos6p2bZdelUg
         JjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bK70iXgwtoTYU2+kxEkYS2dPmfYEzUvYbO5p+9cOsao=;
        b=YB04ATZyTV8GabG/+F1hKnutujYAdiYkpVTyd+FnY8rJMw+jTgxW5qAeyKrJPfGGbA
         hwMcKJCthJoN1IpVTxkqMqs8+J+KChVl6tml8X32gsLSO8nISQnbsW1x0hNThqJj7xaH
         lzbtylvBvotyC61A7rfT7hpxpueNTq6drxoWmXLWqEwIUUgkYWvVQoBjEzDU5zNdAVdS
         rSdHNhxQdRatbW267IL1mOoqg+Kf2eeINEE9Zo8QYILUry5fzhx2rGIwxiN3mJTbOy2k
         Oc9qfrgXDiu+8B713hOxM4BvWHv6LfNSzb3iOFoUxJvoAJO2jL0HPkaQpacMHGaGJ/Yn
         5oFg==
X-Gm-Message-State: AOAM531RlN/ph70iBHEuwdbDUTIVPo2ccQYHazMssYNam8AIOqq8b5Gd
        VUfAQvbICwFMMJawj15YCWWk5IjgfRZos1vZIEB6yQ==
X-Google-Smtp-Source: ABdhPJzhsUfJuFtIop+5Vw1e3jma114eZdMV16i3kG0IE4cNpPawoTMqme4OfpFdENFIkCzg2zpGAnz3ium8qwnA960=
X-Received: by 2002:a1f:4845:: with SMTP id v66mr3370034vka.43.1589974050027;
 Wed, 20 May 2020 04:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200516154314.14769-1-digetx@gmail.com> <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
 <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com> <20200519162444.GD2113674@ulmo>
 <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com> <11c93dac-f5ba-2193-6f44-63af27fdce09@nvidia.com>
 <aed72c87-0e16-6dea-a4e2-7fc6a97cd313@nvidia.com> <c7469c16-f6f1-f9c0-566f-3b1d3774f130@nvidia.com>
 <c712de1d-cfa4-2746-ec6b-54f318aeaac2@nvidia.com> <d2c71267-e696-c459-fbd6-dbb5fd312ed3@gmail.com>
In-Reply-To: <d2c71267-e696-c459-fbd6-dbb5fd312ed3@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 13:26:53 +0200
Message-ID: <CAPDyKFqdeGyQpXpM+xynd_rWbi0S6hCeQS1Dyiy6Hd2E_yfHpg@mail.gmail.com>
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 May 2020 at 04:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 19.05.2020 23:44, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >
> > On 5/19/20 12:07 PM, Sowjanya Komatineni wrote:
> >>
> >> On 5/19/20 11:41 AM, Sowjanya Komatineni wrote:
> >>>
> >>> On 5/19/20 11:34 AM, Sowjanya Komatineni wrote:
> >>>>
> >>>> On 5/19/20 9:33 AM, Dmitry Osipenko wrote:
> >>>>> 19.05.2020 19:24, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>> On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko wrote:
> >>>>>>> 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>>> On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com>
> >>>>>>>> wrote:
> >>>>>>>>> Several people asked me about the MMC warnings in the KMSG log =
and
> >>>>>>>>> I had to tell to ignore them because these warning are
> >>>>>>>>> irrelevant to
> >>>>>>>>> pre-Tegra210 SoCs.
> >>>>>>>> Why are the warnings irrelevant?
> >>>>>>> That's what the DT binding doc says [1].
> >>>>>>>
> >>>>>>> [1]
> >>>>>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/=
nvidia%2Ctegra20-sdhci.txt
> >>>>>>>
> >>>>>>>
> >>>>>>> Although, looking at the driver's code and TRM docs, it seems
> >>>>>>> that all
> >>>>>>> those properties are really irrelevant only to the older Terga20
> >>>>>>> SoC. So
> >>>>>>> the binding doc is a bit misleading.
> >>>>>>>
> >>>>>>> Nevertheless, the binding explicitly says that the properties are
> >>>>>>> optional, which is correct.
> >>>>>> Optional only means that drivers must not fail if these properties
> >>>>>> aren't found, it doesn't mean that the driver can't warn that they
> >>>>>> are missing.
> >>>>>>
> >>>>>> Quite possibly the only reason why they were made optional is beca=
use
> >>>>>> they weren't part of the bindings since the beginning. Anything ad=
ded
> >>>>>> to a binding after the first public release has to be optional by
> >>>>>> definition, otherwise DT ABI wouldn't be stable.
> >>>>>>
> >>>>>> I think these warnings were added on purpose, though I also see th=
at
> >>>>>> there are only values for these in device tree for Tegra186 and
> >>>>>> Tegra194
> >>>>>> but not Tegra210 where these should also be necessary.
> >>>>
> >>>> dt binding doc we have is common for MMC, SD and SDIO of all Tegras.
> >>>> Its not mandatory to have both 3v3 and 1v8 in device tree as based
> >>>> on signal mode.
> >>>>
> >>>> As these driver strengths are SoC specific, they are part of Tegra
> >>>> SoC specific device tree where same values will be applicable to all
> >>>> Tegra SoC specific platforms.
> >>>>
> >>>> Based on interface usage on platform, we use one or both of them
> >>>> like sdcard supports dual voltage and we use both 3V3 and 1V8 but if
> >>>> same interface is used for WIFI SD we use 1V8 only.
> >>>>
> >>>> So made these dt properties as optional.
> >>>>
> >>>> Other reason they are optional is, Tegra210 and prior has drive
> >>>> strength settings part of apb_misc and Tegra186 and later has driver
> >>>> strengths part of SDMMC controller. So,
> >>>>
> >>>> - Pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" for driver strengths
> >>>> are applicable for Tegra210 and prior.
> >>>> - dt properties pad-autocal-pull-up/down-offset-1v8/3v3-timeout are
> >>>> for T186 onwards for driver strengths
> >>>>
> >>>> Looks like dt binding doc need fix to clearly document these based
> >>>> on SoC or agree with Yaml we can conditionally specify pinctrl or dt
> >>>> properties based on SoC dependent.
> >>>>
> >>>>
> >>>>>> Adding Sowjanya who wrote this code. Perhaps she can clarify why t=
he
> >>>>>> warnings were added. If these values /should/ be there on a subset=
 of
> >>>>>> Tegra, then I think we should keep them, or add them again, but
> >>>>>> perhaps
> >>>>>> add a better way of identifying when they are necessary and when
> >>>>>> it is
> >>>>>> safe to work without them.
> >>>>>>
> >>>>>> That said, looking at those checks I wonder if they are perhaps ju=
st
> >>>>>> wrong. Or at the very least they seem redundant. It looks to me li=
ke
> >>>>>> they can just be:
> >>>>>>
> >>>>>>     if (tegra_host->pinctrl_state_XYZ =3D=3D NULL) {
> >>>>>>         ...
> >>>>>>     }
> >>>>>>
> >>>>>> That !IS_ERR(...) doesn't seem to do anything. But in that case, i=
t's
> >>>>>> also obvious why we're warning about them on platforms where these
> >>>>>> properties don't exist in DT.
> >>>>
> >>>> As drive strengths are through dt properties for T186 and later and
> >>>> thru pinctrl for T210 and prior, driver first checks for dt autocal
> >>>> timeout pull-up/down properties and if they are not found, it then
> >>>> checks for presence of pinctrl_state_xyx_drv only when valid
> >>>> pinctrl_state_xyz is present.
> >>>>
> >>>> Driver expects either pinctrl or dt properties and shows warning
> >>>> when neither of them are present as its mandatory to use fixed
> >>>> driver strengths when auto calibration fails.
> >>>>
> >>>>     err =3D device_property_read_u32(host->mmc->parent,
> >>>>             "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
> >>>>             &autocal->pull_down_3v3_timeout);
> >>>>     if (err) {
> >>>>         if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> >>>>             (tegra_host->pinctrl_state_3v3_drv =3D=3D NULL))
> >>>>             pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
> >>>>                 mmc_hostname(host->mmc));
> >>>>         autocal->pull_down_3v3_timeout =3D 0;
> >>>>     }
> >>>>
> >>>>>>
> >>>>>> So I think we either need to add those values where appropriate so
> >>>>>> that
> >>>>>> the warning doesn't show, or we need to narrow down where they are
> >>>>>> really needed and add a corresponding condition.
> >>>>>>
> >>>>>> But again, perhaps Sowjanya can help clarify if these really are o=
nly
> >>>>>> needed on Tegra210 and later or if these also apply to older chips=
.
> >>>>> Either way will be cleaner to convert the DT binding to YAML rather
> >>>>> than
> >>>>> clutter the driver, IMO.
> >>>>>
> >>>>
> >>>>
> >>>>
> >>> Auto calibration is present from Tegra30 onward and looking into
> >>> change where autocalibration was added to sdhci driver somehow it was
> >>> enabled only for T30/T210/T186/T194.
> >>>
> >>> tegra_sdhci_parse_pad_autocal_dt() was added when auto-calibration
> >>> was added to driver and I see this dt parse is being done
> >>> irrespective of NVQUIRK_HAS_PADCALIB quirk so even on platforms
> >>> without auto cal enabled in driver, these messages shows up.
> >>>
> >>> This should be fixed in driver to allow
> >>> tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB is
> >>> set to avoid dt parsing to happen on platforms that don't have auto
> >>> cal enabled.
> >>
> >> Warning on missing drive strengths when auto cal is enabled should be
> >> present as we should switch to fixed recommended drive strengths when
> >> auto cal fails.
> >>
> >> So probably proper fix should be
> >>
> >> - allow tegra_sdhci_parse_pad_autocal_dt() only when
> >> NVQUIRK_HAS_PADCALIB is set
> >>
> >> - current driver sets NVQUIRK_HAS_PADCALIB for T30 as well so need to
> >> add pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" to Tegra30 device tre=
e.
> > [Correction] T30 has same drive strengths to use irrespective of signal
> > voltage and it doesn't have pad control. So for T3- we can update devic=
e
> > tree to specify "default" pinctrl with drvup/dn settings.
> >>
> >> - Keep warning message of missing auto cal timeouts as its mandatory
> >> to use fixed recommended driver strengths when auto cal fails.
> >>
> > Regarding warnings, I guess simpler and easy fix is to remove warning
> > message on missing 3v3/1v8 drive strengths as pinctrl/dt properties wer=
e
> > already added for T210/186/194 where we need and old device tree don't
> > have them but the case where auto cal can fail is very rare.
> >
> > Otherwise should update driver to allow
> > tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB is se=
t
> > and also within tegra_sdhci_parse_pad_autocal_dt() show warning of
> > missing 3v3/1v8 settings only when NVQUIRK_NEEDS_PAD_CONTROL is set.
> >
> > Thierry, please suggest if you prefer to removing warnings or fix drive=
r
> > to show warning based on PADCALIB and PAD_CONTROL quirks.
>
> The SDIO PINCTRL drive-strengths are usually a part of the board's
> default PINCTRL state, which is either preset by bootloader or by
> PINCTRL driver early at a boot time.
>
> The SDIO drive-strengths values should be board-specific and not
> SoC-specific because they should depend on the electrical properties of
> the board, IIUC.
>
> If the SDIO PINCTRL states are mandatory for the SDHCI nodes in the
> device-trees, then the DT binding is wrong since it says that all
> properties are optional. But I think that the current binding is okay,
> since today SDHCI PINCTRL drive-strengths are specified implicitly in
> the device-trees, and thus, there is no real need to emit the noisy
> warnings in this case.

For now I will keep $subject patch applied, but please tell me if I
should drop it so we can start over.

In any case, I would appreciate it if someone could have a stab at
converting sdhci and tegra DT bindings to yaml.

Kind regards
Uffe
