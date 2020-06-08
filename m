Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36656C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 21:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5DF2076A
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 21:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IjiDGA+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFHV1E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:27:04 -0400
Received: from www.zeus03.de ([194.117.254.33]:47966 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgFHV1E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 17:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=WUtagRU3g82ExRNn7D1biyJuJW4q
        PcLsdg41K1ak1Z4=; b=IjiDGA+VB91wi74TeiYO7piJXtggNmfsc+zFBhI9QMR/
        46FmrQUWcCo+DT10K+cqYngPkHgcDuT9MKsKa695UvBgj43wR0TdFCSLRESShFsp
        XDj8d1LlNSoakFFdqcnl4NY5VpCsEt8l3eTBe0NNhEJ69Uw4UArla/wxOm53WWc=
Received: (qmail 3147057 invoked from network); 8 Jun 2020 23:27:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jun 2020 23:27:02 +0200
X-UD-Smtp-Session: l3s3148p1@aA6URZmnKIQgAwDPXwXUAIYwoJSUoKNc
Date:   Mon, 8 Jun 2020 23:27:02 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: keep SCC clock active when tuning
Message-ID: <20200608212702.GD917@ninjato>
References: <20200604112040.22144-1-wsa+renesas@sang-engineering.com>
 <20200604112040.22144-3-wsa+renesas@sang-engineering.com>
 <TY2PR01MB36923A1D7091431CE3F73195D8850@TY2PR01MB3692.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <TY2PR01MB36923A1D7091431CE3F73195D8850@TY2PR01MB3692.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	/* Tuning done, no special handling for SCC clock needed anymore */
> > +	priv->keep_scc_freq =3D false;
> > +
>=20
> Setting keep_scc_freq to false is only here. But, I'm thinking
> we should set it in some error paths like below somehow too:
>  - error paths before hs400_complete() in mmc_select_hs400().
>  - error path of mmc_execute_tuning() in mmc_retune().

Hmm, I guess you are right. That would kind of spoil my approach taken
here. Maybe we need another flag in the core like 'doing_tune' to
supplement 'doing_retune', so or driver knows when any kind of tuning is
going on?


--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7erSIACgkQFA3kzBSg
Kbbn1RAAhE/rLNgZtVHTTSY62gEMuwVKYtXCu3n79wQGRVLKAbEgL+My4jAEMaQ6
D2OCdOZggJp8auuT473zjfXf8tKtMP6nQWf1ViopAawj7GS6oitwi/iPkPBbG/tr
ZIOL9YoK1Gg0JEQhE376SRAyIPeC8l4q2rvFDgGM1FhpKa4i9H7V9bA82vZSvyAx
RuAN0TDmM72g9Fm6nD5oY/l5bXN2d+cyB7WsrIoLAigNQD9tBsqE3e4aRXSFYS25
z67igCDSEVUuTzXEWs1AoYQJnrkhyBT0Q5vSxiZ1O2pFmQ5IIWUD/BBFxAyAYSW+
jRowL54vaqFwPKQQB61bVAUyExK0TIygDnF+P6wuNwRrvcVem7lyp4v0/tR5blaZ
eewhrsE4i7i6m1/ENS3WZmz8VxqrvGaj+0fFhcawSHEKke2XsBf7CRiD6ns1b7HD
+IJTxL0XLDzVxKIG81FL7FfXwsj/H4veebEWsGNZAe8brRnk+vZzbKLs67W3I0E/
0jQ/a/bVlmE9eTenWQS9TDZdN+/g2wa2cmC+rhaq7il71yZrKuZBnnvBq+AH8Dtg
mCRJQA6w2aobRgngqbqqEyXJflf4G663VSAr26iUnd0azMzrdH1YjQsWAmnP07a4
PMbOR699kYNMgxttdoC8nmhF3HkPRRCSewBPPGUdAhKUTEqgFOM=
=SS9v
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
