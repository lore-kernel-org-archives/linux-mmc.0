Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9929DC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD2F2070A
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 15:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="esS2yRLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETPtJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 11:49:09 -0400
Received: from www.zeus03.de ([194.117.254.33]:48166 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgETPtJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 May 2020 11:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Cvrkr3idI65VPVCz3hT5lWc8NrQS
        ETt6evVcJSk27OI=; b=esS2yRLtDMx71sswH4mIHSQrUW+erJt9HyV48dYDZQYM
        AL4sQO3HaQAIAxolJOisKVVm1n661FvEp/eRoem41uxzMgryFifA7WDwJao+owKv
        icQHcm3166M7QeXzkC9+m/NYFNQr83aut79XKhFFb711S/xJDUTB+iQl5XV8voc=
Received: (qmail 709886 invoked from network); 20 May 2020 17:49:06 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 May 2020 17:49:06 +0200
X-UD-Smtp-Session: l3s3148p1@ks0KVhamXuUgAwDPXwjBAFv42Jy9rssU
Date:   Wed, 20 May 2020 17:49:06 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at
 remove
Message-ID: <20200520154906.GE5759@ninjato>
References: <20200519152434.6867-1-ulf.hansson@linaro.org>
 <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 04:30:33PM +0200, Geert Uytterhoeven wrote:
> Hi Ulf,
>=20
> On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> > Before calling tmio_mmc_host_probe(), the caller is required to enable
> > clocks for its device, as to make it accessible when reading/writing
> > registers during probe.
> >
> > Therefore, the responsibility to disable these clocks, in the error pat=
h of
> > ->probe() and during ->remove(), is better managed outside
> > tmio_mmc_host_remove(). As a matter of fact, callers of
> > tmio_mmc_host_remove() already expects this to be the behaviour.
> >
> > However, there's a problem with tmio_mmc_host_remove() when the Kconfig
> > option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may t=
hen
> > disable the clock via runtime PM, which leads to clock enable/disable
> > imbalance problems, when the caller of tmio_mmc_host_remove() also trie=
s to
> > disable the same clocks.
> >
> > To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
> > device with clocks enabled, but also make sure to disable the IRQs, as =
we
> > normally do at ->runtime_suspend().
> >
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> (on R-Car Gen2, various Gen3, SH-Mobile AG5, R-Mobile A1, R-Mobile APE6,
>  RZ/A1, and RZ/A2)

Thanks, Geert! If it is not too much to ask, could you try re-applying
commit 7a7dab237027 ("mmc: tmio: remove workaround for NON_REMOVABLE")
on top of all these patches and see if your NFS is still stalled?

Sidenote: we still need to tackle the problem when SCC hangs because it
has no clock. However, I am still interested if all the PM updates have
an impact in the beaviour you observed here[1].

[1] https://patchwork.kernel.org/patch/11149285/


--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7FUW0ACgkQFA3kzBSg
Kbai9xAAhTOMROnUQF0UZWSp5UjMU50H/LE7bg9qLbCiW4icqo4ZK7IYHERSYjRw
HXWTZLHtOlBpxLbiUA/l5OkzSFFmAkiNQQeObhax+ghRt1xeUr4BHG2aBly4LR9j
IZRkltLgy/DuZRDO/ZKCIhVtNSLTYiIEvZ9i8Bt8zrDt7BMT+ZsaH5kCPmWIPtru
KJ2moQiDCvaiGS3yg0N+0eoaF5Je/by0s6BVw2/1WNatZLPVp906M1zemIqDzkNH
D72KQTLQpF3B3DWNCkrUhny1oUKhete3q1ETbh1zEEGMVSOxqGgqui8m7ZoKyv0H
V8jDUN+vsH/Ix6XiD6GfpEdjLNR3SaK/WusK1W/SM1MWaYh/I9BsH59zW4sCujWK
OUI2SkOt+W3kJZ8SskRbv80yHwdeyN+1nzH0axxMuWKEKVCg6MAtTjjZubRyB3HK
dT5i4F5+uq/9WwkO+v6z22ziS2AhLxG3OKZ+w5zMYZcfIoiguNOzTvhWB/06G0ze
HEktOq5FA1HYiIeSP2XU96mcg2rxcWdsWzZFtrb4tKHUDLxrex1XR7gAN+J/t4RV
zCNC3lld29iQ38bv90qistlEJFSx4lfSJTKcfcBwnAwtzTB8sCInxDczGA11ANdX
r3R1wEWvNZZM11NF/98nXyRjN032yHD2dd+4weRsw4bJTpCQTRY=
=lvvi
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
