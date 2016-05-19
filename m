From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
Date: Thu, 19 May 2016 21:36:57 +0300
Message-ID: <87shxdlws6.fsf@linux.intel.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com> <1463561115-31798-3-git-send-email-kishon@ti.com> <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com> <20160518193028.GT5995@atomide.com> <0d463add-9fa5-a768-2ba6-34c4126c7817@ti.com> <20160519145745.GU5995@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33772 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbcESShD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2016 14:37:03 -0400
In-Reply-To: <20160519145745.GU5995@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, rogerq@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony@atomide.com> writes:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160519 01:10]:
>> On 05/18/2016 10:30 PM, Tony Lindgren wrote:
>> > Ideally the adma support would be a separate loadable module,
>> > similar how the cppi41dma is a child of the OTG controller.
>>=20
>> The Master DMA is part of the hsmmc IP block. If the same ADMA module is
>> present on other IPs it might be beneficial to have a helper library to =
handle
>> it (allocating the descriptor pool, wrinting, updating descriptors, etc).
>
> OK. Yeah if it's part of the MMC controller it makes no sense to
> separate it. So then the conecrns are using alternate DMA
> implementations and keeping PM runtime working :)
>
> BTW, Felipe mentioned that the best thing to do in the long run would
> be to set up sdhci-omap.c operating in ADMA mode.
>
> Felipe, care to summarize what you had in mind?

yeah, just write a new sdhci-omap.c to start moving away from
omap-hsmmc.c, just like it was done for 8250-omap.

At the beginning, it could be just the bare minimum to get it working
and slowly move over stuff like pm runtime, dmaengine, PIO. Move more
platforms over to that driver and, eventually, get rid of omap-hsmmc.c
altogether.

That way, development can be focussed on generic layers (SDHCI) to which
OMAP MMC controller is compliant (apart from the VERSION register
quirk).

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPgfJAAoJEIaOsuA1yqREITMQAJZ3ClxlEweBpAun2M5m9MPz
ul1gHG3nABNnpY2dLWSSCR/51ptj7IDQOE5I9HfwGsDrxHLCechei+aCF/v1puKv
orNUILfiZ3FqjVUxJ/NzeXrZT353sX3fNBKUEyFmeuW6JOWOWmGf2akVryERUGCJ
NLT1Oe7WcSe5ySRi1o7wO2zbGCyGA9I+FazOAIR6mfqGfj/yz1RLJF5Nd8VyBYVv
Ok3ZqnYp8yJWiYC0GKg8zxrfvCcgTHPDlUcmXjpxLg7edOxm6GdgqKeCzWWu39fz
qEi1uqd5kjO0Cuzt87ml46moFCsLdxbyXyw+aS+wkOr+d8alrdMkeI6MP/jid8KU
0U6URjgHu2pFUfk3ysAmqn094aUVa4g/LHrFDgHy6AnFeHFx87lzA7RTLhEIPKAJ
6EetsQZ4Mg+nwtalhyzB/M89RCIU4w0zNUceCTbgBhNl/ko8z04mDHxLi4BF27d5
02UkSDfAQq3kv6C3ObyeFyFuLypVIWyLWMyxe4lkQq0W5AowVYTztry9QUJdMkTg
eemPJ01FU++CY03hmDqAttuIQ7JNHfid0kAflcIZfT3YXi4zMA04RaWJD+iB0slL
ljZG8e5Wnr7R7rcmrFd/HpLehurt9Shuf/P1w23XrpTMcDdXdUSbMgNViftHcCns
6a5jBsBUGY1a3gKHsvrQ
=bN9U
-----END PGP SIGNATURE-----
--=-=-=--
