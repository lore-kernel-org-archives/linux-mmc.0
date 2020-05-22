Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF9C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4080206B6
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSABV6DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgEVMOC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgEVMOB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 08:14:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C17C061A0E;
        Fri, 22 May 2020 05:14:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id se13so12730913ejb.9;
        Fri, 22 May 2020 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=os9WQmn1qrpdmVBGkeADZsQPHxlWfFLl+eux4dNoAs8=;
        b=gSABV6DXQqzu70QpOyNlkhNzKmME+lbWwLoNc5C6ijrydbxDcDV/fXHhmCBUe+irI6
         iS9S7RY3wSQskedRoHUmyE1vsn/wi1OEXY00uthdw4Vx22s2kE8GwXzrrXgWJxO2iNCP
         IayVMFkGuV2PEn9dHuwe7c/vLaY96a+KsuYbgS0njD+pVrYMw0Ez1DagJ/dtvidXTisP
         XIrv9jZKi6m7rx48Ik/vzFTw4MbmhkJMecQbrEDGhYQqvDSLZeDFzFVbTWhsSrH3iwEn
         iaEhlDJh+YNEihbYArYcC/i90Hb80lYhmV2nZuCXbUvWXQrfebP0r686KMfTyYSCXE0d
         ZEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=os9WQmn1qrpdmVBGkeADZsQPHxlWfFLl+eux4dNoAs8=;
        b=sbxR5lPUjb9W8jJa6W+e9Pa1NU7+Lt577FqrdQ33i+m+eq2KuVUA8qQzVVIJd6GfJy
         YSFQlsULs2xdvx75D1b2JQAdHVGMXYr8jqBEPlvjSaseoAphLd4J7OAdmYPys2oaAUe5
         mXoUyRG05Jtm931W/kstgCQdRpMxdM4v09D0dJ/UOieUdQ/zQEjz/sYfXYulnV40sra7
         YfCHZgJPxaZbj/P+0qh0Ze4NaL4p19ln11X+mYwYOVIZ1VRi9tBs1X1/fSJuWrr/V448
         k7LYd1AKyNWYS7bgKjBs3xLU8K9fYsjIaU8RoeIZPajpu0reaGE2opbo9lkS59hP6Q65
         HHmQ==
X-Gm-Message-State: AOAM532grTk69bQm+lZMdog44eWUQbwzGOGAbsxH5Ig7flTj25ePL8YB
        i+Drr2bQgx1ukZPFnb2czew=
X-Google-Smtp-Source: ABdhPJzvoz6pt4MwPMVoieKOo47vdCLImqSLWt9LwEXw+vprrY67/R4hbKcMrqhuBNHgGTHSOcNswQ==
X-Received: by 2002:a17:906:3b4f:: with SMTP id h15mr8359387ejf.408.1590149639503;
        Fri, 22 May 2020 05:13:59 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id df21sm7060697edb.27.2020.05.22.05.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:13:57 -0700 (PDT)
Date:   Fri, 22 May 2020 14:13:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
Message-ID: <20200522121357.GD2163848@ulmo>
References: <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
 <20200519162444.GD2113674@ulmo>
 <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
 <11c93dac-f5ba-2193-6f44-63af27fdce09@nvidia.com>
 <aed72c87-0e16-6dea-a4e2-7fc6a97cd313@nvidia.com>
 <c7469c16-f6f1-f9c0-566f-3b1d3774f130@nvidia.com>
 <c712de1d-cfa4-2746-ec6b-54f318aeaac2@nvidia.com>
 <d2c71267-e696-c459-fbd6-dbb5fd312ed3@gmail.com>
 <CAPDyKFqdeGyQpXpM+xynd_rWbi0S6hCeQS1Dyiy6Hd2E_yfHpg@mail.gmail.com>
 <96f917a3-d822-1c36-d088-3e4a322c1761@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <96f917a3-d822-1c36-d088-3e4a322c1761@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 09:09:33AM -0700, Sowjanya Komatineni wrote:
>=20
> On 5/20/20 4:26 AM, Ulf Hansson wrote:
> > On Wed, 20 May 2020 at 04:00, Dmitry Osipenko <digetx@gmail.com> wrote:
> > > 19.05.2020 23:44, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > On 5/19/20 12:07 PM, Sowjanya Komatineni wrote:
> > > > > On 5/19/20 11:41 AM, Sowjanya Komatineni wrote:
> > > > > > On 5/19/20 11:34 AM, Sowjanya Komatineni wrote:
> > > > > > > On 5/19/20 9:33 AM, Dmitry Osipenko wrote:
> > > > > > > > 19.05.2020 19:24, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> > > > > > > > > On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko=
 wrote:
