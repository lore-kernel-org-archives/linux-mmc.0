From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCHv7 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
Date: Tue, 29 Jul 2014 11:01:19 -0700
Message-ID: <CAD=FV=VnP7q0UE0uP_8Hzbhtu6qJqz2kUR9E_sfk4wHbBH_7cg@mail.gmail.com>
References: <1406514579-3769-1-git-send-email-jh80.chung@samsung.com>
	<1406514579-3769-6-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406514579-3769-6-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
List-Id: linux-mmc@vger.kernel.org

Jaehoon,

On Sun, Jul 27, 2014 at 7:29 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Replaced the "disable-wp" into host's quirks.
> (Because the slot-node is removed at dt-file.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |   12 +++++-------
>  include/linux/mmc/dw_mmc.h |    6 ++----
>  2 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..4a4f66f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -997,7 +997,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>         int gpio_ro = mmc_gpio_get_ro(mmc);
>
>         /* Use platform get_ro function, else try on board write protect */
> -       if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
> +       if (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT)

It doesn't seem like it would be hard to include support for the old
binding (and just print a warning).  Then this could land ahead of the
device tree changes.

Generally I think we're supposed to keep support for old device trees
if possible (except in extreme cases).

-Doug
