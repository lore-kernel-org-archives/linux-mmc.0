From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Fix warning and undefined behavior in mmc
 voltage handling
Date: Mon, 29 Apr 2019 12:44:38 +0200
Message-ID: <CAPDyKFrORt9P1f2NmZRQkwY353K2jicRueWxY-aKVO9oTG_qOQ@mail.gmail.com>
References: <20190416075845.GA15615@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416075845.GA15615@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 16 Apr 2019 at 09:58, Pavel Machek <pavel@ucw.cz> wrote:
>
>
> !voltage_ranges is tested for too late, allowing warning and undefined
> behavior. Fix that.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied for next, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3a4402a..b3fa9c9 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -363,11 +363,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>         int num_ranges, i;
>
>         voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> -       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!voltage_ranges) {
>                 pr_debug("%pOF: voltage-ranges unspecified\n", np);
>                 return 0;
>         }
> +       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!num_ranges) {
>                 pr_err("%pOF: voltage-ranges empty\n", np);
>                 return -EINVAL;
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
