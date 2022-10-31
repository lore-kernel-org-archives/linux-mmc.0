Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81533FA3741
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Oct 2022 19:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJaTie (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJaTiP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2022 15:38:15 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94F13F57
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2022 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=qxFZ/ffPUWlj8hGol5h8fURnKP3k
        tdznvOqG46ZZHFc=; b=mKqpSJaRvkLuYA0uLW2Trf1A77EiN3oqszrRGmUSxpQZ
        abvNkhK+uU1VK7lt+TwFSE9913pqJR5jbQrmc0pzhsat8OEmXt0S8pqpiLy6gvgf
        5FOCiHNSEEz5sZhwf+UVAcvgw7oL7BuiHALzHDgOGRmJHD10lak5IXby0ofhfec=
Received: (qmail 1497482 invoked from network); 31 Oct 2022 20:38:03 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 Oct 2022 20:38:03 +0100
X-UD-Smtp-Session: l3s3148p1@jGX1vlnsXs8ujns0
Date:   Mon, 31 Oct 2022 20:38:03 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 12/14] mmc: tmio_mmc_core: Replace kmap_atomic() with
 kmap_local_page()
Message-ID: <Y2AkG11Le2mHuOC/@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
References: <20221005101951.3165-1-adrian.hunter@intel.com>
 <20221005101951.3165-13-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQe3C/SOXf/ipiEz"
Content-Disposition: inline
In-Reply-To: <20221005101951.3165-13-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--LQe3C/SOXf/ipiEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05, 2022 at 01:19:49PM +0300, Adrian Hunter wrote:
> kmap_local_page() is equivalent to kmap_atomic() except that it does not
> disable page faults or preemption. Where possible kmap_local_page() is
> preferred to kmap_atomic() - refer kernel highmem documentation.
>=20
> In this case, there is no need to disable page faults or preemption, so
> replace kmap_atomic() with kmap_local_page(), and, correspondingly,
> kunmap_atomic() with kunmap_local().
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Not disabling preemption sounds good!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--LQe3C/SOXf/ipiEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNgJBsACgkQFA3kzBSg
KbYzaRAAjBU0/zMCnj5RHKx4ETQyq7Uz6n2SbaXJagLtEGeEHp+YLl0HW10GzK3y
ghl2zVkR0au5ON29YiOUrmwH2tFIXgl3afdXQ+/Bq7efD8U0s/iqJDLlrlALMk58
oTmIoc3HD4dJtbEGDd2doGahIbmGSkXIam8mOdjYgoVrC1LFgVibahPQU6VbcZlH
9DAsPTRBcnrFqWGlGkeehDZ4Q+tbbYzyST9mbfq+pJ0sdkiUnv5x5W5mnRp/ID7E
Xu3pTc/mLjFDKrLZgwIP//62quEaEpfeyg93jfGocQNVZZdcNzM2Ne4t6qOIN5fg
m6jupj7VG5zY9Sw/63swdsFRdKA4M5IYDxRHRi/vM6/wT+TdqHfyOdIOhrMTiZJf
bc1NggBQVCN1jwy8bPGr7etTOAavPoieIn/Z8bGB2vNJMQSdtxYpjLWMN4uC4A5s
PK7rFqLZg9ryFrjD1QoZvFYkulpxOncC8mo4NkdcgBdj5kJwUsX4RsrKB8+3Or+L
q2lIii2Fz17VFHxBr3fE37viLjw8Eqi0VBkwwU0ogbXF/shhA0/Hu02taWDdk8NC
9GOVrsRVOOMgnr+p+3d0V3VSjdITTHbswjQFltI4QzJSxdef43mvM2/YhlktIuQK
sgVbkPW4Y64Gj8Wy66ZLzvtcRtfDWo7cRm24tx5mwTp/MLCy70o=
=+LO6
-----END PGP SIGNATURE-----

--LQe3C/SOXf/ipiEz--
