Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A298C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1657206C3
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIXh4Md9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgEVMen (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEVMem (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 08:34:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653DAC061A0E;
        Fri, 22 May 2020 05:34:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h21so12846189ejq.5;
        Fri, 22 May 2020 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v3URVjK9Y7tRZUL5segZDfx9JxXccOph+AKs4yRvXfs=;
        b=ZIXh4Md9We27V6CIxEvR1urT9Qh1NGb2pm630+UGf49Ls/+lScZJ/S4bxjUy38FdIs
         xQWKcsVu4HBrf0UFOrId8ugadx6H0OIOsLGmZiUDXhkjcAxpf5PhrUpGTE2tgiLly13t
         YPQ+0PoxlyxwIhVwg2yyrIZEkgNxMzMho6a10Mmh/4RZHlhiBo4Z7T8h0Zmfeb0RvmyS
         hLaJ+Y0TKCjYn+KvAFmgzbill8okM+DYK62LUahgZPYwm42KkMdiPts8C4Xfa9cFI6ob
         x1T7wEwtfy85oGxBs87RL7xu3osoKUFAbh86VQKJ63Sp23QIyE4Is7mcl4P1gwgxhXKo
         NpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3URVjK9Y7tRZUL5segZDfx9JxXccOph+AKs4yRvXfs=;
        b=rCSzw/Q0agjlR0fKfFMayq2SBFGPGs30oQ2NjHQkZxcNetBdCjQOSb/6BuOB/MnjtV
         Al4I6vvicmwW7cxmzlCNqknyu4/sAhM8olw6lE1MjqzItcIAQt9Ouhg54wKRMC/e8Yaf
         dy0iPIxxih+IerY/LcfEDYauLISmkgwzEtsF84PL9BUrHtTEooG6Wxhuy5U/moIF2Cew
         xL5PmzXjP0T4jdY9Fx8wL+I0BMeN1zKU6KyBuv3FdCv4VDsi1eKqE4uGyaBoKVbx6yEP
         LI44f45pclSKwQPPSzP/X6r2UpmD2jtjBe3cZZCpFnkeapMN1siqczKGnC+4XiaWUSLd
         RZcg==
X-Gm-Message-State: AOAM532kombfCEV3J4w8j56ColRlQR8ae/bQ2d1lj/cBtW6ZTYuTU2jU
        FNv+TK62q0b7YN6K+3VyV9E=
X-Google-Smtp-Source: ABdhPJwJ956ePQHMfFtoNSq7sWwJbD9WFHwhA6K6zSzi/+hUlEyl2/8MrF1SaRfuv5sVN3NRsoqFrw==
X-Received: by 2002:a17:906:46d3:: with SMTP id k19mr8289471ejs.349.1590150879848;
        Fri, 22 May 2020 05:34:39 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id d27sm7699701eja.29.2020.05.22.05.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:34:38 -0700 (PDT)
Date:   Fri, 22 May 2020 14:34:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
Message-ID: <20200522123437.GF2163848@ulmo>
References: <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
 <11c93dac-f5ba-2193-6f44-63af27fdce09@nvidia.com>
 <aed72c87-0e16-6dea-a4e2-7fc6a97cd313@nvidia.com>
 <c7469c16-f6f1-f9c0-566f-3b1d3774f130@nvidia.com>
 <c712de1d-cfa4-2746-ec6b-54f318aeaac2@nvidia.com>
 <d2c71267-e696-c459-fbd6-dbb5fd312ed3@gmail.com>
 <CAPDyKFqdeGyQpXpM+xynd_rWbi0S6hCeQS1Dyiy6Hd2E_yfHpg@mail.gmail.com>
 <96f917a3-d822-1c36-d088-3e4a322c1761@nvidia.com>
 <20200522121357.GD2163848@ulmo>
 <2fa9db46-e310-dbbc-e1f7-f7058435a688@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <2fa9db46-e310-dbbc-e1f7-f7058435a688@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 03:18:40PM +0300, Dmitry Osipenko wrote:
> 22.05.2020 15:13, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, May 20, 2020 at 09:09:33AM -0700, Sowjanya Komatineni wrote:
> >>
> >> On 5/20/20 4:26 AM, Ulf Hansson wrote:
> >>> On Wed, 20 May 2020 at 04:00, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>> 19.05.2020 23:44, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> On 5/19/20 12:07 PM, Sowjanya Komatineni wrote:
> >>>>>> On 5/19/20 11:41 AM, Sowjanya Komatineni wrote:
> >>>>>>> On 5/19/20 11:34 AM, Sowjanya Komatineni wrote:
> >>>>>>>> On 5/19/20 9:33 AM, Dmitry Osipenko wrote:
> >>>>>>>>> 19.05.2020 19:24, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>>>>> On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko wrot=
e:
> >>>>>>>>>>> 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>>>>>>>> On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.=
com>
> >>>>>>>>>>>> wrote:
> >>>>>>>>>>>>> Several people asked me about the MMC warnings in the KMSG =
log and
> >>>>>>>>>>>>> I had to tell to ignore them because these warning are
> >>>>>>>>>>>>> irrelevant to
> >>>>>>>>>>>>> pre-Tegra210 SoCs.
> >>>>>>>>>>>> Why are the warnings irrelevant?
> >>>>>>>>>>> That's what the DT binding doc says [1].
> >>>>>>>>>>>
> >>>>>>>>>>> [1]
> >>>>>>>>>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/=
mmc/nvidia%2Ctegra20-sdhci.txt
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Although, looking at the driver's code and TRM docs, it seems
> >>>>>>>>>>> that all
> >>>>>>>>>>> those properties are really irrelevant only to the older Terg=
a20
> >>>>>>>>>>> SoC. So
> >>>>>>>>>>> the binding doc is a bit misleading.
> >>>>>>>>>>>
> >>>>>>>>>>> Nevertheless, the binding explicitly says that the properties=
 are
> >>>>>>>>>>> optional, which is correct.
> >>>>>>>>>> Optional only means that drivers must not fail if these proper=
ties
> >>>>>>>>>> aren't found, it doesn't mean that the driver can't warn that =
they
> >>>>>>>>>> are missing.
> >>>>>>>>>>
> >>>>>>>>>> Quite possibly the only reason why they were made optional is =
because
> >>>>>>>>>> they weren't part of the bindings since the beginning. Anythin=
g added
> >>>>>>>>>> to a binding after the first public release has to be optional=
 by
> >>>>>>>>>> definition, otherwise DT ABI wouldn't be stable.
> >>>>>>>>>>
> >>>>>>>>>> I think these warnings were added on purpose, though I also se=
e that
> >>>>>>>>>> there are only values for these in device tree for Tegra186 and
> >>>>>>>>>> Tegra194
> >>>>>>>>>> but not Tegra210 where these should also be necessary.
> >>>>>>>> dt binding doc we have is common for MMC, SD and SDIO of all Teg=
ras.
> >>>>>>>> Its not mandatory to have both 3v3 and 1v8 in device tree as bas=
ed
> >>>>>>>> on signal mode.
> >>>>>>>>
> >>>>>>>> As these driver strengths are SoC specific, they are part of Teg=
ra
> >>>>>>>> SoC specific device tree where same values will be applicable to=
 all
> >>>>>>>> Tegra SoC specific platforms.
> >>>>>>>>
> >>>>>>>> Based on interface usage on platform, we use one or both of them
> >>>>>>>> like sdcard supports dual voltage and we use both 3V3 and 1V8 bu=
t if
> >>>>>>>> same interface is used for WIFI SD we use 1V8 only.
> >>>>>>>>
> >>>>>>>> So made these dt properties as optional.
> >>>>>>>>
> >>>>>>>> Other reason they are optional is, Tegra210 and prior has drive
> >>>>>>>> strength settings part of apb_misc and Tegra186 and later has dr=
iver
> >>>>>>>> strengths part of SDMMC controller. So,
> >>>>>>>>
> >>>>>>>> - Pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" for driver streng=
ths
> >>>>>>>> are applicable for Tegra210 and prior.
> >>>>>>>> - dt properties pad-autocal-pull-up/down-offset-1v8/3v3-timeout =
are
> >>>>>>>> for T186 onwards for driver strengths
> >>>>>>>>
> >>>>>>>> Looks like dt binding doc need fix to clearly document these bas=
ed
> >>>>>>>> on SoC or agree with Yaml we can conditionally specify pinctrl o=
r dt
> >>>>>>>> properties based on SoC dependent.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>> Adding Sowjanya who wrote this code. Perhaps she can clarify w=
hy the
> >>>>>>>>>> warnings were added. If these values /should/ be there on a su=
bset of
> >>>>>>>>>> Tegra, then I think we should keep them, or add them again, but
> >>>>>>>>>> perhaps
> >>>>>>>>>> add a better way of identifying when they are necessary and wh=
en
> >>>>>>>>>> it is
> >>>>>>>>>> safe to work without them.
> >>>>>>>>>>
> >>>>>>>>>> That said, looking at those checks I wonder if they are perhap=
s just
> >>>>>>>>>> wrong. Or at the very least they seem redundant. It looks to m=
e like
> >>>>>>>>>> they can just be:
> >>>>>>>>>>
> >>>>>>>>>>      if (tegra_host->pinctrl_state_XYZ =3D=3D NULL) {
> >>>>>>>>>>          ...
> >>>>>>>>>>      }
> >>>>>>>>>>
> >>>>>>>>>> That !IS_ERR(...) doesn't seem to do anything. But in that cas=
e, it's
> >>>>>>>>>> also obvious why we're warning about them on platforms where t=
hese
> >>>>>>>>>> properties don't exist in DT.
> >>>>>>>> As drive strengths are through dt properties for T186 and later =
and
> >>>>>>>> thru pinctrl for T210 and prior, driver first checks for dt auto=
cal
> >>>>>>>> timeout pull-up/down properties and if they are not found, it th=
en
> >>>>>>>> checks for presence of pinctrl_state_xyx_drv only when valid
> >>>>>>>> pinctrl_state_xyz is present.
> >>>>>>>>
> >>>>>>>> Driver expects either pinctrl or dt properties and shows warning
> >>>>>>>> when neither of them are present as its mandatory to use fixed
> >>>>>>>> driver strengths when auto calibration fails.
> >>>>>>>>
> >>>>>>>>      err =3D device_property_read_u32(host->mmc->parent,
> >>>>>>>>              "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
> >>>>>>>>              &autocal->pull_down_3v3_timeout);
> >>>>>>>>      if (err) {
> >>>>>>>>          if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> >>>>>>>>              (tegra_host->pinctrl_state_3v3_drv =3D=3D NULL))
> >>>>>>>>              pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n=
",
> >>>>>>>>                  mmc_hostname(host->mmc));
> >>>>>>>>          autocal->pull_down_3v3_timeout =3D 0;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>>>> So I think we either need to add those values where appropriat=
e so
> >>>>>>>>>> that
> >>>>>>>>>> the warning doesn't show, or we need to narrow down where they=
 are
> >>>>>>>>>> really needed and add a corresponding condition.
> >>>>>>>>>>
> >>>>>>>>>> But again, perhaps Sowjanya can help clarify if these really a=
re only
> >>>>>>>>>> needed on Tegra210 and later or if these also apply to older c=
hips.
> >>>>>>>>> Either way will be cleaner to convert the DT binding to YAML ra=
ther
> >>>>>>>>> than
> >>>>>>>>> clutter the driver, IMO.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>> Auto calibration is present from Tegra30 onward and looking into
> >>>>>>> change where autocalibration was added to sdhci driver somehow it=
 was
> >>>>>>> enabled only for T30/T210/T186/T194.
> >>>>>>>
> >>>>>>> tegra_sdhci_parse_pad_autocal_dt() was added when auto-calibration
> >>>>>>> was added to driver and I see this dt parse is being done
> >>>>>>> irrespective of NVQUIRK_HAS_PADCALIB quirk so even on platforms
> >>>>>>> without auto cal enabled in driver, these messages shows up.
> >>>>>>>
> >>>>>>> This should be fixed in driver to allow
> >>>>>>> tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB=
 is
> >>>>>>> set to avoid dt parsing to happen on platforms that don't have au=
to
> >>>>>>> cal enabled.
> >>>>>> Warning on missing drive strengths when auto cal is enabled should=
 be
> >>>>>> present as we should switch to fixed recommended drive strengths w=
hen
> >>>>>> auto cal fails.
> >>>>>>
> >>>>>> So probably proper fix should be
> >>>>>>
> >>>>>> - allow tegra_sdhci_parse_pad_autocal_dt() only when
> >>>>>> NVQUIRK_HAS_PADCALIB is set
> >>>>>>
> >>>>>> - current driver sets NVQUIRK_HAS_PADCALIB for T30 as well so need=
 to
> >>>>>> add pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" to Tegra30 device=
 tree.
> >>>>> [Correction] T30 has same drive strengths to use irrespective of si=
gnal
> >>>>> voltage and it doesn't have pad control. So for T3- we can update d=
evice
> >>>>> tree to specify "default" pinctrl with drvup/dn settings.
> >>>>>> - Keep warning message of missing auto cal timeouts as its mandato=
ry
> >>>>>> to use fixed recommended driver strengths when auto cal fails.
> >>>>>>
> >>>>> Regarding warnings, I guess simpler and easy fix is to remove warni=
ng
> >>>>> message on missing 3v3/1v8 drive strengths as pinctrl/dt properties=
 were
> >>>>> already added for T210/186/194 where we need and old device tree do=
n't
> >>>>> have them but the case where auto cal can fail is very rare.
> >>>>>
> >>>>> Otherwise should update driver to allow
> >>>>> tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB i=
s set
> >>>>> and also within tegra_sdhci_parse_pad_autocal_dt() show warning of
> >>>>> missing 3v3/1v8 settings only when NVQUIRK_NEEDS_PAD_CONTROL is set.
> >>>>>
> >>>>> Thierry, please suggest if you prefer to removing warnings or fix d=
river
> >>>>> to show warning based on PADCALIB and PAD_CONTROL quirks.
> >>>> The SDIO PINCTRL drive-strengths are usually a part of the board's
> >>>> default PINCTRL state, which is either preset by bootloader or by
> >>>> PINCTRL driver early at a boot time.
> >>>>
> >>>> The SDIO drive-strengths values should be board-specific and not
> >>>> SoC-specific because they should depend on the electrical properties=
 of
> >>>> the board, IIUC.
> >>
> >> Drive strengths we program here when auto calibration fails are recomm=
ended
> >> values based on pre-SI circuit analysis and characterized across PVT.
> >>
> >> So,=C2=A0 these fail safe values are same for all boards of specific S=
oC as all
> >> platform designs follow the design guidelines.
> >>
> >>>> If the SDIO PINCTRL states are mandatory for the SDHCI nodes in the
> >>>> device-trees, then the DT binding is wrong since it says that all
> >>>> properties are optional. But I think that the current binding is oka=
y,
> >>>> since today SDHCI PINCTRL drive-strengths are specified implicitly in
> >>>> the device-trees, and thus, there is no real need to emit the noisy
> >>>> warnings in this case.
> >>> For now I will keep $subject patch applied, but please tell me if I
> >>> should drop it so we can start over.
> >>>
> >>> In any case, I would appreciate it if someone could have a stab at
> >>> converting sdhci and tegra DT bindings to yaml.
> >>>
> >>> Kind regards
> >>> Uffe
> >>
> >> HI Uffe,
> >>
> >> Please drop $subject patch. Will send patch that allows parsing for th=
ese
> >> properties only for SoC where auto cal is enabled as that's where driv=
er
> >> needs these properties.
> >>
> >> So with this fix, warning will not show up on systems where autocal is=
 not
> >> enabled.
> >=20
> > Yes, I think that's a better option. Have we ensured that on all systems
> > where autocal is enabled these values are part of the device tree? Just
> > making sure that we're not going to have some generation still spit out
> > these warnings because we forgot to update the device tree.
> >=20
> > For example I see that we set NVQUIRK_HAS_PADCALIB but I don't see these
> > properties being set in arch/arm/boot/dts/tegra30.dtsi. Can you add a
> > patch that also adds the properties for Tegra30?
>=20
> I don't see the warnings on T30 using Sowjanya's patch which checks for
> NVQUIRK_NEEDS_PAD_CONTROL and not NVQUIRK_HAS_PADCALIB.

Yeah, I noticed that too when looking at Sowjanya's patch. The fact that
we have two of these quirks is somewhat confusing to me. Perhaps we can
add a comment near their definition to clarify what their purpose is?

Thierry

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Hxt0ACgkQ3SOs138+
s6Eqlg//dV3TZXz8e2q33WNRFlW4mEfwvQxGAD7bYlmZWc11cpilQKcYKVfXa7Zx
52Ks7IX/WtIlRNSTeKERuzk4slzHPPf8cRUvRIRfUV7zXJpMs7OdhVQRy1s2CwqX
fKhxnmvTi4l6Azg+jmeHRbGb4pkGvUhNvo5u/6kFrIrFKqR7WmV9a9qt11I5AACe
PtgAleBuHCXrjZmFaFnehOOC17yaUUTZvyFaQkCB3+NCcfMg2YmCg7n++3pXJKy0
wLzcmBG9/KAXY1l8o2ank75cCT+xQxA5Db7yeCHpP9VxtaJ5KrcyZpKCAWqM1X8C
19l88YzyumBYoASLPfjmbHUYnyc91QLuUI6c/V+fkPpKXyKPiiqbJRPrD28CM52g
VAdV8zM/nKIciJd7jLOT0v+m2NatNZzhNxMENSAQ8fVJGZlQbw7KBmsY312seVXj
ReZFiLaTnIVl8O8MTeniL7LfXR70/NXsqw7sCo8G0B8Q9vvjpcULdsZ/2URso9kZ
fOuvoooG+9HynjhtNv6n8hIrJBKJG5iQbRAohm5La5XM5TLaK6kcDYE1uUnlpIZq
Yj51q+L9ope0ylK+sDc6Z0Su6U00P4la552FRc8esXThQx+GjNaXdULvXdpX24fX
8FDSqwPqA+st7+2NIQH+3TS78yd/UvQeb7EQf8HetLDheuTAx3s=
=xPsP
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
