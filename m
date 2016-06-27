From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Fix sdhci_card_busy()
Date: Mon, 27 Jun 2016 11:21:45 +0200
Message-ID: <CAPDyKFpjJdWnxpJThEXKz53VuG3kp=qQYZXY6ykyMD3bm=B9uw@mail.gmail.com>
References: <1466679658-18604-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35194 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbcF0JVs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 05:21:48 -0400
Received: by mail-wm0-f54.google.com with SMTP id v199so91710372wmv.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2016 02:21:47 -0700 (PDT)
In-Reply-To: <1466679658-18604-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 23 June 2016 at 13:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> host->card_busy() was introduced for SD voltage switching which checks all
> 4 data lines.
>
> Increasingly, host->card_busy is being used to poll the the busy signal
> which is only data line 0 (DAT[0]).
>
> The current logic in sdhci_card_busy() does not work in that case because
> it returns false if any of the data lines is high.  It also ignores
> possibilities:
>         - data lines 1-3 are not connected and could show at any level
>         - data lines 1-2 can be used by SDIO for other purposes
>
> According to the SD specification, it is OK to check any of the data lines
> for voltage switching, so change to use DAT[0] only.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
>
>  It would probably be better for this patch to go before
>  "mmc: mmc: Use ->card_busy() to detect busy cards in __mmc_switch()"
>

Thanks, applied for next and prior the above mentioned patch!
Kind regards
Uffe

>
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ec14b5d61fc6..15bdbcb99170 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1811,10 +1811,10 @@ static int sdhci_card_busy(struct mmc_host *mmc)
>         struct sdhci_host *host = mmc_priv(mmc);
>         u32 present_state;
>
> -       /* Check whether DAT[3:0] is 0000 */
> +       /* Check whether DAT[0] is 0 */
>         present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
>
> -       return !(present_state & SDHCI_DATA_LVL_MASK);
> +       return !(present_state & SDHCI_DATA_0_LVL_MASK);
>  }
>
>  static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
> --
> 1.9.1
>