> > > > > > > > > > 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> > > > > > > > > > > On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx=
@gmail.com>
> > > > > > > > > > > wrote:
> > > > > > > > > > > > Several people asked me about the MMC warnings in t=
he KMSG log and
> > > > > > > > > > > > I had to tell to ignore them because these warning =
are
> > > > > > > > > > > > irrelevant to
> > > > > > > > > > > > pre-Tegra210 SoCs.
> > > > > > > > > > > Why are the warnings irrelevant?
> > > > > > > > > > That's what the DT binding doc says [1].
> > > > > > > > > >=20
> > > > > > > > > > [1]
> > > > > > > > > > https://www.kernel.org/doc/Documentation/devicetree/bin=
dings/mmc/nvidia%2Ctegra20-sdhci.txt
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Although, looking at the driver's code and TRM docs, it=
 seems
> > > > > > > > > > that all
> > > > > > > > > > those properties are really irrelevant only to the olde=
r Terga20
> > > > > > > > > > SoC. So
> > > > > > > > > > the binding doc is a bit misleading.
> > > > > > > > > >=20
> > > > > > > > > > Nevertheless, the binding explicitly says that the prop=
erties are
> > > > > > > > > > optional, which is correct.
> > > > > > > > > Optional only means that drivers must not fail if these p=
roperties
> > > > > > > > > aren't found, it doesn't mean that the driver can't warn =
that they
> > > > > > > > > are missing.
> > > > > > > > >=20
> > > > > > > > > Quite possibly the only reason why they were made optiona=
l is because
> > > > > > > > > they weren't part of the bindings since the beginning. An=
ything added
> > > > > > > > > to a binding after the first public release has to be opt=
ional by
> > > > > > > > > definition, otherwise DT ABI wouldn't be stable.
> > > > > > > > >=20
> > > > > > > > > I think these warnings were added on purpose, though I al=
so see that
> > > > > > > > > there are only values for these in device tree for Tegra1=
86 and
> > > > > > > > > Tegra194
> > > > > > > > > but not Tegra210 where these should also be necessary.
> > > > > > > dt binding doc we have is common for MMC, SD and SDIO of all =
Tegras.
> > > > > > > Its not mandatory to have both 3v3 and 1v8 in device tree as =
based
> > > > > > > on signal mode.
> > > > > > >=20
> > > > > > > As these driver strengths are SoC specific, they are part of =
Tegra
> > > > > > > SoC specific device tree where same values will be applicable=
 to all
> > > > > > > Tegra SoC specific platforms.
> > > > > > >=20
> > > > > > > Based on interface usage on platform, we use one or both of t=
hem
> > > > > > > like sdcard supports dual voltage and we use both 3V3 and 1V8=
 but if
> > > > > > > same interface is used for WIFI SD we use 1V8 only.
> > > > > > >=20
> > > > > > > So made these dt properties as optional.
> > > > > > >=20
> > > > > > > Other reason they are optional is, Tegra210 and prior has dri=
ve
> > > > > > > strength settings part of apb_misc and Tegra186 and later has=
 driver
> > > > > > > strengths part of SDMMC controller. So,
> > > > > > >=20
> > > > > > > - Pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" for driver str=
engths
> > > > > > > are applicable for Tegra210 and prior.
> > > > > > > - dt properties pad-autocal-pull-up/down-offset-1v8/3v3-timeo=
ut are
> > > > > > > for T186 onwards for driver strengths
> > > > > > >=20
> > > > > > > Looks like dt binding doc need fix to clearly document these =
based
> > > > > > > on SoC or agree with Yaml we can conditionally specify pinctr=
l or dt
> > > > > > > properties based on SoC dependent.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > > Adding Sowjanya who wrote this code. Perhaps she can clar=
ify why the
> > > > > > > > > warnings were added. If these values /should/ be there on=
 a subset of
> > > > > > > > > Tegra, then I think we should keep them, or add them agai=
n, but
> > > > > > > > > perhaps
> > > > > > > > > add a better way of identifying when they are necessary a=
nd when
> > > > > > > > > it is
> > > > > > > > > safe to work without them.
> > > > > > > > >=20
> > > > > > > > > That said, looking at those checks I wonder if they are p=
erhaps just
> > > > > > > > > wrong. Or at the very least they seem redundant. It looks=
 to me like
