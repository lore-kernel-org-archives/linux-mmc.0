Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E67C43217
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Apr 2022 15:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348458AbiDAP5I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349309AbiDAPRY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2022 11:17:24 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3666F5EDE4
        for <linux-mmc@vger.kernel.org>; Fri,  1 Apr 2022 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=UAEs4xjn6qZx3TWXNnqKdvPiSEod
        Bq9HlT6omoJYEzg=; b=sWmX7oEjj6TnFI0iuvJ7T7vECqsqY/GVCkr1ccAS1N0l
        Wi6fXbEs2EVagW/fr+tdFS9Q2TPL3qEu2+M/wV56rrS8tBApMGs8wEuRhSc3Jzti
        VPIhppBl9zzoBOidzpRMgLoAurieZhqxw663m+lflbpxBR++o7J+86NV+vFrJRM=
Received: (qmail 777451 invoked from network); 1 Apr 2022 16:59:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2022 16:59:13 +0200
X-UD-Smtp-Session: l3s3148p1@ck+HBZnbKqYgAQnoAGGbAFirbAEmXd1u
Date:   Fri, 1 Apr 2022 16:59:12 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/6] mmc: renesas_sdhi: R-Car D3 also has no HS400
Message-ID: <YkcTQCZceQcRQo5A@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20220320123016.57991-1-wsa+renesas@sang-engineering.com>
 <20220320123016.57991-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdUso+a2UqMTZByGQryj+GvT4go4GB9EOM60D1Ue9oMi_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="01Vw34jT9viWiClh"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUso+a2UqMTZByGQryj+GvT4go4GB9EOM60D1Ue9oMi_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--01Vw34jT9viWiClh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> You mean the DS signal?  That also doesn't exist on R-Car V3M, so
> shouldn't of_r8a77970_compatible.quirks be set to &sdhi_quirks_nohs400,
> too?

Probably. The BSP contains the DTS of a function board addon for the
Eagle board which also enables HS200 only. But I think we should try to
ask the Renesas HW team for confirmation. D'accord?


--01Vw34jT9viWiClh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJHEzsACgkQFA3kzBSg
KbaU8RAAhokANqWCu8JFlQ0xqavLc44o6xXuWcYEyu9/BC49IkeonB5BQCpG94pc
5YdImb0/RA+n4C36ZFlsLO702LdJ6k8pqxuqkqHMS/svqxNOthrKOjkgyMORdKSC
KDQ3gqoqeSSFT3Ukjo1C0NVjUhI4V9okbEGmWUl68HFSvwg+HQeur/cvjZxAMDWA
Xa6/M0nvzVTEUjBmXbpNVl2p5MQR6YHDY8I17x22WoG5V+gW5ISUE9hgVmgO+HMf
a2Tc02PKi1+yCybQbYKzFdZb48Eo6uAl5NwKxAYpZXCo0zVnB3shIDYutEL7edHS
MxvhlGx3bA1y+sGlrwkvRp43/Z4CJDTC40ua4yY5Qef+yR1VXS4nnArh9VcCZhW+
54RmBXNEyv+WZhavzurMLL07TshmJId2SqfSR2ISwWDkyYIfVCinN5hvYZrhWTwc
TD4I2UnticKpNwe+pIuLCe72kYUncYO/TqlOGJjgUMLMbyBZCka5fyI74VxNDteh
o9QGbOyzqpTkTi8T5PORVEHGnCo2QTr/ZPTV/o0f+LVeEPI9GY8t65cFFIeJN2E4
v8nzSR8n5azEc+mJT3/8U5SdGJXgRJTlPLOfUyUQg4hqZu00yMqV1M2/nylzEKBn
GVEQ3H7A1vEuO2orSTw3146vm+JMeriDo1yMRzQ5L60E17+dRbM=
=4i9q
-----END PGP SIGNATURE-----

--01Vw34jT9viWiClh--
