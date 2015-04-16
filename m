From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 02/15] mmc: core: Enable / disable re-tuning
Date: Thu, 16 Apr 2015 10:57:05 +0200
Message-ID: <CAPDyKFpsBA+B3NbopfYQRgo+KKJpWsseo3bCJx-ToR5bOzJYUg@mail.gmail.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
	<1429017146-15981-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33384 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756939AbbDPI5H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 04:57:07 -0400
Received: by qkx62 with SMTP id 62so125031483qkx.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2015 01:57:05 -0700 (PDT)
In-Reply-To: <1429017146-15981-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 14 April 2015 at 15:12, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Enable re-tuning when tuning is executed and
> disable re-tuning when card is no longer initialized.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c296bc0..dd43f9b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1109,6 +1109,8 @@ int mmc_execute_tuning(struct mmc_card *card)
>
>         if (err)
>                 pr_err("%s: tuning execution failed\n", mmc_hostname(host));
> +       else
> +               mmc_retune_enable(host);
>
>         return err;
>  }
> @@ -1140,6 +1142,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>   */
>  void mmc_set_initial_state(struct mmc_host *host)
>  {
> +       mmc_retune_disable(host);
> +
>         if (mmc_host_is_spi(host))
>                 host->ios.chip_select = MMC_CS_HIGH;
>         else
> --
> 1.9.1

I don't think you have fully considered these cases for the mmc/sd/sdio cards.

1) Card removal/detect (hold/release?)
2) system PM (disable?)
3) runtime PM (disable?)
4) reset (?)

Kind regards
Uffe
