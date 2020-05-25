Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EEAC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D5220812
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnRQGb64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbgEYIsT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbgEYIsT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 04:48:19 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD87C08C5C0
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:18 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i89so5870581uad.5
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zO0sBa5XUiRaLJfIzqpQcwJ9oEZ96FRFJABqjIiFpok=;
        b=VnRQGb64zcmMLie5IN9cBZrs6Jhe0tUC/LdKlpbewwdhPwhs61rrU4RacRjEfI54FG
         AIzLzgbxYEE3ST0IuPm4Q2h3IX0KSXYfAEASJzPOqx8iX+qeYHNHZRRCTp05SVLGDYtm
         8g1txZdPsQEP/+C4ctPVlIy3xtYzrvUeR7OFi1i+A6fWjH1nL2n+PiHCwCfyh5EBz6Kl
         mangW0RyiH9vAURT0fejuGWRURgNyjLeUZ4s9TSyhyAF/VkvccmnV0YBh3YjE/7odADj
         GTMXu+ValgARqPGTgIfaRrrexpbgrfgC8Xl6yMgECT5f5RxIrfduRFzQGsy8im1Y9g7Q
         nCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zO0sBa5XUiRaLJfIzqpQcwJ9oEZ96FRFJABqjIiFpok=;
        b=N9nLZJNcSEUv+Xa7FhLCdNxl1XGyNM3mUnYQiwCYTqleKW71cvSsbQhHYhSUqA5cWn
         8kISs4eR8x/BHjJgZCVeDTnCjGUaUtd4BryQBrxUeLEtdTPcDYqjNpl8fQllp6REnFSw
         cFx+oNKCFrpLvyAAINYcMJmofo9t5z2He8BqFGKabl5wnMBIYSwafeRJTTd5rqVk4bMr
         Qf7SExBeOQPQgk6gzOFx8/pg581YmtDusjt4hW8OCOdrTwNaCowW+Wp4IF6Vj0gnZ/gv
         c7Rh7NN36fyYPcZU/NoSUmjGTI82fwUcnrFhEbr48iR+eTzYT573vN/xsOKbWRN+HYDQ
         6Hzw==
X-Gm-Message-State: AOAM531zudET2UtCkifkOtalzHgvyUHSlOc0Q5sWcA86N8NJF4UvfTaU
        GLqMNEfV2IPBpbHnuc6H6ehjIU5ROgedmbwGaRvaYw==
X-Google-Smtp-Source: ABdhPJwVGS8wYN7oOmlPO/bzq1LUM3CcaHHMZKJnrnaliKpmydBb3VO9LDZfGXQP2EmUhbx+jqJ2fOem+HudEPcMXeQ=
X-Received: by 2002:ab0:7293:: with SMTP id w19mr17972779uao.129.1590396497671;
 Mon, 25 May 2020 01:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
 <20200519162444.GD2113674@ulmo> <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
 <11c93dac-f5ba-2193-6f44-63af27fdce09@nvidia.com> <aed72c87-0e16-6dea-a4e2-7fc6a97cd313@nvidia.com>
 <c7469c16-f6f1-f9c0-566f-3b1d3774f130@nvidia.com> <c712de1d-cfa4-2746-ec6b-54f318aeaac2@nvidia.com>
 <d2c71267-e696-c459-fbd6-dbb5fd312ed3@gmail.com> <CAPDyKFqdeGyQpXpM+xynd_rWbi0S6hCeQS1Dyiy6Hd2E_yfHpg@mail.gmail.com>
 <96f917a3-d822-1c36-d088-3e4a322c1761@nvidia.com> <20200522121357.GD2163848@ulmo>
In-Reply-To: <20200522121357.GD2163848@ulmo>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 10:47:39 +0200
Message-ID: <CAPDyKFrnKso=5oBsmHYAOQV_0jy9aB9JROWESEV4pdUsPi4dFg@mail.gmail.com>
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
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

