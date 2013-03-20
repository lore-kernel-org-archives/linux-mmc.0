From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
Date: Wed, 20 Mar 2013 09:42:31 +0100
Message-ID: <CAPDyKFqV4M7YzfOAvOMX5vjbw7pf1XA8tbPK+cVNVERWhox6eg@mail.gmail.com>
References: <1363758095-32378-1-git-send-email-Chang-Ming.Huang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:41991 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3CTImc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 04:42:32 -0400
Received: by mail-ve0-f178.google.com with SMTP id db10so1186390veb.9
        for <linux-mmc@vger.kernel.org>; Wed, 20 Mar 2013 01:42:31 -0700 (PDT)
In-Reply-To: <1363758095-32378-1-git-send-email-Chang-Ming.Huang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chang-Ming.Huang@freescale.com
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 20 March 2013 06:41,  <Chang-Ming.Huang@freescale.com> wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> In order to check whether the card has been removed, the function
> mmc_send_status() will send command CMD13 to card and ask the card
> to send its status register to sdhc driver, which will generate
> many interrupts repeatedly and make the system performance bad.
> From the performance test on Freescale's board (such as Iozone for SD),
> the performance will degrade about 4~6%.
>
> There is one another way to get this information,
> which is to read the register PRSSTAT and check the bit CDPL or CINS.
> If the card is present, these two bit will set to one.
> Therefore, add callback function get_cd() to check whether
> the card has been inserted/removed when the driver supports this feature.
> If the card is present, 0 will return, if the card is absent, 1 will return.
> If the controller will not support this feature, -ENOSYS will return.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Reviewed-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
>         - when controller don't support get_cd, return -ENOSYS
>         - add the CC
> changes for v3:
>         - enalbe the controller clock in platform, instead of core
> changes for v4:
>         - move the detect code to core.c according to the new structure
> changes for v5:
>         - reviewed by Anton and Johan, add the reviewed-by.
> changes for v6:
>         - add more comment.
>
>  drivers/mmc/core/core.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 08a3cf2..e225deb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2280,7 +2280,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>
>  int _mmc_detect_card_removed(struct mmc_host *host)
>  {
> -       int ret;
> +       int ret = -ENOSYS;
>
>         if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
>                 return 0;
> @@ -2288,7 +2288,19 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>         if (!host->card || mmc_card_removed(host->card))
>                 return 1;
>
> -       ret = host->bus_ops->alive(host);
> +       /* First, try host-controller's card detect callback */
> +       if (host->ops->get_cd) {
> +               ret = host->ops->get_cd(host);
> +               /*
> +                * The return value from get_cd: 1 for present, 0 for absent,
> +                * we need to convert it to: 1 for absent, 0 for present.
> +                */
> +               if (ret >= 0)
> +                       ret = !ret;
> +       }
> +       /* If failed, back to the bus_ops alive() callback */
> +       if (ret < 0)
> +               ret = host->bus_ops->alive(host);
>         if (ret) {
>                 mmc_card_set_removed(host->card);
>                 pr_debug("%s: card remove detected\n", mmc_hostname(host));

I guess this already has been fixed by Kevin's patch below.

http://article.gmane.org/gmane.linux.kernel.mmc/19481

> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
