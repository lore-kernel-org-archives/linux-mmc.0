Return-Path: <SRS0=9HeC=D6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC3C388F9
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 08:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955372463C
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 08:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkeiAMjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460737AbgJWIpw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460732AbgJWIpw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Oct 2020 04:45:52 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C83C0613CE
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 01:45:52 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g7so608170ilr.12
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AkUiMBfsIhoAS249PFqvmz24TB4SHa/iGAfw3nzcIr0=;
        b=OkeiAMjNVotmG5U1+oU2Ecxmcrozqq6Ayc0z7mPDQbeU0ZkiMNmOp3EHJ7CeeDayS3
         uj+sfsgecam9koFSANmehdfgu6rEuSNyvf6PgFn65dZthISnNBszwWpuZDzXINFV++Hf
         XXH6K4WwBHPWGzFcrolKCHWfNCJQmGwU0XF/cEi2HrHMETIf+YQiX0+HpAD3aAFPCw+X
         wpdvH9ZE+fGfgOBTuJM3x2p7DPeYxFGayLb1e70RcB2MXdkT1HghaQgE2gIAoM31W8u0
         mGnlnkWjX3AdHzRo7H8kUlddFIs8dSlWyHT15LbFnqa7/MTYORARPCxvOZXeBv6S8zjU
         Xnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AkUiMBfsIhoAS249PFqvmz24TB4SHa/iGAfw3nzcIr0=;
        b=jOO/jkrDB/jiynq5LigB0wFZC/HzmB9m90Rqd1p0RKSv34dOY9WkmaB2KQlBkjJE3g
         GF8KNIeDOY3wkKwG//USok2clcttCH94VxwZfM2u7xkjV3V/mLoOPATh09IxcthCAQ84
         dCnjztIX8RQO80cMQ/CEy7eYKYwBdz0f94NFgGUzNELLzjhkfMVxsXTkBc4H8csfte0M
         4k+BFUaMa5TVmKO4cCo7qSfS4ytVMU0n9t0WHkciDIkzB8hsAu+Q0TjFLOEYQimfhjpD
         f0cdnM3Jh9b+H90TlLxZS0I5wrKLOZ6U1LuQlAc1Uky8llRxd8cUoVKltkZ/xhl4Nc0c
         BTvg==
X-Gm-Message-State: AOAM5320x+jcEZ4Je3Wrdqzssy6+45/h/VsWvAFtuIJ+lgz/d20NAHw1
        aRXqgEYbnTTF9GfB/16h/7CV1QV/9XdCOUHz1po=
X-Google-Smtp-Source: ABdhPJyMDm7WNZcDic3eYjWfAJaNoI72TcmloU6jwAwWVuRKvXnLe61NdVY0XT9BwtCdcruLiyRkNHlnByHoNrsi6q8=
X-Received: by 2002:a92:dc8f:: with SMTP id c15mr870032iln.293.1603442751622;
 Fri, 23 Oct 2020 01:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
 <CAJiuCceLR_zfyA0zHyRrqZ46DoQ6Ju-xVaa2Rf_PkjDkPOR8JA@mail.gmail.com>
 <20201022091337.3u5ya3jouhmaukcj@gilmour.lan> <CAJiuCcfyx734fo52VU4t5jF6pZ7vcg4VR1HhWMzg_UW9Xfaj8A@mail.gmail.com>
In-Reply-To: <CAJiuCcfyx734fo52VU4t5jF6pZ7vcg4VR1HhWMzg_UW9Xfaj8A@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 23 Oct 2020 10:45:40 +0200
Message-ID: <CAJiuCcd1O0OVeJSmqa=srOOzwuKciqKbm4Xbh+dn4XCycSbLAg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] Disable HS-DDR mode for Olimex
 A64-OLinuXino variants with eMMC
To:     rinni@inventati.org, Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Philip and Chen-Yu

(+Chen-Yu added as He also have the issue for H5)

On Thu, 22 Oct 2020 at 17:39, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Maxime,
>
> On Thu, 22 Oct 2020 at 11:13, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Thu, Oct 22, 2020 at 09:52:29AM +0200, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > Hi Philipp,
> > >
> > > On Thu, 22 Oct 2020 at 00:10, Philip Rinn <rinni@inventati.org> wrote=
:
> > > >
> > > > Hi,
> > > >
> > > > the Olimex A64-OLinuXino board comes in various variants, three wit=
h eMMC.
> > > > While MMC HS-DDR mode works fine on one of them (A64-OLinuXino-1Ge4=
GW) it
> > > > doesn't work on the A64-OLinuXino-2Ge8G-IND variant (I don't have t=
he
> > > > third variant so I can't check if it works there).
> > >
> > > We got similar situations for Allwinner H6 (Beelink GS1 and Tanix TX6=
).
> > >
> > > There is definitely an issue in the MMC sunxi driver with HS-DDR mode
> > > and it's not limited to "olimex,a64-olinuxino-emmc".
> > >
> > > Have a look at this this message posted by Jernej:
> > > https://www.spinics.net/lists/arm-kernel/msg846093.html
> > >
> > > I think we should disable the HS-DDR mode for A64 / H6 like it's done
> > > for H5 and not disable board per board until the issue is resolved.
> >
> > I'm not opposed to that on principle, but "it doesn't work on some
> > board" is not a proper justification to do so. It does on some others,
> > so surely there's more to it and this would just paper over whatever
> > issue we have instead of properly fixing it.
>
> Maybe the term board is not correct, maybe it's the eMMC chip which is
> different.
> I don't know if all Beelink GS1/Tanix TX6 use the same eMMC chip for
> all the boards.
>
> >
> > > If you want to disable only for your board you can set in your
> > > device-tree: mmc-hs200-1_8v; This will switch to HS200 mode without
> > > using the HS-DDR mode.
> >
> > Sigh. Can we at least work on a fix instead of providing terrible
> > workarounds?
>
> I agree with you on this, but my board doesn't have this issue and I
> tried to read the vendor kernel and spot a difference but didn't find
> anything relevant.

After reviewing the correct file this time :P

I catched a slight difference between the mainline and vendor driver
in DDR mode.

the phase is set to 1
case MMC_TIMING_UHS_DDR50:
case MMC_TIMING_MMC_DDR52:
dat_drv_ph =3D 1;
speed_mod =3D SM2_HSDDR52_DDR50;
break;

Could you add a hack in DDR mode and see if it's working better ?

Maybe line 738:

#define SDXC_REG_DRV_DL (0x0140)
#define SDXC_DAT_DRV_PH_SEL BIT(17)

rval =3D mmc_readl(host, REG_DRV_DL);
rval |=3D SDXC_DAT_DRV_PH_SEL;
mmc_writel(host, REG_DRV_DL, rval);

Regards,
Clement

>
> Regards,
> Clement
>
> >
> > Maxime
