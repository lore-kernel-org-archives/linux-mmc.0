From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] mmc: tmio: add eMMC HS400 mode support
Date: Wed, 7 Feb 2018 23:20:12 +0100
Message-ID: <20180207222012.5hxmo2sdelur4uoj@ninjato>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-3-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fsdmkekzff5qj2kv"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45162 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeBGWUO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Feb 2018 17:20:14 -0500
Content-Disposition: inline
In-Reply-To: <20180119133906.11280-3-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--fsdmkekzff5qj2kv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Simon,

> +	void (*disable_scc)(struct mmc_host *mmc);

Do we really need this callback? I'd think it can be folded into
reset_hs400_mode() because it is called only once?

> +	void (*prepare_hs400_tuning)(struct mmc_host *mmc, struct mmc_ios *ios);

Can't we use the host->ops->prepare_hs400_tuning() callback invoked by
the core?

> +	void (*reset_hs400_mode)(struct mmc_host *mmc);

Maybe we can get rid of this, too? See later...

> +	if (host->disable_scc)
> +		host->disable_scc(mmc);

(Here, this can be folded into the next callback)

> +
> +	/* reset HS400 mode */
> +	if (ios->timing != MMC_TIMING_MMC_HS400 && host->reset_hs400_mode)
> +		host->reset_hs400_mode(mmc);

I wonder: If for any ios which is != MMC_TIMING_MMC_HS400, the
hs400_mode needs to be reset. Couldn't we as well then disable the mode
always after the MMC_TIMING_MMC_HS400 tuning was selected? Just
brainstorming here...

Regards,

   Wolfram


--fsdmkekzff5qj2kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7e5gACgkQFA3kzBSg
KbYcRg//QCZ1FFTFVYDWtSq1sVPiK+oFBT54vq1iwL6S5MOBayxKNlDP2SSHi8AP
VLa0WXqBIXQGChCFaNayMKL0L1UeUP/ualocCCu0qQG1ciMt1lP6hOzv4sH83V1O
6K8OruN+qWI8lnYTLTtyb3MB6GMNOtpRYrs7RUYxP6E0/yyKwnGhhL1xBkfqxra2
ql59LsEzN0nPhYIp0QUMuJu2CniEXLKA8LbleGWbcTAENy7gOFfP3vtbQ2ouWNZ5
FAwTiGnxs3fzS05qcHTZOm2s9Ter963DkG74HJuJsYAh/3IAF2hG+LQ/fVE5cXHs
r/vDdUPfqK7fYFjqFSthmEt1pNHxL4WXzTt0ItWnirtXSMZJ6rDnWiC/RQcfPaG2
u9/AJ+GOBXs70zqDLdfHzv3o26zn5DptfUG22vR6dYAK790Uslg+CmM4dPUarcMc
KVnrOnFpxe9TupkVdyuxH1RQasd3aAQhcefUbq9NS+rjyCqtc0OSJ7nMQCiYC1Th
yt0EFJ+EF0cTLv4Ie3V+1wOshLpK5Hey3FVYcAfkKlr147ea1NvYXeERCKeFY9Iw
x0zd1Lm2OmY0P9vT1/GLlRH7pyB19W5ngC4+CZpotV5Bq6jCZGR4VSRi2Gt8FYBn
SCq5OPa/oHIF1xM+My4v0UG0WsHKPdNdmN6PCTt8T84bf+8lIn4=
=ApK9
-----END PGP SIGNATURE-----

--fsdmkekzff5qj2kv--
