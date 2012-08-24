From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] MMC: OMAP MSDI: fix broken PIO mode
Date: Fri, 24 Aug 2012 10:25:11 +0300
Message-ID: <20120824072509.GC3334@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1208240555210.25436@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55506 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244Ab2HXH3O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Aug 2012 03:29:14 -0400
Received: by lbon10 with SMTP id n10so748875lbo.25
        for <linux-mmc@vger.kernel.org>; Fri, 24 Aug 2012 00:29:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1208240555210.25436@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@nokia.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, Russell King <rmk+kernel@arm.linux.org.uk>, "Venkatraman S." <svenkatr@ti.com>, Balaji T K <balajitk@ti.com>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 24, 2012 at 06:00:18AM +0000, Paul Walmsley wrote:
>=20
> After commit 26b88520b80695a6fa5fd95b5d97c03f4daf87e0 ("mmc:
> omap_hsmmc: remove private DMA API implementation"), the Nokia N800
> here stopped booting:
>=20
> [    2.086181] Waiting for root device /dev/mmcblk0p1...
> [    2.324066] Unhandled fault: imprecise external abort (0x406) at 0x000=
00000
> [    2.331451] Internal error: : 406 [#1] ARM
> [    2.335784] Modules linked in:
> [    2.339050] CPU: 0    Not tainted  (3.6.0-rc3 #60)
> [    2.344146] PC is at default_idle+0x28/0x30
> [    2.348602] LR is at trace_hardirqs_on_caller+0x15c/0x1b0
>=20
> ...
>=20
> This turned out to be due to memory corruption caused by long-broken
> PIO code in drivers/mmc/host/omap.c.  (Previously, this driver had
> been using DMA; but the above commit caused the MMC driver to fall
> back to PIO mode with an unmodified Kconfig.)
>=20
> The PIO code, added with the rest of the driver in commit
> 730c9b7e6630f786fcec026fb11d2e6f2c90fdcb ("[MMC] Add OMAP MMC host
> driver"), confused bytes with 16-bit words.  This bug caused memory
> located after the PIO transfer buffer to be corrupted with transfers
> larger than 32 bytes.  The driver also did not increment the buffer
> pointer after the transfer occurred.  This bug resulted in data
> corruption during any transfer larger than 64 bytes.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

this looks good to me, though I don't have how to test. FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mmc/host/omap.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 50e08f0..a5999a7 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -668,7 +668,7 @@ mmc_omap_clk_timer(unsigned long data)
>  static void
>  mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
>  {
> -	int n;
> +	int n, nwords;
> =20
>  	if (host->buffer_bytes_left =3D=3D 0) {
>  		host->sg_idx++;
> @@ -678,15 +678,23 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int =
write)
>  	n =3D 64;
>  	if (n > host->buffer_bytes_left)
>  		n =3D host->buffer_bytes_left;
> +
> +	nwords =3D n / 2;
> +	nwords +=3D n & 1; /* handle odd number of bytes to transfer */
> +
>  	host->buffer_bytes_left -=3D n;
>  	host->total_bytes_left -=3D n;
>  	host->data->bytes_xfered +=3D n;
> =20
>  	if (write) {
> -		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer=
, n);
> +		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA),
> +			      host->buffer, nwords);
>  	} else {
> -		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer,=
 n);
> +		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA),
> +			     host->buffer, nwords);
>  	}
> +
> +	host->buffer +=3D nwords;
>  }
> =20
>  static inline void mmc_omap_report_irq(u16 status)
> --=20
> 1.7.10.4


--=20
balbi

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNyxVAAoJEIaOsuA1yqRE06cP/219/8kzaf1/ws3RUgB5cVUS
q6swds8nSivrsIojNkYxX9bN55ldcenmmOBNxM/2MRPkdXlMSSnHsCz434vmiI7a
/ETC/mK8dSl8Y0B/fLSWhqNd5fw1yNWmBbL1Oz8AoJ8bQTQhsv2HJMAoJndOS8c7
o85+iFhDHofJsPX1e/RfXfNmkCuhOOqCGv9CvX+88l0m5p7/15d+MbNZB2A9yVnt
kxo9sNAUhVMDNDOLr0ki15H4/o9OUPdKt8tg0t6+A1jigX9vnYAae3RYunhcVYOs
TJXgqmsROoU3hRiTJYJxszMtPAKFLNhf1hrsLlBq5wfNgc8RHfmHhj4mKR6j/tOf
E3j0otYKv33UmXxZ3DhLjTXO92oiAcHNPR9T0Bk/NpyXJzlqsNVqjymdZLYuYTbg
zLSZuRtP5Y4enx7YhzoWlWquHcV35SRnIeYxlKutydU67xDuNOeggtfAgJWjiaeD
0KKqFZaqnZhLYKEGwDun2h6YaTDSyO52U9Bko6fVrcZlz8HQv2Co45u0i8X0g7ML
pU9W1iF5jSSvGry1YAJKuRV2nO8XRra+03A7QjHq3vicsWu5cGz9IiAFOTvPwPs8
RX7sT8+AI0lZ14+eUppbeMWFMtMJfdojVkdupvmw4BhZT01Lj9maLVCjTtkZJVYp
HO8OtH/5CCQ2DQ/2B1PE
=OEcK
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
