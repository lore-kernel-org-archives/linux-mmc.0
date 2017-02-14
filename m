From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: fix multi-bit bus width without high-speed mode
Date: Tue, 14 Feb 2017 09:11:40 +0100
Message-ID: <CAPDyKFrzzwKjvbB0HjnOyy06qJTCj2B+OPempovMQSrd-A9Nwg@mail.gmail.com>
References: <20170213114641.372-1-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34708 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdBNILq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 03:11:46 -0500
Received: by mail-vk0-f47.google.com with SMTP id r136so75695991vke.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 00:11:46 -0800 (PST)
In-Reply-To: <20170213114641.372-1-anssi.hannula@bitwise.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>

- Seungwon (due to bouncing email)

On 13 February 2017 at 12:46, Anssi Hannula <anssi.hannula@bitwise.fi> wrote:
> Commit 577fb13199b1 ("mmc: rework selection of bus speed mode")
> refactored bus width selection code to mmc_select_bus_width().
>
> However, it also altered the behavior to not call the selection code in
> non-high-speed modes anymore.
>
> This causes 1-bit mode to always be used when the high-speed mode is not
> enabled, even though 4-bit and 8-bit bus are valid bus widths in the
> backwards-compatibility (legacy) mode as well (see e.g. 5.3.2 Bus Speed
> Modes in JEDEC 84-B50). This results in a significant regression in
> transfer speeds.
>
> Fix the code to allow 4-bit and 8-bit widths even without high-speed
> mode, as before.
>
> Tested with a Zynq-7000 PicoZed 7020 board.
>
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 577fb13199b1 ("mmc: rework selection of bus speed mode")

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b61b52f9..0fccca0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1706,10 +1706,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 err = mmc_select_hs400(card);
>                 if (err)
>                         goto free_card;
> -       } else if (mmc_card_hs(card)) {
> +       } else {
>                 /* Select the desired bus width optionally */
>                 err = mmc_select_bus_width(card);
> -               if (err > 0) {
> +               if (err > 0 && mmc_card_hs(card)) {
>                         err = mmc_select_hs_ddr(card);
>                         if (err)
>                                 goto free_card;
> --
> 2.8.3
>
