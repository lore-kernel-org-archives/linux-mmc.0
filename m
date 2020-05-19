Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_BL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A2C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C8D20756
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 16:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgMgoHQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgESQYt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgESQYt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 12:24:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A4C08C5C0;
        Tue, 19 May 2020 09:24:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f134so3698265wmf.1;
        Tue, 19 May 2020 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HbYmiwsnojREGBSr3iiIto18QpIAMZAWTnaELN8H+qA=;
        b=HgMgoHQpMA04iqCNcYeeSP5MhMO40YItZE2/pSoarHZjp94lsZmGr3gsdaEoO1feeZ
         ufxnqJyGdRAac5YyHV+TjjjomQwN2sNqEMFRZTGHH41rI/eg8hJh99nHIAKUavlUd8nd
         3FDxPlF94j1uwBTIdreiAKkHy1IMlVY5ll13ZQyipkpWwIv9v4ogsuyKOLaMSyHDGmj+
         6iNkRyuabRn6XxyRwSkQrgEPrjfCnjGU+/DKR2cDLbjXPHOEY9eW123/YBZrH6SDgBAW
         a1e2dThzwa5xem0NFlK06dcj3rwAbNrBu9VkKsRcubWk/0u9Rvv+SqZnRZdeo61DzWTu
         oYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HbYmiwsnojREGBSr3iiIto18QpIAMZAWTnaELN8H+qA=;
        b=fG+kfebCqnyb4U4V5ExctwqBXcM9HKbdu2DTt6+PgqxXeMnmRMM6uoK90sFT6fn9Vf
         XorLV5sGR/c6glL/XWptHVvpJiCLWeep2oqmwcZWCk+8xwpS9B2i4WTyI3/Y2X/tOre/
         PTVCHhIJFLl5ZYFXewA+dl9Uz3Me0YzkrSU3PJgG2axldXKgGgLz5HfR/8HlwZLQOrce
         cFRzYLELDXtOkNYCGCjEUu5Xulw1MRoEMo5UQXDl6FAIdySCdXGuhi/98DdaPhJyKN3U
         dB7kop5ipXZzl4CQqmkv1t6+DTN87D+dfGP86ecAAtCLgfqg0TEqUXKl5TfBumGU0imo
         wwXQ==
X-Gm-Message-State: AOAM533ixm9i7K6kGQSVMZlSUwgRYRbIYjSkYByNs4FqMg+mGb6LM1dS
        KsKAcPsLQ9fiyMYL6kppQa4=
X-Google-Smtp-Source: ABdhPJzaPPsrxPdcksqIS4X86FSsXGyfBSVhDHOT/f2jOa5KJceE9s6wxzPkSy5pS6AJwVp7W49Urw==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr195777wma.17.1589905486577;
        Tue, 19 May 2020 09:24:46 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id t7sm20954644wrq.39.2020.05.19.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 09:24:45 -0700 (PDT)
Date:   Tue, 19 May 2020 18:24:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
Message-ID: <20200519162444.GD2113674@ulmo>
References: <20200516154314.14769-1-digetx@gmail.com>
 <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
 <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko wrote:
> 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> Several people asked me about the MMC warnings in the KMSG log and
> >> I had to tell to ignore them because these warning are irrelevant to
> >> pre-Tegra210 SoCs.
> >=20
> > Why are the warnings irrelevant?
>=20
> That's what the DT binding doc says [1].
>=20
> [1]
> https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/nvidia%2=
Ctegra20-sdhci.txt
>=20
> Although, looking at the driver's code and TRM docs, it seems that all
> those properties are really irrelevant only to the older Terga20 SoC. So
> the binding doc is a bit misleading.
>=20
> Nevertheless, the binding explicitly says that the properties are
> optional, which is correct.

Optional only means that drivers must not fail if these properties
aren't found, it doesn't mean that the driver can't warn that they
are missing.

Quite possibly the only reason why they were made optional is because
they weren't part of the bindings since the beginning. Anything added
to a binding after the first public release has to be optional by
definition, otherwise DT ABI wouldn't be stable.

I think these warnings were added on purpose, though I also see that
there are only values for these in device tree for Tegra186 and Tegra194
but not Tegra210 where these should also be necessary.

Adding Sowjanya who wrote this code. Perhaps she can clarify why the
warnings were added. If these values /should/ be there on a subset of
Tegra, then I think we should keep them, or add them again, but perhaps
add a better way of identifying when they are necessary and when it is
safe to work without them.

That said, looking at those checks I wonder if they are perhaps just
wrong. Or at the very least they seem redundant. It looks to me like
they can just be:

	if (tegra_host->pinctrl_state_XYZ =3D=3D NULL) {
		...
	}

That !IS_ERR(...) doesn't seem to do anything. But in that case, it's
also obvious why we're warning about them on platforms where these
properties don't exist in DT.

So I think we either need to add those values where appropriate so that
the warning doesn't show, or we need to narrow down where they are
really needed and add a corresponding condition.

But again, perhaps Sowjanya can help clarify if these really are only
needed on Tegra210 and later or if these also apply to older chips.

Thierry

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7ECEkACgkQ3SOs138+
s6EgNhAAqw1+R9dClbJN52qhX8PClRXnmElzmtGpuZf4cQ5wSG07AMfW5yk/9yGX
bJ3et36KfT30XOALiGf40LN2AYU8kHbr2cwyazj58f5KlAGUCUkr/CVPVDrqwWZ+
sVY5QmVZlJBZf5LTBzt7gowEtQ1eexQ3VtbgaHDxAHOJrc5n6k3JISNcYFGPs3Vn
grAGoyhj1nObR3r/4AjHXpQANSYEUUkGcYikg0yWM3MW/ATcRyRpAIYdFrIQj/3k
Q2i3lG8PCdBKhGtFom9doq+fkU72E0aBmOytJjhdxtqmWJAF0GpOgGE2hWd8o0cZ
UrNBKvY0dvFgBjwtsGfZtSRiNzJU37V7vfSFNNfvl5LPhfvlmYlvbF1YNIScytK1
/oa/sqHZygdwFJRxfuOAvat9q0v31LziUq8/eCGNGPJjxi+9TbQG1F7NBtbsXtBg
YvV3m70VOF7tPtRbWiHyPju/DEgM3tytIE8EluOMOYc2hxCO1K1qeBR9ujgB5iVo
cEUq/Ho4QvN9Taa+d/PrDb26PQiHKRPoU/z8W7Ni+S0VW1xm7Rf5XZ8pGnD2gwvp
QrBbF/r5zzs+XNUIBwBHBrXHRvV5UqDX092lrR0kbBfXNhWQCXq9ZyR2gWqrevtl
iGiH2A/0+xWGKXDZYVX2hT4ZfZD5YZztQqCP1KZ50m3k1h/7msg=
=FLne
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
