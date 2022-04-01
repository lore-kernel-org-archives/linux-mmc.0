Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70CC433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Apr 2022 16:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiDAQaM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348969AbiDAQ2E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2022 12:28:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E924BD0
        for <linux-mmc@vger.kernel.org>; Fri,  1 Apr 2022 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=U9mglw3sp1c6pqKAgLM4I/FuCr3Z
        1BAfVXkgJrKDtg8=; b=Q9/8ssP2OOXjaMTB8JYfM8BWRTrG9VQldVanfMLAHCyj
        2EvQZ7CSyZGmLOS7LoLqN8xnAOyxjJI6Bc/Ac/qZNH1EWHtbLxvC/IL9KCju+NVV
        pqFfqDSt6BrAE43ZY5vOdQVJ6pcudDDrdD9amX+OB1B0Q5wJIHzeCBBBEJBrNw8=
Received: (qmail 794846 invoked from network); 1 Apr 2022 18:01:03 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2022 18:01:03 +0200
X-UD-Smtp-Session: l3s3148p1@xqGv4pnbbKYgAQnoAGGbAFirbAEmXd1u
Date:   Fri, 1 Apr 2022 18:01:03 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: Add missing checks for the presence
 of quirks
Message-ID: <Ykchv+A4jijyOtbT@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cc3178c2ff60f640f4d5a071d51f6b0b1db37656.1648822020.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XPcqMus7IWjHyVZr"
Content-Disposition: inline
In-Reply-To: <cc3178c2ff60f640f4d5a071d51f6b0b1db37656.1648822020.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--XPcqMus7IWjHyVZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 01, 2022 at 04:09:28PM +0200, Geert Uytterhoeven wrote:
> When running on an system without any quirks (e.g. R-Car V3U), the
> kernel crashes with a NULL pointer dereference:
>=20
>     Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000002
>     ...
>     Hardware name: Renesas Falcon CPU and Breakout boards based on r8a779=
a0 (DT)
>     Workqueue: events_freezable mmc_rescan
>     ...
>     Call trace:
>      renesas_sdhi_internal_dmac_start_dma+0x54/0x12c
>      tmio_process_mrq+0x124/0x274
>=20
> Fix this by adding the missing checks for the validatity of the
> priv->quirks pointer.
>=20
> Fixes: dce2ba8b2ee8cef6 ("mmc: renesas_sdhi: make 'dmac_only_one_rx' a qu=
irk")
> Fixes: d4bfa17a655c6de2 ("mmc: renesas_sdhi: make 'fixed_addr_mode' a qui=
rk")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for catching this!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--XPcqMus7IWjHyVZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJHIb4ACgkQFA3kzBSg
KbYUig//YrC0ADFQuB6sipgrC3SEYoflvJs4zX/0TwFG6mAtfHRkqD5oG6FCheDy
Nb3irOdej8JrogtQDWDeiwILKln0JllBm5idrupDczO23ur6wFKvAAwjaBS1vcd5
9nzbJgCpspsLkPwJKJgA65NCqZ5Q6wy2DsAeYm1SfTp29rZNd5KHh/3iBpBHboK0
HC00gP+Ce8Y4dZZRFXO58HD0zW1hZOnSzJCYI1pS2VHD8/SOapyzdSwNkgouSt/H
UnlrO/ILRfRo3Vhd6/O3VA+inuLbG5pjegS8HjhE7q/6wTvP7vJx+D7445PasQeU
DGyEiJsT/bS43eLW/ARNT3o8i7bRIFQssD2MrA7ANFAYCN0m4PkC6wItnHy98EfV
gElmyPRTRkRCnBC7cfCgDWw4e5OfDPFwk90ghc8Ts8Qu5WpxLJlHbvQvi+1pVfnc
N4ssEfzJ3j8VYHQIWK7k7B9QpQWu0WYlRBgl9N10/9TbqIDmStM9OSCFyfp7IDIf
D0VSNas1xaRMZ+BdayK6bvmHsIKxVwFHe6zgiTpILQj2C64YmTCh4P5DzCCgzK1t
J3BKKcF5HrK8X9O+m9CF9alqExxMc59UcBMacnvRZucUKs+5vf64bGSxzcFcsBg6
QoNsmqktT6a5Mtg6vFDr6QhVispFBsPctEVQ0DdD3ebK15mkjS8=
=STW6
-----END PGP SIGNATURE-----

--XPcqMus7IWjHyVZr--
