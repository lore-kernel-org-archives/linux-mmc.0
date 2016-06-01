From: Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
Date: Wed, 01 Jun 2016 11:19:06 +0200
Message-ID: <1464772746.3079.4.camel@ziswiler.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
	 <1464505484-3661-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464505484-3661-2-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-tegra@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, 2016-05-29 at 15:04 +0800, Chen-Yu Tsai wrote:
> When IS_ERR_VALUE was removed from the mmc core code, it was replaced
> with a simple not-zero check. This does not work, as the value
> checked
> is the return value for mmc_select_bus_width, which returns the set
> bit width on success. This made eMMC modes higher than HS-DDR
> unusable.
>=20
> Fix this by checking for a positive return value instead.
>=20
> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This fixes the following eMMC issue as experienced on Apalis T30 as
well:

[=C2=A0=C2=A0=C2=A0=C2=A07.194625] mmc1: mmc_select_hs200 failed, error=
 3
[=C2=A0=C2=A0=C2=A0=C2=A07.201549] mmc1: error 3 whilst initialising MM=
C card

Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> =C2=A0drivers/mmc/core/mmc.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c984321d1881..aafb73d080ca 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card
> *card)
> =C2=A0	=C2=A0* switch to HS200 mode if bus width is set successfully.
> =C2=A0	=C2=A0*/
> =C2=A0	err =3D mmc_select_bus_width(card);
> -	if (!err) {
> +	if (err > 0) {
> =C2=A0		val =3D EXT_CSD_TIMING_HS200 |
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0card->drive_strength << E=
XT_CSD_DRV_STR_SHIFT;
> =C2=A0		err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> =C2=A0	} else if (mmc_card_hs(card)) {
> =C2=A0		/* Select the desired bus width optionally */
> =C2=A0		err =3D mmc_select_bus_width(card);
> -		if (!err) {
> +		if (err > 0) {
> =C2=A0			err =3D mmc_select_hs_ddr(card);
> =C2=A0			if (err)
> =C2=A0				goto free_card;
