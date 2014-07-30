From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCHv8 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
Date: Wed, 30 Jul 2014 08:57:28 -0700
Message-ID: <CAD=FV=WtszfdhsPM_gQoENup0VeP3o74V=UVDbCBkaC3WuaS8A@mail.gmail.com>
References: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com>
	<1406718310-32078-6-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406718310-32078-6-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpgs ." <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Jaehoon,

On Wed, Jul 30, 2014 at 4:05 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Replaced the "disable-wp" into host's quirks.
> (Because the slot-node is removed at dt-file.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |    8 +++++++-
>  include/linux/mmc/dw_mmc.h |    2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..8d9edc6 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -997,7 +997,10 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>         int gpio_ro = mmc_gpio_get_ro(mmc);
>
>         /* Use platform get_ro function, else try on board write protect */
> -       if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
> +       if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT) {
> +               dev_warn(slot->host->dev, "Recommend not to use 'disable-wp'"
> +                               "into slot-node. Change your dt-file!!");
> +       } else if (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT)

This isn't what I meant.  I meant that
"DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT" should continue to work normally
but print a warning once at bootup.  In other words, this code should
be:

-       if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
+       if ((slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT) ||
+           (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT)) {

Then add the warning in "dw_mci_of_get_slot_quirks" which is only
called once at init time.  You can warn if ANY slot quirks are
actually applied, like:

for (idx = 0; idx < ARRAY_SIZE(of_slot_quirks); idx++)
  if (of_get_property(np, of_slot_quirks[idx].quirk, NULL)) {
    dev_warn(dev, "Slot quirk %s is deprecated\n", of_slot_quirks[idx].quirk);
    quirks |= of_slot_quirks[idx].id;
  }


>                 read_only = 0;
>         else if (!IS_ERR_VALUE(gpio_ro))
>                 read_only = gpio_ro;
> @@ -2238,6 +2241,9 @@ static struct dw_mci_of_quirks {
>         {
>                 .quirk  = "broken-cd",
>                 .id     = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> +       }, {
> +               .quirk  = "disable-wp",
> +               .id     = DW_MCI_QUIRK_NO_WRITE_PROTECT,
>         },
>  };

If you fix it like I say, then this patch should actually be patch #2
in your series and can be applied _before_ the device tree files.
That means you could land patch #1 and patch #2 right away without
even getting acks for the dts changes.  ...and if the dts changes have
conflicts they can be resolved later without blocking this patch.

-Doug
