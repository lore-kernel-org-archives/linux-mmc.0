From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 12:55:59 +0100
Message-ID: <CAFLxGvyuE8odPdNSD1PTccyBXFm=JO=ooikUOJfz41aFpsUAJg@mail.gmail.com>
References: <1422359304-30321-1-git-send-email-holler@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422359304-30321-1-git-send-email-holler@ahsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 27, 2015 at 12:48 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> It's an interesting detail, so inform the user about it.
>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  drivers/mmc/core/bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 8a1f124..4a60028 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -347,6 +347,10 @@ int mmc_add_card(struct mmc_card *card)
>                         uhs_bus_speed_mode, type, card->rca);
>         }
>
> +       if (mmc_can_secure_erase_trim(card))
> +               pr_info("%s: card supports secure erase/trim\n",
> +                       mmc_hostname(card->host));
> +

Please make this a sysfs attribute.
Exposing such properties as log messages is horrible.

-- 
Thanks,
//richard
