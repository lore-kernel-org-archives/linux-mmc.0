Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2AC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 13:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiK3NoY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK3NoY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 08:44:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A440915
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 05:44:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7550B81B4D
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 13:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD3C433C1;
        Wed, 30 Nov 2022 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669815860;
        bh=b7LKg369rr3t6oT3T0d41I0LahT6c212/EGL1D/rMuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfhTf8/u+L+i211L6MZ2ZBvWmW3OPqWQFdC+HGuBfYogZr66DSdYgNXQD60FCRXoi
         3equTvVl33/o+6VZ7uSJ3L7m8b7trUZmrrhZ9AWPWhhPFVfcXZzwSZmPi2nylCXpXy
         do/kXsT5ihcO4a3Bkv2AHuiDo91nuotDioySlG5ezLEWgqstQTRQbnr33SmdC1+7A9
         fsi9cWaD67247C0KQI3v2D8a0kKeQw0Vn2v/JFYfbbBOSr/T+dY/Em66XVPGU/rlz8
         R9xvwDaSpsZbP0k49SfrrQI5aD4qiXAGf1Jm2eu5KwUf8zRsP1AjGUk9WRKWtyk55K
         sTmcd3NoE7jlQ==
Date:   Wed, 30 Nov 2022 14:44:13 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: Q: mmc: core: Issue power off notification in mmc_remove()
Message-ID: <Y4deLRinRtHoJoYL@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <Y4V/+jJxnQur4M9s@shikoro>
 <CAPDyKFrX8pzDDs6k+TBmDhrrgLSkORfmGdiGX4Mbuvjg-Xhmrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sjG3cnzZFL5fS0/h"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrX8pzDDs6k+TBmDhrrgLSkORfmGdiGX4Mbuvjg-Xhmrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--sjG3cnzZFL5fS0/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ulf,

thank you for the quick answer!

> If I recall correctly, when I started looking into a solution I
> stumbled upon other generic card removal issues that triggered various
> splats. Some of those issues have been fixed [2], but beyond that
> point I simply haven't been able to look into this again, my
> apologies.

No worries! I just wanted to know if I can close our upporting issue or
need to make an action item out of it. The latter it is. Let's see who
of us first finds time to actually look at it again ;)

All the best,

   Wolfram


--sjG3cnzZFL5fS0/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmOHXikACgkQFA3kzBSg
KbZ0aA/8DWun+l2iW6E/J/eGZLsNDoGEwPTyOJ/TH+aYXuQfuGybqoCkceE6eXvV
EKqmN2NOsQ0LGSyOsSRig4hJ0TFXKGNU8MBIz7IEl6sljCVErpQULOFKbv9kznE5
F9GZJiYMxL/FJU1RUYoeufO16fzcAvgZWj8nlhiuTIZuYwr35ufC9n4rNKI2ctc0
ggqqiyvCuQEQIxOQPl6l35mDcYVChKNILxgS/HNlsSF3S+C/Y+x9Wj3BMNHecuK2
KetqZhgUCoKhNSZDqfJ16h4yiaZESmiacimzAWyOnXSp8l16dHrfgdOYBIb2ZbJt
fuvGFqPdaPPkveGs1DXG62fYavaIrfzUMUI0gRPMbtPFlFU5W69S1O89zv5g4ux0
uObMPFVeRAOe9SoQLZiNT/z6YdXF4Ds1GkMggjlEgrgbS2c62HU/wLh2lrI9zf/1
jAmzKjheGTwzwMl5BpKMjUVbMwPalpaiUOk29BbjGt5/6vG0CdHnr3qeJafN0ZPj
spnaIKZ+02cW5dGW2NHUw7YnSwW9BqHDTlNMwCXJsiFomstKyt77eqm2tcauyHbO
kSPH7JswzBMee61m2qL1/CRmKTWOHiuabyFOwgBgFD8Q8Co1txVcx8Yd/1t8E3Xx
IFF2Cozf68w/Ndxcx13yodyHMjZjx8tn0uypn49sWftc3ZaY+Mg=
=sBLz
-----END PGP SIGNATURE-----

--sjG3cnzZFL5fS0/h--
