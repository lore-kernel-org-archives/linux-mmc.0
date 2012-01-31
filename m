From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: Fix Low speed mmc card detection failure
Date: Tue, 31 Jan 2012 09:08:34 +0530
Message-ID: <CAGxe1ZHmnKAOpSy9X=vSYOPupQNwv2MDUE_DVT+pOYXGPch8qA@mail.gmail.com>
References: <1326943579-30952-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63427 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab2AaDif convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2012 22:38:35 -0500
In-Reply-To: <1326943579-30952-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

Hi Chris,
can you consider this patch in your next branch.

regards
Girish K S

On 19 January 2012 08:56, Girish K S <girish.shivananjappa@linaro.org> =
wrote:
> This patch fixes the failure of low speed mmc card detection
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index dc03291..2bc586b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1020,7 +1020,8 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_hs2=
00(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (host->caps & MMC_CAP_MMC_HIGH=
SPEED)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_HS_TIMING, 1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_HS_TIMING, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0card->ext_csd.generic_cmd6_time);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
> @@ -1130,7 +1131,7 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
> =A0 =A0 =A0 =A0 * Activate wide bus and DDR (if supported).
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (!mmc_card_hs200(card) &&
> - =A0 =A0 =A0 =A0 =A0 (card->csd.mmca_vsn >=3D CSD_SPEC_VER_3) &&
> + =A0 =A0 =A0 =A0 =A0 (card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
> =A0 =A0 =A0 =A0 =A0 =A0(host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_=
BIT_DATA))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0static unsigned ext_csd_bits[][2] =3D =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ EXT_CSD_BUS_WIDTH_8,=
 EXT_CSD_DDR_BUS_WIDTH_8 },
> --
> 1.7.1
>
