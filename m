From: icenowy-h8G6r0blFSE@public.gmane.org
Subject: Re: [PATCH 2/2] mmc: sunxi: fix new timings mode on A64
 EMMC (MMC2) controller
Date: Mon, 07 Aug 2017 14:59:24 +0800
Message-ID: <4ec3370b8c33eb8a411e9b6ee228a9f7@aosc.io>
References: <20170804213555.6024-1-icenowy@aosc.io>
 <20170804213555.6024-2-icenowy@aosc.io>
 <20170806023954.wwaredjwcm2p5pw7@wens.csie.org>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBUM7UDGAKGQE6VZA2HA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170806023954.wwaredjwcm2p5pw7-SLa5LZP+eSXNLxjTenLetw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2017-08-06 10:39=EF=BC=8CChen-Yu Tsai =E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Aug 05, 2017 at 05:35:55AM +0800, Icenowy Zheng wrote:
>> The configuration struct of A64 EMMC(MMC2) compatible used to
>> have the needs_new_timings variable missing, which lead to NULL
>> pointer dereference now when trying to set up the old timings mode, as
>> the old timings mode doesn't exist at all on A64.
>=20
> I'm not familiar with the A64's eMMC controller. The datasheet says
> it does not have the timing switch register. It does not say whether
> it is always in the old or new timing mode. "needs_new_timings"
> probably meant that the switch has to be set.
>=20
> This fix doesn't really fix the underlying issue, which is the check
> for clk_delays was incorrectly replaced. sun4i/sun5i is also broken.
>=20
> Could you try this patch instead:
>=20
> <---
>=20
> From 23b841a11294cb6a0cf1e146616b068f60c2ec7d Mon Sep 17 00:00:00 2001
> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Date: Sun, 6 Aug 2017 10:24:47 +0800
> Subject: [PATCH] mmc: sunxi: Fix NULL pointer reference on clk_delays
>=20
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

Successfully tested on A64 (SoPine with baseboard and eMMC module).

> ---
>  drivers/mmc/host/sunxi-mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c=20
> b/drivers/mmc/host/sunxi-mmc.c
> index 3777517982dd..020547e5fa45 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -722,9 +722,14 @@ static int sunxi_mmc_clk_set_phase(struct
> sunxi_mmc_host *host,
>  {
>  	int index;
>=20
> +	/* No need to set clk controller delays under new timings */
>  	if (host->use_new_timings)
>  		return 0;
>=20
> +	/* Some old controllers don't support delays */
> +	if (!host->cfg->clk_delays)
> +		return 0;
> +
>  	/* determine delays */
>  	if (rate <=3D 400000) {
>  		index =3D SDXC_CLK_400K;
> --
> 2.13.3
>=20
> <---
>=20
> Separately we should ask what is the proper set of config flags that
> describes the A64 EMMC controller.
>=20
> Regards
> ChenYu
>=20
>>=20
>> Fix this issue by adding this variable and setting it to true in
>> the configuration struct.
>>=20
>> Fixes: 4fb3ce07eafa ("mmc: sunxi: Add EMMC (MMC2) controller=20
>> compatible")
>>=20
>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>> ---
>>  drivers/mmc/host/sunxi-mmc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/mmc/host/sunxi-mmc.c=20
>> b/drivers/mmc/host/sunxi-mmc.c
>> index 59aba93beffb..4ad643e37014 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -1142,6 +1142,7 @@ static const struct sunxi_mmc_cfg=20
>> sun50i_a64_emmc_cfg =3D {
>>  	.idma_des_size_bits =3D 13,
>>  	.clk_delays =3D NULL,
>>  	.can_calibrate =3D true,
>> +	.needs_new_timings =3D true,
>>  };
>>=20
>>  static const struct of_device_id sunxi_mmc_of_match[] =3D {
>> --
>> 2.13.0
>>=20
>> --
>> You received this message because you are subscribed to the Google=20
>> Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send=
=20
>> an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
>> For more options, visit https://groups.google.com/d/optout.
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