On Fri, 22 May 2020 at 14:14, Thierry Reding <thierry.reding@gmail.com> wro=
te:
>
> On Wed, May 20, 2020 at 09:09:33AM -0700, Sowjanya Komatineni wrote:
> >
> > On 5/20/20 4:26 AM, Ulf Hansson wrote:
> > > On Wed, 20 May 2020 at 04:00, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> > > > 19.05.2020 23:44, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > > > > On 5/19/20 12:07 PM, Sowjanya Komatineni wrote:
> > > > > > On 5/19/20 11:41 AM, Sowjanya Komatineni wrote:
> > > > > > > On 5/19/20 11:34 AM, Sowjanya Komatineni wrote:
> > > > > > > > On 5/19/20 9:33 AM, Dmitry Osipenko wrote:
> > > > > > > > > 19.05.2020 19:24, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> > > > > > > > > > On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipen=
ko wrote:
> > > > > > > > > > > 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=
=B5=D1=82:
> > > > > > > > > > > > On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <dige=
tx@gmail.com>
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > Several people asked me about the MMC warnings in=
 the KMSG log and
> > > > > > > > > > > > > I had to tell to ignore them because these warnin=
g are
> > > > > > > > > > > > > irrelevant to
> > > > > > > > > > > > > pre-Tegra210 SoCs.
> > > > > > > > > > > > Why are the warnings irrelevant?
> > > > > > > > > > > That's what the DT binding doc says [1].
> > > > > > > > > > >
> > > > > > > > > > > [1]
> > > > > > > > > > > https://www.kernel.org/doc/Documentation/devicetree/b=
indings/mmc/nvidia%2Ctegra20-sdhci.txt
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Although, looking at the driver's code and TRM docs, =
it seems
> > > > > > > > > > > that all
> > > > > > > > > > > those properties are really irrelevant only to the ol=
der Terga20
> > > > > > > > > > > SoC. So
> > > > > > > > > > > the binding doc is a bit misleading.
> > > > > > > > > > >
> > > > > > > > > > > Nevertheless, the binding explicitly says that the pr=
operties are
> > > > > > > > > > > optional, which is correct.
> > > > > > > > > > Optional only means that drivers must not fail if these=
 properties
> > > > > > > > > > aren't found, it doesn't mean that the driver can't war=
n that they
> > > > > > > > > > are missing.
> > > > > > > > > >
> > > > > > > > > > Quite possibly the only reason why they were made optio=
nal is because
> > > > > > > > > > they weren't part of the bindings since the beginning. =
Anything added
> > > > > > > > > > to a binding after the first public release has to be o=
ptional by
> > > > > > > > > > definition, otherwise DT ABI wouldn't be stable.
> > > > > > > > > >
> > > > > > > > > > I think these warnings were added on purpose, though I =
also see that
> > > > > > > > > > there are only values for these in device tree for Tegr=
a186 and
> > > > > > > > > > Tegra194
> > > > > > > > > > but not Tegra210 where these should also be necessary.
> > > > > > > > dt binding doc we have is common for MMC, SD and SDIO of al=
l Tegras.
> > > > > > > > Its not mandatory to have both 3v3 and 1v8 in device tree a=
s based
> > > > > > > > on signal mode.
> > > > > > > >
> > > > > > > > As these driver strengths are SoC specific, they are part o=
f Tegra
> > > > > > > > SoC specific device tree where same values will be applicab=
le to all
> > > > > > > > Tegra SoC specific platforms.
> > > > > > > >
> > > > > > > > Based on interface usage on platform, we use one or both of=
 them
> > > > > > > > like sdcard supports dual voltage and we use both 3V3 and 1=
V8 but if
> > > > > > > > same interface is used for WIFI SD we use 1V8 only.
> > > > > > > >
> > > > > > > > So made these dt properties as optional.
> > > > > > > >
> > > > > > > > Other reason they are optional is, Tegra210 and prior has d=
rive
> > > > > > > > strength settings part of apb_misc and Tegra186 and later h=
as driver
> > > > > > > > strengths part of SDMMC controller. So,
> > > > > > > >
> > > > > > > > - Pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" for driver s=
trengths
> > > > > > > > are applicable for Tegra210 and prior.
> > > > > > > > - dt properties pad-autocal-pull-up/down-offset-1v8/3v3-tim=
eout are
> > > > > > > > for T186 onwards for driver strengths
> > > > > > > >
> > > > > > > > Looks like dt binding doc need fix to clearly document thes=
e based
> > > > > > > > on SoC or agree with Yaml we can conditionally specify pinc=
trl or dt
> > > > > > > > properties based on SoC dependent.
> > > > > > > >
> > > > > > > >
> > > > > > > > > > Adding Sowjanya who wrote this code. Perhaps she can cl=
arify why the
> > > > > > > > > > warnings were added. If these values /should/ be there =
on a subset of
> > > > > > > > > > Tegra, then I think we should keep them, or add them ag=
ain, but
> > > > > > > > > > perhaps
> > > > > > > > > > add a better way of identifying when they are necessary=
 and when
