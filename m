From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
Date: Sun, 15 Jul 2012 22:11:21 +0100
Message-ID: <20120715211120.GH4041@opensource.wolfsonmicro.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
 <CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47678 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865Ab2GOVLZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jul 2012 17:11:25 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roland Stigge <stigge@antcom.de>, Grant Likely <grant.likely@secretlab.ca>, cjb@laptop.org, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 14, 2012 at 09:57:08PM +0200, Linus Walleij wrote:

> If I understand correctly this relates closely to another patch from Mark Brown
> we discussed the other day (sorry for missing this patch, which arrived
> earlier, for a while).

> Mark/Grant can you look at this patch?

Not unless I have a copy of it, no...   I had thought a version of this
had been submitted already and was in a similar place to the one for
gpio_request().

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQAzHvAAoJEBus8iNuMP3drfgP/3pVckr62fuo7nacSgjgTDsN
v0LXo+PxhaR3stW7ZMO3l8xgBsoWIIh7wXBH/BWICOD5vDla0R2gTJi01reTjewx
qhO5pFlTdgZOnwxvqBITO90+wQGD8Z+o2/lKtewzuDWkmTDMExpo+BXHKJis+yVi
x7XLsC4A8AvguX9hJJqnEs1HKEzXySj6+wuffxsZuGM4A0zYQfJH5L80I4n/2vSz
RbV3I5yrCrIoT00elQAsUChTH+o9MB0MNVD1GRtzyLUKeqiwiET0ANfx58CEakZi
FJdl+FBGYa/roZuraKIZU8CuuzhHDfKCmWb4oulCo2jEjdSKSVlV84xZbYMjwkWf
LYLOALN0Zfxm+e1kbGyS1/jdHWwtOEF+sBpDoV80NiKzYce2b4p9Ge//WoJIkKR0
MP1JqOWebjtDltS6NI27jmOE5gswJxFTze5vnncKiN0DkRRnsyNaCG8e7SXiN7qs
3QnvPH0tOVJZ0kIj/AYP0vizZAy2Bo345cU+qlpsRHlk1QvoUFDWPOvIrPhOJOuf
sVGHZcppCObUXpKbndQJn3ScY4UPyb0hmqfiXTHL/ndwqphLfr7HppqfSDQBO9hr
mKLAvcSJ8ToN74DL1+rVSnTpTMT+NpiM50Y/rvn66A2/DZpG/H7DgZBpAKct9cVY
ZjChgmIwYRE0XHKYxAeY
=hw9I
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
