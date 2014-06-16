From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv7 1/2] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
Date: Mon, 16 Jun 2014 10:30:27 +0200
Message-ID: <CAPDyKFoxEs8k4ou0AyknL7-u7KYkg1==imNMSEv=imUS4KABNg@mail.gmail.com>
References: <1402633867-25155-1-git-send-email-jh80.chung@samsung.com>
	<1402633867-25155-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:64982 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbaFPIa2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 04:30:28 -0400
Received: by mail-qa0-f42.google.com with SMTP id dc16so7133505qab.29
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 01:30:27 -0700 (PDT)
In-Reply-To: <1402633867-25155-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Heiko St.bner" <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>

On 13 June 2014 06:31, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Replaced the "disable-wp" into host's quirks.
> (Because the slot-node is removed at dt-file.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks!

Applied for next.

Kind regards
Uffe

> ---
> Changelog V6/V7:
>         -None
> Changelog V5:
>         - Modify comment.
> Changelog V4:
>         - Rename Subject
>                 "[PATCHv3 2/4] mmc: dw_mmc: use the __mmc_of_parse to parse the slot node"
>         - Replace the "disable-wp" into host's quirks, according to remove the slot-node at dt-file.
> Changelog V3:
>         - Fix typo.
>         - Maintained the dw_mci_of_quirks().
> Changelog V2:
>         - None
>
>  drivers/mmc/host/dw_mmc.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..99fc939 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
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
> +       }, {
> +               .quirk  = "disable-wp",
> +               .id     = DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
>         },
>  };
>
> --
> 1.7.9.5
>
