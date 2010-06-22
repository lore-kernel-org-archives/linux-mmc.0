From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 07/12] mmci: pass power_mode to the translate_vdd callback
Date: Wed, 23 Jun 2010 00:03:47 +0200
Message-ID: <AANLkTil2Cb4alVFkfEjXApMgIdkmNvEEarWkT9AhXIdU@mail.gmail.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44401 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0FVWDt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 18:03:49 -0400
Received: by bwz9 with SMTP id 9so237242bwz.19
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2010 15:03:48 -0700 (PDT)
In-Reply-To: <1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

Thinking a bit about this patch tonight:

2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:

> Platforms may have some external power control which need to be
> controlled from board specific code. =A0This is the case for some ver=
sions
> of the MOP500 board (U8500 platform).
>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
> =A0drivers/mmc/host/mmci.c =A0 | =A0 =A03 ++-
> =A0include/linux/amba/mmci.h | =A0 =A06 ++++--
> =A02 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 322958f..63eb7f4 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -483,7 +483,8 @@ static void mmci_set_ios(struct mmc_host *mmc, st=
ruct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * power control behind this translate=
 function.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->vcc && host->plat->translat=
e_vdd)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr |=3D host->plat->tr=
anslate_vdd(mmc_dev(mmc), ios->vdd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr |=3D host->plat->tr=
anslate_vdd(mmc_dev(mmc), ios->vdd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ios->power_mode);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* The ST version does not have this, =
fall through to POWER_ON */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->hw_designer !=3D AMBA_VENDOR=
_ST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwr |=3D MCI_PWR_UP;
> diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
> index f9d1bb5..61b5810 100644
> --- a/include/linux/amba/mmci.h
> +++ b/include/linux/amba/mmci.h
> @@ -17,7 +17,8 @@
> =A0* mmc/host.h
> =A0* @translate_vdd: a callback function to translate a MMC_VDD_*
> =A0* mask into a value to be binary or:ed and written into the
> - * MMCIPWR register of the block
> + * MMCIPWR register of the block. =A0May also control external power
> + * based on the power_mode.

Actually this callback is named like that for a reason: it is to be use=
d
to translate the MMC_VDD_* into a u8:4 bitmask for the MMCIPWR
register, 4 bits possibly routed out of the PL180 block on some
designs (never seen in practice, but could be used in theory).

So it translates a voltage into a 4-bit bitmask, hence the name.

Now the semantics are altered to have other side-effects in
the platform, so the function should be renamed, something like
platform_vdd_handler() would be more appropriate.

Yours,
Linus Walleij
