From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 4/4] mmc: renesas_sdhi: add support for R-Car Gen3
 SDHI DMAC
Date: Mon, 27 Jun 2016 14:18:05 +0200
Message-ID: <20160627121805.GC1648@katana>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
 <1465963317-28672-5-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465963317-28672-5-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static struct tmio_mmc_dma_ops tmio_mmc_dma_ops __initdata = {

__initdata causes a section mismatch in both DMA drivers.


--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcRl9AAoJEBQN5MwUoCm2OvwQAIHTKVh1YxuY/Fx9lhw8JfLI
WE4EZLrN2oNeEr1RNuXTKbushLKmtCgT5+cY/VIpWJ1d6vUc1PDV8r4WDpgZXzSr
+ITHS1ioqZZ4ct9Ryutm4fvFm3zwx3q9e3aoY77ilT8e5rAR8ACUeQct+r74Hbay
gRazVQj/urpPFeN3KR7X3qshHwWog3HS49xE6h3XFg3P2/apCshCY826MYa49SzZ
CWCzelr5yw3hkuBPS9i8lD61W4nQj8W/RuM9A8ZkVl/KDjqReHzKFViM+Z9lhY2P
ChiZy5Pci1B9YQq2qJioPzqyMQIgMkLg2z5FYW+2GZ5AClodJHWrV7H4Cu41bLN5
YhRW0mJUGylFYA9onEl/nW//HzDBKU1kdD7I+ssTWcN8SbxJwKKNnKv0dkbSx2t5
8JmnyBCfD99zGaEWN9aUIq92JXs92z8hAQze2eIYdan8c3QhpAnhoBT4kBs/y1p7
boYmjomW5EG6RapExGg+EU/SnMCg+5wnAn8OPzZBktyT8O5vY3csoIx9NeSprcDv
kuyjsXQWaXCU9Ye+o7JgC6jxkVGd7RMjgHpDWg27aEyvs8GJ79uO+b3XOdeSJ7gD
2zjt1LVP7xHI6O5bXPkFIgsabadj47+Qm5NJfBbyrKJb8kYTGnWV7WL6LPWPXaCx
rbl0MUXuLmtKgbQ67Oyk
=JB1c
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
