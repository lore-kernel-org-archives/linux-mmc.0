Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E17C4708D
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Dec 2022 00:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiLHAE3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiLHAE2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 19:04:28 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A7F7B;
        Wed,  7 Dec 2022 16:04:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so89474ejb.6;
        Wed, 07 Dec 2022 16:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09yFi4TXhEKbvW2/X5YzYxYv1R9+iUTjSTTQ7wd1bnQ=;
        b=MpQ9JnFQ/euUsZ/W8OFV4ShAxJSfk4Uj+Fh5ObXvfcEN/hxXWwIXtzZXxPTbiGdBqy
         kZLlS8+RPqtgg0VJ6KeueqWQoJTozjN5cnJ62fiv8r/Q+wzr5w5fIZEmI6fa70uZrQ2B
         R+OX3CaFxKJBPcEJYTazGjqI5suxpWUuLJThQgBBwiYjUnIgvet+Vzw82fBzAFNnXT3M
         EjIP+EitzyNzXbBSNFlSjN/SroLmlxNCpVC4vc+6AINXRsI8JzOXDbpwV9pr6l+2pV9Z
         dXVlTNiQACcV9uPWHZkK2vJThmnr3F9qx4teZOTXdLgBab+gRutVqMyqNj5Ac2TZFXxq
         KZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09yFi4TXhEKbvW2/X5YzYxYv1R9+iUTjSTTQ7wd1bnQ=;
        b=pilbJu1r13CoFM0gaQeGfNarNiIm+mjPJuVpZv5txlnzIQ/WXaa00kUTs+ub9nwvCR
         OaK67hJLQKwwxOJwIu8DopLDzzPuaVMG802WNpaeE2eC0LnmGCoOpfXO+cxXLEGz3mHv
         897OuKLsts4fnQIdmK41CFGCTiCBVLTwjKga9WvxU4fpjN8Rs1oFjZOwWjrHONSLYtgz
         wxS7ORjh0Mf9h5Ov8qymEoHOX5/qXChedjubf4B5fnM267vyTkQV9KQOygFcsl4doT+V
         f1PtKIepnW/ThpX0553cZ13qjRJFH0RlMhK7R8icbIiwLxLIlXcNZMyHTof1rFeLlOgN
         h+rw==
X-Gm-Message-State: ANoB5plCjiZZFPDWvpV5kYw5vbK/EjHOBIGq0BXKz+tnefVy6nNmPTOW
        oWZ1ggi7ptgo4P/uqIRrRV0=
X-Google-Smtp-Source: AA0mqf7ix9VqiSrzOCVzD1oVQR95GIG6qQ9oCQEo05Kw2TypymU86K66teos7Ddte4Szx75gO7+V3g==
X-Received: by 2002:a17:906:160b:b0:78d:dddb:3974 with SMTP id m11-20020a170906160b00b0078ddddb3974mr77961094ejd.411.1670457865683;
        Wed, 07 Dec 2022 16:04:25 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0079dbf06d558sm8996047ejf.184.2022.12.07.16.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:04:25 -0800 (PST)
Date:   Thu, 8 Dec 2022 01:04:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 0/6] mmc: sdhci: Add Tegra234 support
Message-ID: <Y5EqB7v7m2XSkpn4@orome>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
 <CAPDyKFr2BzeE6N+ZDXj2HE2SEL30CkpvbsRP4wAPnFRHjP=miQ@mail.gmail.com>
 <20221208104749.5a79482d@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zl3rVGReu28PhYjM"
