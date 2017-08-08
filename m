From: icenowy-h8G6r0blFSE@public.gmane.org
Subject: Re: [PATCH v2] mmc: sunxi: Fix NULL pointer reference
 on clk_delays
Date: Tue, 08 Aug 2017 15:07:59 +0800
Message-ID: <bbd4680dc97d9913ff6a49e68c360d21@aosc.io>
References: <20170808070244.27410-1-wens@csie.org>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBUOGUXGAKGQEPA3DBMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170808070244.27410-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2017-08-08 15:02=EF=BC=8CChen-Yu Tsai =E5=86=99=E9=81=93=EF=BC=9A
> Some SoCs do not support clk delays for MMC in the clock control unit.
> These include the old controllers in A10/A10s/A13/R8, and the new eMMC
> controller in A64. The config structure for these controllers do not
> specify clk_delays, but the check for this was replaced in commit
> b0600daebf31 ("mmc: sunxi: Support controllers that can use both old
> and new timings").
>=20
> This patch adds back the check for clk_delays, and also adds comments
> for both checks in sunxi_mmc_clk_set_phase().
>=20
> Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
> 		      both old and new timings")
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Should I add a Tested-by here?

> ---
> This fixes an mmc regression on A10/A10s/A13/R8 and A64 introduced
> by the A83T mmc patches.
>=20
> v1 was inlined in a reply to "mmc: sunxi: fix new timings mode on A64
> EMMC (MMC2) controller"
>=20
> Changes since v1:
>=20
>   - Polished comments
>=20
> I've tested this on my A10 Cubieboard and A20 Cubieboard2.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c=20
> b/drivers/mmc/host/sunxi-mmc.c
> index 3777517982dd..9dc6d726ec49 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -722,9 +722,14 @@ static int sunxi_mmc_clk_set_phase(struct
> sunxi_mmc_host *host,
>  {
>  	int index;
>=20
> +	/* clk controller delays not used under new timings mode */
>  	if (host->use_new_timings)
>  		return 0;
>=20
> +	/* some old controllers don't support delays */
> +	if (!host->cfg->clk_delays)
> +		return 0;
> +
>  	/* determine delays */
>  	if (rate <=3D 400000) {
>  		index =3D SDXC_CLK_400K;

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
