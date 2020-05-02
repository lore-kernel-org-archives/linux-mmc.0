Return-Path: <SRS0=6pTx=6Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06208C3A5A9
	for <linux-mmc@archiver.kernel.org>; Sat,  2 May 2020 17:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC64820787
	for <linux-mmc@archiver.kernel.org>; Sat,  2 May 2020 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588442149;
	bh=y6AytE7dr/RyFoctZ/9QYQjsnxyU49JgeNfyVZE/xx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EHA1xLkGTT4OJRmyvAb1ipw/zjNXZKQybVwBL68KhkriU90OdlK7zsXktPAddeq4p
	 jLVNMhER3mZKkW4b8UJtXCEglwtAm4+LRmi4HMTTf3ZQkigxvfj6ApOlz/PtPe7YX+
	 qyEWko9Eod0Bq9AIxsPJilm65acQM9mHPI+REVlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgEBRzs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 2 May 2020 13:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgEBRzs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 2 May 2020 13:55:48 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3772075B;
        Sat,  2 May 2020 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588442147;
        bh=y6AytE7dr/RyFoctZ/9QYQjsnxyU49JgeNfyVZE/xx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQ1MKSH0zDQOKkPE90TNycFGQi9RJ9MedGUDDoR0hg/ekqymH1BauTgxLlmbwVoOZ
         f17tMocC9MmWKnOp4EddRqhnPoKG3HwnXKg5GihHEm6Lmdnsy3zBV1VIz9esH+yH7i
         ht95hz1S9sattE2olW6OnK3L8OfkUNqe3GWVCWTM=
Date:   Sat, 2 May 2020 19:55:44 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-esdhc: update contact email
Message-ID: <20200502175544.GA25220@ninjato>
References: <20200502142840.19418-1-wsa@kernel.org>
 <7298908d2397b2e753b844b690ef522c728d90a6.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <7298908d2397b2e753b844b690ef522c728d90a6.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 02, 2020 at 08:39:16AM -0700, Joe Perches wrote:
> On Sat, 2020-05-02 at 16:28 +0200, Wolfram Sang wrote:
> > The 'pengutronix' address is defunct for years. Use the proper contact
> > address.
>=20
> Maybe add a .mailmap entry?

Yes, it is in another patch:

http://patchwork.ozlabs.org/project/linux-i2c/patch/20200502121840.9544-1-w=
sa@kernel.org/

Thanks!


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6ttBwACgkQFA3kzBSg
KbYaZA/+IZBPeOIhOe3VVZh3ZNuHdu4YRX4gZo17UktGpIWzgkP6taLHJc51DRMW
q7J+oHE4+UH1mVbSOkufxYQPxb2cq+ImbtCab9mWkcOcSCwOclqUDWLir//i79jJ
dgJ/PJ3l7/OvKBk9bUdo1+EA3k8LDmEqkBfuQ5r6Ck8CZtBNbBMjpDyIcTtnZ6kF
qOGr8L39YBiuVbIanWFkVqUlzucj9F2ajpDit5uifmRprimOsjWKUNdgH+yg45ql
78hxIA3O7HRD7y0Y5KyDDc+impiD2k3ic4F5+ul3Pqg6UxosgqNaDRi82lytK2ME
dQYTo3gkLRZ0p19+CZ/kXLCnSQh+fZNDb5gsSVwUvsNalKhS2AM1HJm4tofJDCxI
xr6fEJZJAcFG+kDkGuNaghkPGb1tY2k6TXEEh6dvdvdX41F33qFu8iDLjiWIxcnW
A31REPBgMTBOKYbiyQEY+a93ykRnCf4PImIdZnfutY0oKOOKmUA3g6xUSUBH4nGP
i1eMhHIX5Gk0UnmA74Kbk8VzHRjQpOsRdiDAXHiXjX6XjgKrmlrgyrcAzdPLJMS3
dwz4mei4kgHWg9BTM7xO81O562nGk7fDJJXMwW6cNw1PGMxb6qf8OhBB+gFVLJ8d
Zx2KHLqTSa3Y+YEGXwJX8cqax1V0uAGVmBPRAi8xCBthvgdDN0Q=
=XYSF
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
