From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix oops in atmci_tasklet_func
Date: Tue, 10 Sep 2013 10:04:22 +0200
Message-ID: <522ED286.4030305@atmel.com>
References: <1378740719-25164-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:13478 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab3IJIEW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Sep 2013 04:04:22 -0400
In-Reply-To: <1378740719-25164-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, giometti@enneenne.com, cjb@laptop.org

On 09/09/2013 17:31, ludovic.desroches@atmel.com :
> From: Rodolfo Giometti <giometti@enneenne.com>
>
> In some cases, a NULL pointer dereference happens because data is NULL when
> STATE_END_REQUEST case is reached in atmci_tasklet_func.
>
> Cc: <stable@vger.kernel.org> #3.9+
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.

> ---
>   drivers/mmc/host/atmel-mci.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index e9ea2fc..78d7e47 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1792,12 +1792,14 @@ static void atmci_tasklet_func(unsigned long priv)
>   			if (unlikely(status)) {
>   				host->stop_transfer(host);
>   				host->data = NULL;
> -				if (status & ATMCI_DTOE) {
> -					data->error = -ETIMEDOUT;
> -				} else if (status & ATMCI_DCRCE) {
> -					data->error = -EILSEQ;
> -				} else {
> -					data->error = -EIO;
> +				if (data) {
> +					if (status & ATMCI_DTOE) {
> +						data->error = -ETIMEDOUT;
> +					} else if (status & ATMCI_DCRCE) {
> +						data->error = -EILSEQ;
> +					} else {
> +						data->error = -EIO;
> +					}
>   				}
>   			}
>
>


-- 
Nicolas Ferre
