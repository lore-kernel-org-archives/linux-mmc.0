From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [RFT] mmc: tmio: fix CMD12 (STOP) handling
Date: Wed, 5 Jul 2017 11:19:29 +0000
Message-ID: <TY1PR06MB0992844258B8EE4C70C403D2D8D40@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, =?iso-8859-1?Q?Jan_Kl=F6tzke?= <jan.kloetzke@technisat.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, KOUEI ABE <kouei.abe.cp@renesas.com>, DUNG NGUYEN <dung.nguyen.aj@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram-san,

> -----Original Message-----
> From: Wolfram Sang
> Sent: Tuesday, July 4, 2017 4:28 AM
>=20
> I always anticipated this code to be not correct, but now I had a test
> case to prove it. According to all documentation I have, setting the
> TMIO_STOP_STP bit ever only worked during block transfers. This bit is
> like manually enforcing an autocmd12 during a so far seamless transfer.
> It does NOT work when the block transfer had errors. It also does NOT
> work with any other cmd except block commands. For all those, CMD12 has
> to be treated like any other command. So, basically, we could use this
> bit only for mrq->data->stop cmds. But for these, we happily use the
> autocmd12 feature using the TMIO_STOP_SEC bit. As a result, the above
> bit is not useful for us and we need to treat CMD12 as a regular cmd
> always. Just remove the special handling code. Note that the BSP
> recognized this issue as well yet had a more cautious solution to the
> problem [1]. Which is understandable but makes CMD12 handling even more
> complicated.
>=20
> Checked with a Renesas Salvator-X/M3-W which needed to send CMD12 when
> retuning one of my SD cards.
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/com=
mit/?id=3D2838a2ff8ca776f6d18b7fbbe75f3df8dd6
> 4183a
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> So, this is a friendly call for further testing to make sure no regressio=
ns
> happen. I also put the authors of the BSP patch to CC to check if this pa=
tch
> also matches their use case. I hope this is fine for these people, please
> accept my apologies if not. I just really like to have your opinion on th=
is
> patch.
>=20
> Geert, Simon: any chance you can run this patch on your board farms?
>=20
> In any case: as far as my understanding goes, if I am wrong with my
> assumptions, the worst case is that for older SoCs CMD12 handling might b=
ecome
> a tad more inefficient because we now do in software what was expected to=
 be
> done in hardware. However, I am quite sure that the HW feature was always
> over-estimated and CMD12 support is simply broken. For my test case and t=
he BSP
> patch above, it definately was.
>=20
> Thanks for any assistance,
>=20
>    Wolfram
>=20
>=20
>  drivers/mmc/host/tmio_mmc_core.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
> index 1851c883bfc82a..fbcd56c58bce24 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -355,12 +355,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_ho=
st *host,
>  	int c =3D cmd->opcode;
>  	u32 irq_mask =3D TMIO_MASK_CMD;
>=20
> -	/* CMD12 is handled by hardware */
> -	if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION && !cmd->arg) {
> -		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_STP);
> -		return 0;
> -	}
> -

I and Dung-san are testing this patch.
However, this original code doesn't run by our test cases.
Do you know how this original code runs?
Anyway, we will try to make a test case somehow now.

Best regards,
Yoshihiro Shimoda

>  	switch (mmc_resp_type(cmd)) {
>  	case MMC_RSP_NONE: c |=3D RESP_NONE; break;
>  	case MMC_RSP_R1:
> --
> 2.11.0
