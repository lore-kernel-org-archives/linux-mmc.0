From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 20 Jan 2017 22:39:01 +0100
Message-ID: <20170120213901.GC1438@katana>
References: <20170120194332.1683-1-chris.brandt@renesas.com>
 <20170120194332.1683-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120194332.1683-3-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +- clocks: Most controllers only have 1 clock source per channel. However, on
> +	  some variations of this controller, the internal card detection
> +	  logic that exists in this controller is sectioned off to be run by a
> +	  separate second clock source to allow the main core clock to be turned
> +	  off to save power. Unfortunately, the existing driver architecture
> +	  does not support such a separation of clocks.
> +	  Additionally, it is prohibited to supply a clock to the core but not
> +	  to the card detect circuit. That leaves you with if separate clocks
> +	  are presented, you must treat them both as 1.
> +	  If 2 clocks are specified by the hardware, you must name them as
> +	  "core" and "cd".
> +	  If the controller only has 1 clock, naming is not required.

I know we are not perfect in this area, but DT binding should be OS
agnostic and should refrain from specifying Linux internals.

So, I'd think the comments about driver architecture should be put into
the driver, not into the bindings.

It is ultimately Ulf's decision, of course.


--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYgoN1AAoJEBQN5MwUoCm23a8P/2Da+vtJow4xkn3upP0ntwtp
CD5KMrUyCdKg8zj/Q9yrGcEmKl4dqeZhbK+7x0iOJs9SQLpYatriLSwzf7yNxgrB
9gl3JNzVZfS1ysYS2pB8QZ67o6nYkSjzkNC5KiRFo+Qu/F6HlSAYzEWQq9gKLctT
2oH0LrZi9UU6KO5QC9xeENtwJq5Kau5V7MY0z5wp/qI95Tdq2IEvB4pCJZ3suONM
Ykjhq4okFhykzouG2F1mzF0W4f421Z59+CQ+1+qg/yu8/fJ1L85nsqL4BxVVLIO6
Yn9s3Y5cjaaIWUTEG+rGSVYJ6B+DqCzZbhoARmJ5ZVTBzufmbBpLgiI7GS3qwRR4
DqqAq4Z/j5l30Fze0trQIZ28iwQPIEjANAeJM7gNSztTNJfetbIZW+4cSBX1u7tz
Fua6Yv8u/ffpD6wJOrqLmPh/HyNxCZQIm2L5XSCjOp+L/ciEJEsjVl7fpzSp2yre
C4ZBbEUkh1+rryN2bhTsvQ9bbhHDi1XxRXi55WPEBPvNJ0HVKTWXUB9xsUYWa8Or
JNrCcMP/jp+5dBQu13BwDKx79QNgqRBRVnt4qJZQFJ7oK1qFWn+Noqkb66LWQpam
T3QrEt4COtgbjD1nhfyIR/Z9pcjoLt6t/c9OaDiosTI0gUFkdHOrMX9ZNGn1Oy3r
FtOAw3fsuLuLlwGlhBSS
=xXjm
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
