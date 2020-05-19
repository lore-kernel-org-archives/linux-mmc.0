Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC5C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304A7207C4
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 16:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="V56dwqRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgESQik (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 12:38:40 -0400
Received: from www.zeus03.de ([194.117.254.33]:41310 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgESQik (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 May 2020 12:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=5JZs1/4CTt+obaQ8oFThYf/Tfp3L
        KDK0pJEV6kHBwrs=; b=V56dwqRJvwmLSIeDd6X7DdTpG/sC9svh8E1gIpdJe30G
        hQolgBKnkI4iOx5WngF7LcQYkLrikpBSFSVOMicz1JCd2pfaHQoL8WCPYYhYiwK2
        tNRXj092gw+v8RuRUE2gH+IehlrpfixljwsTHYsQHuYpuODtVRQ+IV8bB4nU+0g=
Received: (qmail 328926 invoked from network); 19 May 2020 18:38:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2020 18:38:38 +0200
X-UD-Smtp-Session: l3s3148p1@q3tU6QKm+OkgAwDPXxCmAFNwG0mTH/5q
Date:   Tue, 19 May 2020 18:38:38 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started'
 while probing
Message-ID: <20200519163837.GA20235@ninjato>
References: <20200519152445.6922-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20200519152445.6922-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 05:24:45PM +0200, Ulf Hansson wrote:
> If the tmio device is attached to a genpd (PM domain), that genpd may have
> ->start|stop() callback assigned to it. To make sure the device is
> accessible during ->probe(), genpd's ->start() callback must be invoked,
> which is currently managed by tmio_mmc_host_probe(). However, it's likely
> that may be too late for some cases, as registers may be read and written
> way before that point.
>=20
> To fix the behaviour, let's move the call to dev_pm_domain_start() from
> tmio_mmc_host_probe() into those clients that needs it. From discussions =
at
> linux-mmc mailing list, it turned out that it should be sufficient to do
> this for the SDHI renesas variants, hence the call is move to
> renesas_sdhi_probe().
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Rebind works on my Salvator-XS board (M3-N) and my Lager board (H2). No
other issues found when booting and accessing SD cards or eMMC.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, Ulf!


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7EC4oACgkQFA3kzBSg
KbZVjg/8D5PSU03mcJ/ywD7OWX0Zv31JWrtMdqwGMe6Qkgla1i+APNvPBYojv5Nl
QYhjGb8sNdPTBOv/0YNu0ZP3k78VZYtOMdsP6f5+due+sK+F4kriNZOgWX3xq+rg
C6571vdsGSq7sJEWGvDdaIzhg+KtcQqOqqhsbNv12XOfvcjXo2xw7RLqvCcBDak+
nply27C7ySOJ4nDc+0gNhd2JUlapvFgD5ZacH8mmdkyQEtyO2U5fHYRykhHYuesh
sz5YGn+4c0pKdmZiMHAnmKvXGfywjfcJ0Q33h4/BDs7qAWxvr9mdX/o8hAaSgyix
UETHq8EJcb7lbwMsCxtZSZSCBSSqgT9GyKYVmdD+eKc/ao/zDXA7swiN/D5Mi5LO
PhBs/SFYSwJsS0m6cfYjn8/dy1EvhEqE6/vwOO6sEIPcUnym0VdzN4u3rfN0bbn4
fhZW3JzyJhdtViCWbKTHMIW//eT8tFAGauFauy1zuEXisJzOjyL9b9kuHpqDJrKH
pVWUMiPV+JRqZKLujeY0DlC4+XAmeZsI6V+rg9hC/DAJIBSA3CXtCBDbQur9+SZB
rApE3C4092ClLI9cxD0mnE6q80LGZeIE0PKAN4aL0zEF4OnNLqNNE2e3qOCoYruC
TmRXwWtOyfLWJn9hNwuOTMf/rFRrzWotJrVeCSSKe/l1TjG3udU=
=5dev
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
