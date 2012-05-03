From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/29] regulator: fix devm_regulator_put() to call
 regulator_put() explicitly
Date: Thu, 3 May 2012 17:56:07 +0100
Message-ID: <20120503165606.GR3955@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-5-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b0op/nKJ9CeIhp9z"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49418 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752Ab2ECQ4K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 12:56:10 -0400
Content-Disposition: inline
In-Reply-To: <1336057558-11031-5-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org


--b0op/nKJ9CeIhp9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 05:05:33PM +0200, Guennadi Liakhovetski wrote:
> devres_destroy() doesn't call the release() method, it only destroys the
> resource. The caller should take care to release the associated object
> itself.

> +	regulator_put(regulator);
>  	rc = devres_destroy(regulator->dev, devm_regulator_release,
>  			    devm_regulator_match, regulator);

Oh dear.  This seems like pretty peculiar behaviour on the part of
devres_destroy() - everything about the function and its documentation
would suggest that it'd actually free the resource not just free the
devm_ internal bits of the resource, and especially given that we have
to pass the release function in.

This also seems like it's the wrong way round - it probably shouldn't
matter that much but we should really only do the regulator_put() after
the destroy succeeded since there's a small chance that hotplug or
something might cause this to run while the device is being removed
elsewhere so we could end up trying to double free.

Also, this patch is totally unrelated to the rest of the series and
should really have been sent separately.

--b0op/nKJ9CeIhp9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPorigAAoJEBus8iNuMP3d1JIP/0+bbfl60FXs03bzPPoz2thq
8dX2IG9NdBIRvFfH9Jv6Mhz2P6EaIfJnde3TNbSg4Z934T32YHbT/i8ymo1lVG/F
Ap0nh5ZPlUn0UT3LsJ3Ay7Vb+O8W4x3nYJ5PJaw0jU4yf8QbkCxHOtlEsbZEtopF
MjrHfUPoIKptqShVmBm0cED/i6EVib/gOuI6ITP6Y8R1cKZUMUnUpnuMu4YGzuqh
jxgqRQuWJewV0Le2cszZ7sPwi7s0jFoHHIRzCw5Mor4Qqla08TF5xFngNib8zL+O
bt7PRy00nZADFSCMC7f6+IdRRVWyA+SIgZhGDwSnhStImrEGTZaugVeHWkCc88k5
mKbAz9d3wn6I7QMTvz6DCrSJpokuxFWNUhnbrkKKShO9bIliylSvgytIpPeFUjFg
yQO3po7ktFbbFWVq1GQGci+NW+1dVPNFlZaqF4dhzMJHtRqVBYAAMHp2jw9gKTZw
fhP16ajCR1W1pTyMbWCA+FQYhfDOSw355sLiRh7lMjfcUNimB0TsKgcsAk3fAkgp
XOP1uIttkA2nbvEX3rcZ2BbPkvMfVJhpTiy9fR00D7FAtBCWoeHj7yTOmsnAVR59
vNCAfu8VvuC8mANS+v+IhJpxPXkx22f3R8cAXsfc4ae0XXGPktVUAmNYl5p07iTh
5mdCHS4W+JY8XUw3yfD+
=fEU9
-----END PGP SIGNATURE-----

--b0op/nKJ9CeIhp9z--
