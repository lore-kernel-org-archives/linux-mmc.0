From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] mmc: sunxi: mask all Response Timeout error messages
Date: Mon, 6 Mar 2017 11:04:37 +0100
Message-ID: <20170306100437.sr7mrvssdwnt7aaz@lukather>
References: <20170305164535.36259-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3706744412367671349=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170305164535.36259-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============3706744412367671349==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dmth4fycnu6lbjm3"
Content-Disposition: inline


--dmth4fycnu6lbjm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 06, 2017 at 12:45:35AM +0800, Icenowy Zheng wrote:
> Response Timeout is very usual: it will happen when trying to run some
> commands that do not belong to the card; it will happen when some SDIO
> card transfer beyond its SDIO bandwidth; and when the MMC controller is
> set to poll the card with "broken-cd" property (the Lichee Pi series of
> boards do this), it will flood to the console and make the console
> unusable.
>=20
> Mask all response-timeout-only error messages, only show it when another
> error happens.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 6ffcd2838272..7828e1f57cf0 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -483,10 +483,15 @@ static void sunxi_mmc_dump_errinfo(struct sunxi_mmc=
_host *host)
>  	struct mmc_command *cmd =3D host->mrq->cmd;
>  	struct mmc_data *data =3D host->mrq->data;
> =20
> -	/* For some cmds timeout is normal with sd/mmc cards */
> -	if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D
> -		SDXC_RESP_TIMEOUT && (cmd->opcode =3D=3D SD_IO_SEND_OP_COND ||
> -				      cmd->opcode =3D=3D SD_IO_RW_DIRECT))
> +	/*
> +	 * Reading timeout is usually normal, especially when doing
> +	 * card-polling with "broken-cd" in device tree.
> +	 * If do not mask it, the RTO error message will flood the console
> +	 * and even hide useful error messages.
> +	 *
> +	 * Some SDIO commands will also normally timeout with non-SDIO cards.
> +	 */
> +	if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D SDXC_RESP_TIMEOUT)

We really shouldn't silence legit errors.

The actual problem here is that we log them as error, we could
probably reduce it to debug.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--dmth4fycnu6lbjm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvTQ1AAoJEBx+YmzsjxAgRhEQAI565taKfIQiprJ1kF1FcHZd
0WpEY11F738vkaJjOpN1DnbOmrvThkQHF0UNxxQTpicXWbd4CwudxNDgbtWxinHM
khi2X6nAV1mia7DrvXXDBcIEtqlAcFkJw2UA2PGs64v85Duj7mvMsTCOSUTi4rRL
PZz7fP7Q8WGiQtVOCtuf6wW/bBi4E1IopnidYB6YB8hVHfCV9b9cFhB9mronoz6g
BLuTFz0EvzRIPmlnIudk+maKk9tLaEEx5zclqO8+ga6RNLPWDUVeQ8+gKxhRmRU+
2dDyP7LAx1fuTNwAEfibafUcGV5yvUDDTkcZH47/1/iq+pNrKFLwZyE9g8idGZJm
qQQneJCH3g7EiFUh2x6MOHm55Rh7u82MkxGe92dB0zjv0X5ilz/KqiZ1ZufEqOED
ygK2+bJdXO8W6/6Q7VNjovB15yuoEXN06FX2FYFSOsjp1S+S81EWLyOOnXmaCrgA
Vcl7Re7T+2xZVUy5MgHaD87IwfdMMwEnv0X8SamImF6yRbsqW7IIMYqy7BlKNo4B
PMQzBjmWEGVb9e3TyPuisDoa0WH0QFKqLDjFu1CrNlWTH8LVMBVUUdUCIODs3yAW
cR82LOOfry7jy8K2axjihklQyAhlPzyu2gefWZc0YrQn6V1ot4CenVF9uEt+QzFq
PN9zQSfdSwiqjN71fiRf
=3Drc
-----END PGP SIGNATURE-----

--dmth4fycnu6lbjm3--


--===============3706744412367671349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3706744412367671349==--