> > > > > > > > > they can just be:
> > > > > > > > >=20
> > > > > > > > >      if (tegra_host->pinctrl_state_XYZ =3D=3D NULL) {
> > > > > > > > >          ...
> > > > > > > > >      }
> > > > > > > > >=20
> > > > > > > > > That !IS_ERR(...) doesn't seem to do anything. But in tha=
t case, it's
> > > > > > > > > also obvious why we're warning about them on platforms wh=
ere these
> > > > > > > > > properties don't exist in DT.
> > > > > > > As drive strengths are through dt properties for T186 and lat=
er and
> > > > > > > thru pinctrl for T210 and prior, driver first checks for dt a=
utocal
> > > > > > > timeout pull-up/down properties and if they are not found, it=
 then
> > > > > > > checks for presence of pinctrl_state_xyx_drv only when valid
> > > > > > > pinctrl_state_xyz is present.
> > > > > > >=20
> > > > > > > Driver expects either pinctrl or dt properties and shows warn=
ing
> > > > > > > when neither of them are present as its mandatory to use fixed
> > > > > > > driver strengths when auto calibration fails.
> > > > > > >=20
> > > > > > >      err =3D device_property_read_u32(host->mmc->parent,
> > > > > > >              "nvidia,pad-autocal-pull-down-offset-3v3-timeout=
",
> > > > > > >              &autocal->pull_down_3v3_timeout);
> > > > > > >      if (err) {
> > > > > > >          if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> > > > > > >              (tegra_host->pinctrl_state_3v3_drv =3D=3D NULL))
> > > > > > >              pr_warn("%s: Missing autocal timeout 3v3-pad drv=
s\n",
> > > > > > >                  mmc_hostname(host->mmc));
> > > > > > >          autocal->pull_down_3v3_timeout =3D 0;
> > > > > > >      }
> > > > > > >=20
> > > > > > > > > So I think we either need to add those values where appro=
priate so
> > > > > > > > > that
> > > > > > > > > the warning doesn't show, or we need to narrow down where=
 they are
> > > > > > > > > really needed and add a corresponding condition.
> > > > > > > > >=20
> > > > > > > > > But again, perhaps Sowjanya can help clarify if these rea=
lly are only
> > > > > > > > > needed on Tegra210 and later or if these also apply to ol=
der chips.
> > > > > > > > Either way will be cleaner to convert the DT binding to YAM=
L rather
> > > > > > > > than
> > > > > > > > clutter the driver, IMO.
> > > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > Auto calibration is present from Tegra30 onward and looking into
> > > > > > change where autocalibration was added to sdhci driver somehow =
it was
> > > > > > enabled only for T30/T210/T186/T194.
> > > > > >=20
> > > > > > tegra_sdhci_parse_pad_autocal_dt() was added when auto-calibrat=
ion
> > > > > > was added to driver and I see this dt parse is being done
> > > > > > irrespective of NVQUIRK_HAS_PADCALIB quirk so even on platforms
> > > > > > without auto cal enabled in driver, these messages shows up.
> > > > > >=20
> > > > > > This should be fixed in driver to allow
> > > > > > tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCAL=
IB is
> > > > > > set to avoid dt parsing to happen on platforms that don't have =
auto
> > > > > > cal enabled.
> > > > > Warning on missing drive strengths when auto cal is enabled shoul=
d be
> > > > > present as we should switch to fixed recommended drive strengths =
when
> > > > > auto cal fails.
> > > > >=20
> > > > > So probably proper fix should be
> > > > >=20
> > > > > - allow tegra_sdhci_parse_pad_autocal_dt() only when
> > > > > NVQUIRK_HAS_PADCALIB is set
> > > > >=20
> > > > > - current driver sets NVQUIRK_HAS_PADCALIB for T30 as well so nee=
d to
> > > > > add pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" to Tegra30 devic=
e tree.
> > > > [Correction] T30 has same drive strengths to use irrespective of si=
gnal
> > > > voltage and it doesn't have pad control. So for T3- we can update d=
evice
> > > > tree to specify "default" pinctrl with drvup/dn settings.
> > > > > - Keep warning message of missing auto cal timeouts as its mandat=
ory
> > > > > to use fixed recommended driver strengths when auto cal fails.
> > > > >=20
> > > > Regarding warnings, I guess simpler and easy fix is to remove warni=
ng
> > > > message on missing 3v3/1v8 drive strengths as pinctrl/dt properties=
 were