> > > > > > > > > > it is
> > > > > > > > > > safe to work without them.
> > > > > > > > > >
> > > > > > > > > > That said, looking at those checks I wonder if they are=
 perhaps just
> > > > > > > > > > wrong. Or at the very least they seem redundant. It loo=
ks to me like
> > > > > > > > > > they can just be:
> > > > > > > > > >
> > > > > > > > > >      if (tegra_host->pinctrl_state_XYZ =3D=3D NULL) {
> > > > > > > > > >          ...
> > > > > > > > > >      }
> > > > > > > > > >
> > > > > > > > > > That !IS_ERR(...) doesn't seem to do anything. But in t=
hat case, it's
> > > > > > > > > > also obvious why we're warning about them on platforms =
where these
> > > > > > > > > > properties don't exist in DT.
> > > > > > > > As drive strengths are through dt properties for T186 and l=
ater and
> > > > > > > > thru pinctrl for T210 and prior, driver first checks for dt=
 autocal
> > > > > > > > timeout pull-up/down properties and if they are not found, =
it then
> > > > > > > > checks for presence of pinctrl_state_xyx_drv only when vali=
d
> > > > > > > > pinctrl_state_xyz is present.
> > > > > > > >
> > > > > > > > Driver expects either pinctrl or dt properties and shows wa=
rning
> > > > > > > > when neither of them are present as its mandatory to use fi=
xed
> > > > > > > > driver strengths when auto calibration fails.
> > > > > > > >
> > > > > > > >      err =3D device_property_read_u32(host->mmc->parent,
> > > > > > > >              "nvidia,pad-autocal-pull-down-offset-3v3-timeo=
ut",
> > > > > > > >              &autocal->pull_down_3v3_timeout);
> > > > > > > >      if (err) {
> > > > > > > >          if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> > > > > > > >              (tegra_host->pinctrl_state_3v3_drv =3D=3D NULL=
))
> > > > > > > >              pr_warn("%s: Missing autocal timeout 3v3-pad d=
rvs\n",
> > > > > > > >                  mmc_hostname(host->mmc));
> > > > > > > >          autocal->pull_down_3v3_timeout =3D 0;
> > > > > > > >      }
> > > > > > > >
> > > > > > > > > > So I think we either need to add those values where app=
ropriate so
> > > > > > > > > > that
> > > > > > > > > > the warning doesn't show, or we need to narrow down whe=
re they are
> > > > > > > > > > really needed and add a corresponding condition.
> > > > > > > > > >
> > > > > > > > > > But again, perhaps Sowjanya can help clarify if these r=
eally are only
> > > > > > > > > > needed on Tegra210 and later or if these also apply to =
older chips.
> > > > > > > > > Either way will be cleaner to convert the DT binding to Y=
AML rather
> > > > > > > > > than
> > > > > > > > > clutter the driver, IMO.
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > Auto calibration is present from Tegra30 onward and looking i=
nto
> > > > > > > change where autocalibration was added to sdhci driver someho=
w it was
> > > > > > > enabled only for T30/T210/T186/T194.
> > > > > > >
> > > > > > > tegra_sdhci_parse_pad_autocal_dt() was added when auto-calibr=
ation
> > > > > > > was added to driver and I see this dt parse is being done
> > > > > > > irrespective of NVQUIRK_HAS_PADCALIB quirk so even on platfor=
ms
> > > > > > > without auto cal enabled in driver, these messages shows up.
> > > > > > >
> > > > > > > This should be fixed in driver to allow
> > > > > > > tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADC=
ALIB is
> > > > > > > set to avoid dt parsing to happen on platforms that don't hav=
e auto
> > > > > > > cal enabled.
> > > > > > Warning on missing drive strengths when auto cal is enabled sho=
uld be
> > > > > > present as we should switch to fixed recommended drive strength=
s when
> > > > > > auto cal fails.
> > > > > >
> > > > > > So probably proper fix should be
> > > > > >
> > > > > > - allow tegra_sdhci_parse_pad_autocal_dt() only when
> > > > > > NVQUIRK_HAS_PADCALIB is set
> > > > > >
> > > > > > - current driver sets NVQUIRK_HAS_PADCALIB for T30 as well so n=
eed to
> > > > > > add pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" to Tegra30 dev=
ice tree.
> > > > > [Correction] T30 has same drive strengths to use irrespective of =
signal
> > > > > voltage and it doesn't have pad control. So for T3- we can update=
 device
