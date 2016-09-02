From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] mmc: host: sh_mobile_sdhi: don't populate unneeded
 functions
Date: Fri, 2 Sep 2016 07:23:01 +0200
Message-ID: <20160902052258.GA1601@katana>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
 <20160824093438.2478-3-wsa+renesas@sang-engineering.com>
 <CANqRtoTJWN52roRwJHh1cZrb2Jqf5OD-ffjKgiW4Y5jqCeVzhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoTJWN52roRwJHh1cZrb2Jqf5OD-ffjKgiW4Y5jqCeVzhg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Magnus,

> To my eye it looks like this patch might be adding a fix for a bug
> introduced by another patch. R-Car Gen2 and later are quite recent
> SoCs but I believe support for other mobile chips and earlier R-Car
> SoCs also also covered by the SDHI driver. Also there are theTMIO
> chips that share some software and are related but a bit different. So
> in my opinion we need to thread lightly to avoid breakage.

I'm very much with you. This is the very much reason I introduced
TMIO_MMC_MIN_RCAR2 in 3d376fb2ea907f ("mmc: tmio/sdhi: introduce flag
for RCar 2+ specific features") in the first place to be able to
"protect" old hardware from new features. It was not done before! This
is also the reason why we have commits like a21553c9e0c236 ("mmc:
tmio/sdhi: distinguish between SCLKDIVEN and ILL_FUNC") documenting a
difference between some old TMIO variant and our current SDHI. I spent
quite some time finding old TMIO information somewhere for that.

> My concern is what happened before this patch was applied. It looks
> like the callbacks were installed for all hardware types which makes
> me wonder because UHS/SDR support is only available for quite recent
> hardware.

I didn't protect these callbacks before because I assumed they are only
called when SDR support is enabled via devicetree or platform data.
Which is not the case for all the old platforms. I sadly missed that
card_busy() is used when polling an SDIO card in case "broken-cd" is
used. That was a detail I overlooked, sorry. Given my work outlined
above I don't think one can deduce that I don't care about regressing
old hardware, though.

> The ->card_busy() callback is not yet in mainline or -next. It was
> introduced in:
> 0157290 mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi

Not quite, it was introduced with 452e5eef6d311e ("mmc: tmio: Add UHS-I
mode support"). The commit you mentioned moved it from tmio*.c to
sdhi*.c

> If this patch is fixing a recent commit then perhaps some patches
> should be squashed together to prevent bisection breakage or if a
> patch is already part of mainline then a "Fixes:" tag might be
> suitable.

It can be argued that this tag could be added:

Fixes: 452e5eef6d311e ("mmc: tmio: Add UHS-I mode support")

I don't know how well it applies, though, because the code has been
modified a lot recently. But we can try.

   Wolfram


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXyQyyAAoJEBQN5MwUoCm2jZAP/jlInqaHAq0zmZliOUndNABd
Qp9ac1r2GbTt4dHdiW32FuMubFOeayRupeRKosPMU24Mv22QOChqZVLTIDd+irj7
KQdZutaTE74RUW4c8IUlawGbnDkTuUuZ2Ib/WotuGkvLdN9OtDUNVDQSimM8mTpk
CWrONN2K6L1DQdpZefM0f+nWybLhwoe5KOCUxdfx5yEy8WbYVqItJkhQOtWc3d5d
SDCV4jnNIbiEIRyP6Pl/p28/3kyIstquTIAK1AsjhzKaBmF7DStV2K1kvcCGODDL
38RbAOXVEvZYAMjAZHymCfUHiQ8ce+WtbxMqwuXGdSG/VCHv+cb76Fc0uPt3Ym5K
CVggsNA0JS4rv1rHEgDPYzdC5oZzDlq/Nduu0Ip+flE/39hpDjRLvU7dLK4fhZb/
U9g6ijhsgA3vutOwggO7RtDwBKpjW8xRhKrkb7p4SJm0Vgtrbu1ffetjAMbG26xb
hcHmdlkf104oRQOAVgyUIsERjlCsvWiiS4VZyT4AJQFCgHh7W/fQbbKjGuCG0LLq
tnTpYeYIA0wHVNWgqT7sFRvUPA8Atb0BGEr8SziSY0/Dyu9wIvYi5jlkdH/CMIiI
tnfnbCRnxxfnEUv/1Fsep6q2PZG3CsTayzSfkA0JbEg1SWJUmC0Trotal2APb4S6
AOzchGTx0Je5VqhDCH7c
=BUWZ
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
