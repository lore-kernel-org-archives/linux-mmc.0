Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBBFC433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 20:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA51E20758
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 20:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RCd0qvsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgERUCu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 16:02:50 -0400
Received: from www.zeus03.de ([194.117.254.33]:59770 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgERUCu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 May 2020 16:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=VLSDIlzg/eoPt3BTbm1ejHdUXGk+
        z7SjU/8UKn1oQFk=; b=RCd0qvsrwaBCBoIo2GPYSEAazjkzuTjLksWd7WrWZOAk
        iz6/+jE9fwfd93g8sSt1ceb+FrAtGWPWiCrleGx6wDpfGQNTPLm/MBf/1pZmAZUz
        k8cspWQVQTerslm+jhw0V2RaHubY8P5CbwyQnTbDMvqm1SVf/dy/zGKDTKg02oA=
Received: (qmail 1150375 invoked from network); 18 May 2020 22:02:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 May 2020 22:02:47 +0200
X-UD-Smtp-Session: l3s3148p1@HJmapfGlUKMgAwDPXwfCAIWBZdj99x2z
Date:   Mon, 18 May 2020 22:02:47 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at
 remove
Message-ID: <20200518200247.GB5109@ninjato>
References: <20200515140445.15218-1-ulf.hansson@linaro.org>
 <CAPDyKFr-7OkMW0UU_M78igBScOXiY784_TkqeHHwmVdZViRw6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <CAPDyKFr-7OkMW0UU_M78igBScOXiY784_TkqeHHwmVdZViRw6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 05:02:08PM +0200, Ulf Hansson wrote:
> On Fri, 15 May 2020 at 16:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
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
>=20
> Just realized that part of the commit message is missing, explaining
> the change. I intend to add this:
>=20
> To solve the problem, let's make sure tmio_mmc_host_remove() leaves
> the device with clocks enabled, but also make sure to disable the
> IRQs, as we normally do at ->runtime_suspend().

Yeah, this paragraph is definately needed.

> Also, this is untested, so relying on you guys with the HW at hand.

I tested this on Gen3 M3-N (works fine!) and will next check your other
patch. If this is okay, too, I will check them on Gen2 tomorrow before I
give my Tested-by.

Ulf, thanks for working on this, too!


--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7C6eMACgkQFA3kzBSg
KbaQ6g//ToR/+TVWrb07nZzpiBtbv90CtBIU6TH4X/u/nGaXPO/KlfJBvrNgrTKi
7sHJSNYSQDktM9bAFxlkt+pTVBrA2EKV9ieAVbIOpv7Y9ym1dw8gPx8OZwGQIrkQ
faavTNAq5pgjq4Gu8ZrRloifD1tyE4Itt/r4kcou4X9Ph+0rfCw3KZ9pcbCIeVV6
zegqr+P5gS+uDWTdWlPtWpE1PzsT5oLGnsaLLVLXt/mR6raZU+jVbriabcGKoeTV
wAT1E3yVxS27x0HhKjNGngpOkMeeHqgYMCRiZe4nUyVKOM7tfm3hvAAcYcf4x4Ni
4GECd/6chhh/er+ayTVdN1DV5B+QqGTqYCccaSykE2p9EKGZuJrqwbw6jPDsuUg1
J8+9kgKQFGKloIVzE375iu59k7YIrojPj1bjxZwqtwtCPSmF1+opkdFtwtlYUgyQ
FSULsT7WGqmSkZeIJAdo6rhKkZchbBjBzI4UoOCyQw2pUEDdK8q/FNLO9VySPUaA
OPoQS4CeGQNVa/TNv7rNo4XyeSNOSPkCOzF2MCwhPaheNuH2jD5WxIBE5D+mUFA1
p5sPnXnbdZe6xBQaVCmW4qOQTa1QXfyuusL3YieTHsv1dIp21ui9wgomb6gHznjn
yvjdJdH2nLP+U6qFBDSiJg6Y68obIkVQzwgoHXBhLLPhCayZW3A=
=vs5K
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
