From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] mmc: omap_hsmmc: Fix context save and restore for DT
Date: Sat, 8 Jun 2013 07:25:53 +0300
Message-ID: <20130608042553.GB20238@arwen.pp.htv.fi>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214950.18581.56829.stgit@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42410 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab3FHE1X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Jun 2013 00:27:23 -0400
Content-Disposition: inline
In-Reply-To: <20130607214950.18581.56829.stgit@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Balaji T K <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, Andreas Fenkart <afenkart@gmail.com>

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 07, 2013 at 02:49:50PM -0700, Tony Lindgren wrote:
> We want to get rid of the omap specific platform init code
> callbacks as they don't play nice with device tree.

right, any plans to have similar functionality generically ? Maybe
something like:

probe()
{
	...

	/*
	 * tell PM runtime layer that we can handle runtime
	 * power gating of this device in certain conditions.
	 *
	 * Actual power gating will be triggered depending on
	 * PM QoS wakeup requirements.
	 */
	pm_runtime_enable_power_gating(dev);

	...
}

runtime_suspend()
{
	if (pm_runtime_will_power_gate(dev))
		save_context();
}

runtime_resume()
{
	if (pm_runtime_has_lost_power(dev))
		restore_context();
}

???

> Let's convert the context loss check to be based on a
> register state detection instead.

that might not work always. Specially when you consider that default
register values can change on every silicon release. I guess the above
might be a bit nicer, although a lot more work :-p

--=20
balbi

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRsrJRAAoJEIaOsuA1yqRE0aQP/R2y7j6TSWAeaIa5RNV79WG7
VY5Ef5HJ5jjD5oI9V58Ukj/2LKKjdGtuAUzQk2zL9rw+qL3kpY6Uiu0v7LR+YIl/
S+1HQoe1kqMsd1lcc+qP2yOBS+/VWK+yk3xRCI89Nw0gMeW8p3iIZrOONjFhbNJT
hXw609S150tqbIAVHGwvtWy9dxb5ZeiLHtDBqR76OWbud/65FX/HzUKVOAocoHU+
tivNDEjqtxRuCLMx7BxfP401eaq2t1gk+PSOPenpsAHJuc3rIBJE6j137A6B0D/h
P7wBEGIo9xULQ9oGsLh0/qvNFPw2cW9SG7F1nnMbWXT0uxqerJiidReu4sT7zXJE
GVo/Mv5cqP0hQ1MP93GW1tHqEtwh8cMdq2XwB6ZYBlmUIZUGKeoYa0ZKTEzcvL/B
8slnQbmC3nx+1X45DZMPu9GejaQvcqpdBufvF3HDxA8lvukVu3ECvKcsxcX+6EYi
sBsVNGTTGRabWqRqq/+eHYwZsHSTDwBuytPZnmSRCZWPXZO7Z4eGdZptP+/a+/HQ
zrDtcEEeOqoS2i/OG+tijCjL60kpJVg098rDVgE6Ts5xUNTmwiJ5SqXEm8WLitN0
ae7H/H8aTKe+XD0vCA77FBM/KHxIEKR04TX7YFFDnvYdwUiDooSmygMDHTpMkHt8
8DhNZY1+W0g7ukE4Wkoy
=mzUg
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
