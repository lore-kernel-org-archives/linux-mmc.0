From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: only invoke clock re-tuning for adtc type commands
Date: Mon, 17 Mar 2014 10:12:07 +0100
Message-ID: <CAPDyKFoGxa0Xp33o2OfUrFGbiHPvvLOg-ZE39DJLX2R2htKCHQ@mail.gmail.com>
References: <1389119511-26228-1-git-send-email-frankyl@broadcom.com>
	<1389119859-28955-1-git-send-email-frankyl@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:56196 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaCQJMI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Mar 2014 05:12:08 -0400
Received: by mail-qc0-f172.google.com with SMTP id i8so5620318qcq.31
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2014 02:12:08 -0700 (PDT)
In-Reply-To: <1389119859-28955-1-git-send-email-frankyl@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franky Lin <frankyl@broadcom.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 7 January 2014 19:37, Franky Lin <frankyl@broadcom.com> wrote:
> For high clock frequency modes, ie. SDR104 and possibly SDR50, the data
> window on the CMD and DAT lines needs to be tuned. Once tuned to a
> sample clock rate, a re-tuning might required because of drifted signal
> on different lines. This re-tuning is needed and only necessary for
> commands using the DAT lines, ie. adtc type commands. This patch is an
> optimization by adding the condition of the requested command being adtc
> type in order to execute the re-tuning procedure.
>
> Signed-off-by: Franky Lin <frankyl@broadcom.com>

Hi Franky,

Sorry for the delay.

> ---
>  drivers/mmc/host/sdhci.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cc00bed..f301cd6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1389,7 +1389,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                  * tuning procedure before sending command.
>                  */
>                 if ((host->flags & SDHCI_NEEDS_RETUNING) &&
> -                   !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
> +                   !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ)) &&
> +                   mmc_cmd_type(mrq->cmd) == MMC_CMD_ADTC) {

I don't have the in-depth knowledge about the sdhci; Still, to me it
seems like checking for MMC_CMD_ADTC, is that not just the same a
checking if there are a READ/WRITE?

Another note, we really should be working on moving the periodic
"re-tuning trigger" mechanism into the mmc core layer, so all host
driver's could benefit from this. Do you want to help out fixing this?

Kind regards
Ulf Hansson

>                         if (mmc->card) {
>                                 /* eMMC uses cmd21 but sd and sdio use cmd19 */
>                                 tuning_opcode =
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
