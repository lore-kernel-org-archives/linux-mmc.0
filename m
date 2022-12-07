Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6FBC63703
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Dec 2022 00:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiLHAEf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHAEd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 19:04:33 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 16:04:32 PST
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFE5654D;
        Wed,  7 Dec 2022 16:04:32 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4NSDVZ4pdGzyZs;
        Thu,  8 Dec 2022 10:47:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1670456872;
        bh=ONOjK3dYbWOEBtvtjotNLoELgyfYFxkLhe7AzFHetog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LGr7bVvmtTiqqZgMe0P8ago4iNcaJXMhKNvgG0v4lM/hIPdhvZqx72FaQsmTnFWCp
         W8j/74Rn2xXsUr+HhQeCo0Vd+HqOfpN6lBL1V4Hb5fXZUPbpLi5MhIliJTmo7k00tC
         Qiy3fmPvtxFiupxkYgiFMCypWpO6Mm5rhkTSoyu/TU0J5hOc8TB+aXYf0Q4LOrNmAG
         bwsuOght/eKRJVZuzl/TY1rRAkKFAUpgygudobK3OMtMePIJVhtqWw20x7HRVaE3JG
         1h9cKZ9z8ZsEF705+D+kP+WazSTg5YuC35/lpsGoLudvYmZQrPwEbEOhpQi7tN0zpu
         glvQuvVw90JzA==
Date:   Thu, 8 Dec 2022 10:47:49 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 0/6] mmc: sdhci: Add Tegra234 support
Message-ID: <20221208104749.5a79482d@oak.ozlabs.ibm.com>
In-Reply-To: <CAPDyKFr2BzeE6N+ZDXj2HE2SEL30CkpvbsRP4wAPnFRHjP=miQ@mail.gmail.com>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
        <CAPDyKFr2BzeE6N+ZDXj2HE2SEL30CkpvbsRP4wAPnFRHjP=miQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gu_R17B1uv6YJ_zD+jJ6rxB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--Sig_/gu_R17B1uv6YJ_zD+jJ6rxB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 7 Dec 2022 13:37:52 +0100 Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
>
> On Tue, 6 Dec 2022 at 17:59, Thierry Reding <thierry.reding@gmail.com> wr=
ote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Hi,
> >
> > This is an updated version of v12 from a few days ago:
> >
> >     https://lore.kernel.org/all/20221202152644.29450-1-thierry.reding@g=
mail.com/
> >
> > The only difference here is a fix for the included headers (bitops.h
> > does not have all the definitions on all architectures, so we need
> > bitfield.h instead) and an Acked-by from Robin on the new Tegra-specific
> > helper.
> >
> > It'd be great to see this go in for v6.2 so that the new helper is
> > available for the next release and the other patches that I have
> > prepared can be merged.
> >
> > Ulf, given that Joerg has acked patch 1 and Robin has acked patch 2, I
> > think the expectation is for you to pick up the whole set. =20
>=20
> Applied for next, thanks!
>=20
> Note that, it seems likely that we may encounter a merge conflict
> between the mmc and iommu tree, due to changes in
> include/linux/iommu.h. Although, if that's the case, I believe the
> conflict should be trivial to resolve, so let's try this and see how
> it goes.
>=20
> Stephen, I added you here, just to let you know of what goes on.
>=20
> >
> > Thanks,
> > Thierry
> >
> > Prathamesh Shete (3):
> >   mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
> >   mmc: sdhci-tegra: Add support to program MC stream ID
> >   mmc: sdhci-tegra: Issue CMD and DAT resets together
> >
> > Thierry Reding (3):
> >   iommu: Add note about struct iommu_fwspec usage
> >   iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
> >   mmc: sdhci-tegra: Sort includes alphabetically
> >
> >  drivers/mmc/host/sdhci-tegra.c | 69 ++++++++++++++++++++++++++++------
> >  drivers/mmc/host/sdhci.c       |  5 +++
> >  drivers/mmc/host/sdhci.h       |  2 +
> >  include/linux/iommu.h          | 25 ++++++++++++
> >  4 files changed, 89 insertions(+), 12 deletions(-) =20

All good. Thanks for the heads up.

BTW, it would be good if some of those long lines in comments were
wrapped ...

--=20
Cheers,
Stephen Rothwell

--Sig_/gu_R17B1uv6YJ_zD+jJ6rxB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmORJiUACgkQAVBC80lX
0GxmGAf+MchS4vAaArmM1OjZTveGacIEObkHS8STEd/VT3dDWrK8a5IUmpC7fki/
EeO7jMbWJrLbJ/MewlWgW87I/QaP3r5LqcOIYiJzBfY0RE//RYqbHGO+WBvI2/RR
dbKHMjGkh+WUcJGpZWOEsUNKMgh4Xgpg09ayr8CFZL8R3FjuZQkiorwgrTui5wyB
HgmJCe7DwRpTMaeBXZ367CEGkNuqB4G+lBEeCAcOLyFdwxl4BqC6pZYpKOWZH70H
3006ACbMnUnaHxSLaPqMdZ0lFMzjyuW5Oco7wMeAKFL6yguB2FJqhDH9bobFcCcW
ZYc7WZNUYRlvSFJqhkjH/+G3pnkAjg==
=Ue2K
-----END PGP SIGNATURE-----

--Sig_/gu_R17B1uv6YJ_zD+jJ6rxB--
