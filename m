From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: mmc: tmio: why enable/disable SDIO irq on every transaction with
 IOMOD?
Date: Thu, 1 Dec 2016 15:49:19 +0100
Message-ID: <20161201144919.GB6361@katana>
References: <87h96qkdn0.wl@dns1.atmark-techno.com>
 <CAPDyKFop3a6eHhOZq1E=BdFiHzmpu4uEx0F79nyBVCOu6z6usw@mail.gmail.com>
 <20161201104622.GA1541@katana>
 <87y3zzvmth.wl@dns1.atmark-techno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y3zzvmth.wl@dns1.atmark-techno.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, wsa+renesas@sang-engineering.com, horms@verge.net.au, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Is Arnd Hannemann, the author, around these days by any chance?

According to git history, he is sending a patch occasionally, but all
his SH involvement was from 2010. I don't know him.

> We don't have it yet.  A question we have is that where should we
> enable / disable the IOMOD?

I think unconditionally in probe. I will send an RFC with some
explanations in a minute.

Thanks,

   Wolfram


--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQDhvAAoJEBQN5MwUoCm2pkcP/jJqargpoBKF05XggPfml9W0
ZzCo49O356rg+Z1IeVhKu7Pr5nvoka1iezo5VIuVcDTceJ8Z0ySkPI0AmTYA52Kh
jL92a47OIaZ9bpuGx0vpADloGe7aM0Fh+wYRC6837Q69Ql1h/9IWTndRT5VSOfXG
td38RRBOJAnMZTRmUmH7pPokyWUzZODZ6IUBr851/Lxx+T3IzDxRT0HuQnnoLLC2
6F3Do3hXnL3oJ39cIITGsBEktsdTEGu3CQiKBTcr6ExGNfb16r+PazbHA2hzwRHL
LSxxKdD/x3fq00fBy4EomKPowkFBuHHMuHCqoPtdfXwwXdeyBI+Upe/qKRU06c2X
hZhRNXswLOQB5e+GBK1A0x6LnjJYmIvWuLuRlxymEYVH16UOvXdBuGef4ZVlt/rk
Q8WD3J7W1CFXqc15LyrQH/MXMnvgBCzXFo5GuP/j/9XE6lNPOsP7xIHTBscUdTVi
r6XzBLfLuF66YjVN5IebQnnnBv9DG2aNK+sP3U8RJGJu+Mugv/hMBvpJdeo69QFh
dBpl/sv0eO4sEjfKaWMcetYOMdUx7qncDDlXVos51vYPtDK11OlzyPh0ZBlhfjt6
y3HMXg5nzRlvEDF4BpvmFzzNg6OeEkZmHHspg0F2Pn089lKmQg0BrBHlDGj4rFWA
MkEoACQwBE07ECAScZQv
=0aIP
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
