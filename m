From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mmc: core: expose RPMB partition only for CMD23 capable
 host
Date: Fri, 25 Jan 2013 13:16:45 +0100
Message-ID: <510277AD.20907@ti.com>
References: <1359113430-10951-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58300 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756347Ab3AYMQu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Jan 2013 07:16:50 -0500
In-Reply-To: <1359113430-10951-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, loic.pallardy-ext@stericsson.com

On 01/25/2013 12:30 PM, Balaji T K wrote:
> SET_BLOCK_COUNT CMD23 is needed for all access to RPMB partition.
> If block count is not set by CMD23, all subsequent read/write command=
s
> fail as per eMMC specification. So, If the host does not support CMD2=
3,
> do not expose RPMB partition.
>=20
> Accessing RPMB partition can cause hang / huge delay
> for host which do not support CMD23.

Can this patch make it's way to 3.8? Without this patch my OMAP4 board'=
s eMMC
is not accessible causing blkid (via udev) to time out and slowing down=
 the
boot process.

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mmc/core/mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e6e3911..089e8ea 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -496,7 +496,7 @@ static int mmc_read_ext_csd(struct mmc_card *card=
, u8 *ext_csd)
>  		 * RPMB regions are defined in multiples of 128K.
>  		 */
>  		card->ext_csd.raw_rpmb_size_mult =3D ext_csd[EXT_CSD_RPMB_MULT];
> -		if (ext_csd[EXT_CSD_RPMB_MULT]) {
> +		if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host)) {
>  			mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
>  				EXT_CSD_PART_CONFIG_ACC_RPMB,
>  				"rpmb", 0, false,
>=20


--=20
P=E9ter
