From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 12/15] mmc: sdhci: Flag re-tuning is needed on CRC or
 End-Bit errors
Date: Mon, 4 May 2015 15:55:35 +0200
Message-ID: <CAPDyKFry+QwUGc4yYDPV1fC9LQYit41uh+s0du7dpxSM0te=Bg@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<1429531796-21987-13-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34760 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbEDNzg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 09:55:36 -0400
Received: by qcyk17 with SMTP id k17so71883131qcy.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 May 2015 06:55:36 -0700 (PDT)
In-Reply-To: <1429531796-21987-13-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> CRC or End-Bit errors could possibly be alleviated by
> re-tuning so flag re-tuning needed in those cases.
> Note this has no effect if re-tuning has not been
> enabled.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b345844..d11fae7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2307,8 +2307,10 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
>         if (intmask & SDHCI_INT_TIMEOUT)
>                 host->cmd->error = -ETIMEDOUT;
>         else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
> -                       SDHCI_INT_INDEX))
> +                       SDHCI_INT_INDEX)) {
>                 host->cmd->error = -EILSEQ;
> +               mmc_retune_needed(host->mmc);

I would rather see this to be handled by the mmc core, to have all
hosts benefit from it.

> +       }
>
>         if (host->cmd->error) {
>                 tasklet_schedule(&host->finish_tasklet);
> @@ -2433,13 +2435,15 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>
>         if (intmask & SDHCI_INT_DATA_TIMEOUT)
>                 host->data->error = -ETIMEDOUT;
> -       else if (intmask & SDHCI_INT_DATA_END_BIT)
> +       else if (intmask & SDHCI_INT_DATA_END_BIT) {
>                 host->data->error = -EILSEQ;
> -       else if ((intmask & SDHCI_INT_DATA_CRC) &&
> +               mmc_retune_needed(host->mmc);
> +       } else if ((intmask & SDHCI_INT_DATA_CRC) &&
>                 SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
> -                       != MMC_BUS_TEST_R)
> +                       != MMC_BUS_TEST_R) {
>                 host->data->error = -EILSEQ;
> -       else if (intmask & SDHCI_INT_ADMA_ERROR) {
> +               mmc_retune_needed(host->mmc);
> +       } else if (intmask & SDHCI_INT_ADMA_ERROR) {
>                 pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
>                 sdhci_adma_show_error(host);
>                 host->data->error = -EIO;
> --
> 1.9.1
>

Kind regards
Uffe