> > > > already added for T210/186/194 where we need and old device tree do=
n't
> > > > have them but the case where auto cal can fail is very rare.
> > > >=20
> > > > Otherwise should update driver to allow
> > > > tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB i=
s set
> > > > and also within tegra_sdhci_parse_pad_autocal_dt() show warning of
> > > > missing 3v3/1v8 settings only when NVQUIRK_NEEDS_PAD_CONTROL is set.
> > > >=20
> > > > Thierry, please suggest if you prefer to removing warnings or fix d=
river
> > > > to show warning based on PADCALIB and PAD_CONTROL quirks.
> > > The SDIO PINCTRL drive-strengths are usually a part of the board's
> > > default PINCTRL state, which is either preset by bootloader or by
> > > PINCTRL driver early at a boot time.
> > >=20
> > > The SDIO drive-strengths values should be board-specific and not
> > > SoC-specific because they should depend on the electrical properties =
of
> > > the board, IIUC.
>=20
> Drive strengths we program here when auto calibration fails are recommend=
ed
> values based on pre-SI circuit analysis and characterized across PVT.
>=20
> So,=C2=A0 these fail safe values are same for all boards of specific SoC =
as all
> platform designs follow the design guidelines.
>=20
> > > If the SDIO PINCTRL states are mandatory for the SDHCI nodes in the
> > > device-trees, then the DT binding is wrong since it says that all
> > > properties are optional. But I think that the current binding is okay,
> > > since today SDHCI PINCTRL drive-strengths are specified implicitly in
> > > the device-trees, and thus, there is no real need to emit the noisy
> > > warnings in this case.
> > For now I will keep $subject patch applied, but please tell me if I
> > should drop it so we can start over.
> >=20
> > In any case, I would appreciate it if someone could have a stab at
> > converting sdhci and tegra DT bindings to yaml.
> >=20
> > Kind regards
> > Uffe
>=20
> HI Uffe,
>=20
> Please drop $subject patch. Will send patch that allows parsing for these
> properties only for SoC where auto cal is enabled as that's where driver
> needs these properties.
>=20
> So with this fix, warning will not show up on systems where autocal is not
> enabled.

Yes, I think that's a better option. Have we ensured that on all systems
where autocal is enabled these values are part of the device tree? Just
making sure that we're not going to have some generation still spit out
these warnings because we forgot to update the device tree.

For example I see that we set NVQUIRK_HAS_PADCALIB but I don't see these
properties being set in arch/arm/boot/dts/tegra30.dtsi. Can you add a
patch that also adds the properties for Tegra30?

Thierry

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HwgQACgkQ3SOs138+
s6H5GxAAmYFXr8kq7oo6X8YNNskQQ9eLjm7/WRUfvXeivx/Ulll/PxRKO5QjK8aM
VJJFCUM6KZqZJWr8PXUMsby5ilIdCFTaausG1yNi3QuWmNtEX+XzYDUmjgEaxqQo
VV5UkAWv0zIFKmkA1mULmTXsFgR3wDP7PUsGzgjvruhBXpL7E1LEbBC1/tQ5YvKK
nimCkRKhldKHCRjUPrXJxqCyApTnas3VwsMbjNRmDr745YdyDrC/kR0X3louehwO
QDnTpI1o6yZHwnfYa/ybz6JHROQ0n+PVcJW1TA7cvD7/uLHlX1GqhnW5T55QCLhA
EEfvYUsFjDr8GAx4z1/Gp4BKBM4Nvsa/dXt+RBGPdxpX2bBLm9vHEGonAHe6rVLR
tALAmEF1TLTzuj25TW5UL0aFiVqjGY2fRsDJzIZdagKu3ywSFpywA4AVgRPTP7CM
hJnt0k25z64Um+SE37yq1XghpdfaebRSC6XgcSDqN+pSPooeKhWFv0BLcQlb74lX
Pi/hkfoBhAmNp4SBzdVPzPIuC2Ba4dqbHv9ld/qICB11ngr1+nyzR4aY76ycsFMx
dPsuEht8f9DE+9Qz6DjasYIhYJDLhJ6bi4arJVcxYVXdEoqenWsV812pDYRGR7dL
dCVB0vF0Xs8LeGTrBM6s6TiNkTbGsChbs1DcDSIDDkCcTSURZ6w=
=3lj/
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
