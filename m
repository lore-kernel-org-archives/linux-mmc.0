From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Fri, 21 Dec 2012 12:05:19 +0100
Message-ID: <CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:32796 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2LULFV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 06:05:21 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so1999658wgb.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Dec 2012 03:05:20 -0800 (PST)
In-Reply-To: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On 14 December 2012 16:38, Pawel Moll <pawel.moll@arm.com> wrote:
> The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
> and v116/216) contains a modified version of the PL180 MMCI, with
> PeriphID Configuration value changed to 0x2.
>
> This version adds an optional "hardware flow control" feature. When
> enabled MMC card clock will be automatically disabled when FIFO is
> about to over/underflow and re-enabled once the host retrieved some
> data. This makes the controller immune to over/underrun errors caused
> by big interrupt handling latencies.
>
> This patch adds relevant device variant in the driver.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/mmc/host/mmci.c |   13 +++++++++++++
>  drivers/mmc/host/mmci.h |    2 ++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index edc3e9b..b2b550f 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -86,6 +86,14 @@ static struct variant_data variant_arm_extended_fifo = {
>         .pwrreg_powerup         = MCI_PWR_UP,
>  };
>
> +static struct variant_data variant_arm_extended_fifo_hwfc = {
> +       .fifosize               = 128 * 4,
> +       .fifohalfsize           = 64 * 4,
> +       .clkreg_enable          = MCI_ARM_HWFCEN,

So enabling this in the variant will also effect how the clock is
being set/gated when the clock freq is 0.

Please have a look at "mmc: mmci: Gate the clock when freq is 0", a
patch I sent out as of 12 dec.
That patch is using the power register to gate the clock. Will that
work with this new version of the PL180 as well? If not, that patch
must be reworked.

> +       .datalength_bits        = 16,
> +       .pwrreg_powerup         = MCI_PWR_UP,
> +};
> +
>  static struct variant_data variant_u300 = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
> @@ -1628,6 +1636,11 @@ static struct amba_id mmci_ids[] = {
>                 .data   = &variant_arm_extended_fifo,
>         },
>         {
> +               .id     = 0x02041180,
> +               .mask   = 0xff0fffff,
> +               .data   = &variant_arm_extended_fifo_hwfc,
> +       },
> +       {
>                 .id     = 0x00041181,
>                 .mask   = 0x000fffff,
>                 .data   = &variant_arm,
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index d437ccf..00d6d0c 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -28,6 +28,8 @@
>  #define MCI_ST_UX500_NEG_EDGE  (1 << 13)
>  #define MCI_ST_UX500_HWFCEN    (1 << 14)
>  #define MCI_ST_UX500_CLK_INV   (1 << 15)
> +/* Modified PL180 on Versatile Express platform */
> +#define MCI_ARM_HWFCEN         (1 << 12)
>
>  #define MMCIARGUMENT           0x008
>  #define MMCICOMMAND            0x00c
> --
> 1.7.10.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
