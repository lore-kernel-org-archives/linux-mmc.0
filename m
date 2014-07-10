From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv3 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
Date: Thu, 10 Jul 2014 11:15:52 +0200
Message-ID: <CAPDyKFoQ_ER7FAk_jCBURAa3_hVT25GXfQQfiDhMoYypdA=fHg@mail.gmail.com>
References: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
	<1404976119-10777-6-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:50308 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbaGJJPx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 05:15:53 -0400
Received: by mail-qg0-f43.google.com with SMTP id z60so7464211qgd.30
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2014 02:15:52 -0700 (PDT)
In-Reply-To: <1404976119-10777-6-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10 July 2014 09:08, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Replaced the "disable-wp" into host's quirks.
> (Because the slot-node is removed at dt-file.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Hi Jaehoon,

I plan to carry these patches through my mmc tree and I will share
them through a PR from an immutable branch with the ARM SoC guys.
Please tell me if you have any concern with this set up.

Now, while I was applying this patch, I found it had checkpatch
errors. Please run checkpatch and resend a new version.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..a3ccd07 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -997,7 +997,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>         int gpio_ro = mmc_gpio_get_ro(mmc);
>
>         /* Use platform get_ro function, else try on board write protect */
> -       if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
> +       if (slot->host->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
>                 read_only = 0;
>         else if (!IS_ERR_VALUE(gpio_ro))
>                 read_only = gpio_ro;
> @@ -2006,12 +2006,7 @@ static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
>  static struct dw_mci_of_slot_quirks {
>         char *quirk;
>         int id;
> -} of_slot_quirks[] = {
> -       {
> -               .quirk  = "disable-wp",
> -               .id     = DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
> -       },
> -};
> +} of_slot_quirks[] = {};
>
>  static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>  {
> @@ -2238,6 +2233,9 @@ static struct dw_mci_of_quirks {
>         {
>                 .quirk  = "broken-cd",
>                 .id     = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> +       },{
> +               .quirk  = "disable-wp",
> +               .id     = DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
>         },
>  };
>
> --
> 1.7.9.5
>
