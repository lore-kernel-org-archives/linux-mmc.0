From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH 1/2] sdhci : handle busy timeout irq
Date: Thu, 24 Jul 2014 11:37:37 +0200
Message-ID: <20140724113737.7b06fd18@parrot.com>
References: <1404918112-27195-1-git-send-email-matthieu.castet@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:29938 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbaGXJh3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jul 2014 05:37:29 -0400
In-Reply-To: <1404918112-27195-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Any news on these patches ?

Le Wed, 9 Jul 2014 17:01:51 +0200,
Matthieu CASTET <matthieu.castet@parrot.com> a =E9crit :

> When we wait for busy after sending a command, if there is
> a timeout, we got SDHCI_INT_DATA_TIMEOUT flags.
> Before this commit we got the message :
> "Got data interrupt 0x00100000 even though no data  operation was in =
progress."
> and we need to wait 10s that sdhci_timeout_timer expires.
>=20
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
> ---
>  drivers/mmc/host/sdhci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 47055f3..9df59a4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2301,6 +2301,11 @@ static void sdhci_data_irq(struct sdhci_host *=
host, u32 intmask)
>  		 * above in sdhci_cmd_irq().
>  		 */
>  		if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
> +			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
> +				host->cmd->error =3D -ETIMEDOUT;
> +				tasklet_schedule(&host->finish_tasklet);
> +				return;
> +			}
>  			if (intmask & SDHCI_INT_DATA_END) {
>  				sdhci_finish_command(host);
>  				return;