Content-Disposition: inline
In-Reply-To: <20221208104749.5a79482d@oak.ozlabs.ibm.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--Zl3rVGReu28PhYjM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2022 at 10:47:49AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Wed, 7 Dec 2022 13:37:52 +0100 Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
> >
> > On Tue, 6 Dec 2022 at 17:59, Thierry Reding <thierry.reding@gmail.com> =
wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Hi,
> > >
> > > This is an updated version of v12 from a few days ago:
> > >
> > >     https://lore.kernel.org/all/20221202152644.29450-1-thierry.reding=
@gmail.com/
> > >
> > > The only difference here is a fix for the included headers (bitops.h
> > > does not have all the definitions on all architectures, so we need
> > > bitfield.h instead) and an Acked-by from Robin on the new Tegra-speci=
fic
> > > helper.
> > >
> > > It'd be great to see this go in for v6.2 so that the new helper is
> > > available for the next release and the other patches that I have
> > > prepared can be merged.
> > >
> > > Ulf, given that Joerg has acked patch 1 and Robin has acked patch 2, I
> > > think the expectation is for you to pick up the whole set. =20
> >=20
> > Applied for next, thanks!
> >=20
> > Note that, it seems likely that we may encounter a merge conflict
> > between the mmc and iommu tree, due to changes in
> > include/linux/iommu.h. Although, if that's the case, I believe the
> > conflict should be trivial to resolve, so let's try this and see how
> > it goes.
> >=20
> > Stephen, I added you here, just to let you know of what goes on.
> >=20
> > >
> > > Thanks,
> > > Thierry
> > >
> > > Prathamesh Shete (3):
> > >   mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
> > >   mmc: sdhci-tegra: Add support to program MC stream ID
> > >   mmc: sdhci-tegra: Issue CMD and DAT resets together
> > >
> > > Thierry Reding (3):
> > >   iommu: Add note about struct iommu_fwspec usage
> > >   iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
> > >   mmc: sdhci-tegra: Sort includes alphabetically
> > >
> > >  drivers/mmc/host/sdhci-tegra.c | 69 ++++++++++++++++++++++++++++----=
--
> > >  drivers/mmc/host/sdhci.c       |  5 +++
> > >  drivers/mmc/host/sdhci.h       |  2 +
> > >  include/linux/iommu.h          | 25 ++++++++++++
> > >  4 files changed, 89 insertions(+), 12 deletions(-) =20
>=20
> All good. Thanks for the heads up.
>=20
> BTW, it would be good if some of those long lines in comments were
> wrapped ...

Hm... looks like I misinterpreted the checkpatch.pl change from a while
ago. I should probably switch back my editor settings if the preference
is still 80 characters instead of the 100 enforced by checkpatch.

Thierry

--Zl3rVGReu28PhYjM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmORKgQACgkQ3SOs138+
s6Gmzg//Q2E3eo7bIzRh+yuhkK4tU3jadK0bUBvmNMKSjWjt+IKb8ntT9sAqH+Mi
50tGNrbJWDwoWEkYcZlAWUFPvx0+X83eVRLGQO4VUU5+wih8jsvj48bfwdrhMh6T
EkWKs8JhCDYMUoRUSrIiELdexns6pP35D2WCCNI3VYr9pAJm4Wh+14oSqB5Uu23J
snl9mu6FoBHeEIvkvDZGfi4uQ2zX5vmQq3/6P1etSgQITiJKLIwuxxeTshQymY12
Qd2kBdGstWtpj2OjZhCapb+OjC4GgwHZqmoy8kPjUfe8K6b/9nhw7/HOC/ztmO6d
V3LywfbBVh8q69HWd4de121vlYwP3/IKcVIFYVIkSIvW40zoyZ3NeMLMlpC2LE6C
GXxZhXj9ZfSH5B0IaOUbBOYo51WQY3cCg0dyfzwJm907BqWUrTkV0YBeva6/x5U3
BVvsJUT/2MLNPBtD26XUEKn//Vu9KZ6UkAhI+2w0u6Tj2ivEGomgLDmQ/CweSy/L
F3zP21iqnuah7+U9YEwDmdp35z8Zizhjn7XKHpjprbDrd2oz7if/vq7RwUYjDIUI
bJJ2U1vKCneN2oyGI1rxJP7/mdBaVe0G3gVpqt/LecKLCtQ7Z/JCZW/yLW5nId9i
dPtGB6SyMOb17OKaL+NlFkVPdPC2b8BPbRSbfnTsbauXl/tHLEQ=
=b7jI
-----END PGP SIGNATURE-----

--Zl3rVGReu28PhYjM--