> > > > > tree to specify "default" pinctrl with drvup/dn settings.
> > > > > > - Keep warning message of missing auto cal timeouts as its mand=
atory
> > > > > > to use fixed recommended driver strengths when auto cal fails.
> > > > > >
> > > > > Regarding warnings, I guess simpler and easy fix is to remove war=
ning
> > > > > message on missing 3v3/1v8 drive strengths as pinctrl/dt properti=
es were
> > > > > already added for T210/186/194 where we need and old device tree =
don't
> > > > > have them but the case where auto cal can fail is very rare.
> > > > >
> > > > > Otherwise should update driver to allow
> > > > > tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB=
 is set
> > > > > and also within tegra_sdhci_parse_pad_autocal_dt() show warning o=
f
> > > > > missing 3v3/1v8 settings only when NVQUIRK_NEEDS_PAD_CONTROL is s=
et.
> > > > >
> > > > > Thierry, please suggest if you prefer to removing warnings or fix=
 driver
> > > > > to show warning based on PADCALIB and PAD_CONTROL quirks.
> > > > The SDIO PINCTRL drive-strengths are usually a part of the board's
> > > > default PINCTRL state, which is either preset by bootloader or by
> > > > PINCTRL driver early at a boot time.
> > > >
> > > > The SDIO drive-strengths values should be board-specific and not
> > > > SoC-specific because they should depend on the electrical propertie=
s of
> > > > the board, IIUC.
> >
> > Drive strengths we program here when auto calibration fails are recomme=
nded
> > values based on pre-SI circuit analysis and characterized across PVT.
> >
> > So,  these fail safe values are same for all boards of specific SoC as =
all
> > platform designs follow the design guidelines.
> >
> > > > If the SDIO PINCTRL states are mandatory for the SDHCI nodes in the
> > > > device-trees, then the DT binding is wrong since it says that all
> > > > properties are optional. But I think that the current binding is ok=
ay,
> > > > since today SDHCI PINCTRL drive-strengths are specified implicitly =
in
> > > > the device-trees, and thus, there is no real need to emit the noisy
> > > > warnings in this case.
> > > For now I will keep $subject patch applied, but please tell me if I
> > > should drop it so we can start over.
> > >
> > > In any case, I would appreciate it if someone could have a stab at
> > > converting sdhci and tegra DT bindings to yaml.
> > >
> > > Kind regards
> > > Uffe
> >
> > HI Uffe,
> >
> > Please drop $subject patch. Will send patch that allows parsing for the=
se
> > properties only for SoC where auto cal is enabled as that's where drive=
r
> > needs these properties.
> >
> > So with this fix, warning will not show up on systems where autocal is =
not
> > enabled.
>
> Yes, I think that's a better option. Have we ensured that on all systems
> where autocal is enabled these values are part of the device tree? Just
> making sure that we're not going to have some generation still spit out
> these warnings because we forgot to update the device tree.
>
> For example I see that we set NVQUIRK_HAS_PADCALIB but I don't see these
> properties being set in arch/arm/boot/dts/tegra30.dtsi. Can you add a
> patch that also adds the properties for Tegra30?
>

Patch dropped, thanks!

Kind regards
Uffe
