From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/5] mmc: omap_hsmmc: Avoid host->cmd dereference during
 data transfer failures
Date: Fri, 9 Nov 2012 21:18:24 +0530
Message-ID: <509D25C8.5010609@ti.com>
References: <1352220737-14071-1-git-send-email-svenkatr@ti.com> <1352220737-14071-2-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1352220737-14071-2-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 06 November 2012 10:22 PM, Venkatraman S wrote:
> Sometimes, a error occurs just after the Command has been reported
> to be successful (CC=1) but before data transfer completes (TC=1).
> Setting end_cmd=1 here leads to a NULL pointer dereference of
> host->cmd as the command complete has previously been handled.
>
> Set end_cmd only when command complete has not been handled
> before, else a NULL pointer dereference occurs.
>
> CC: stable@vger.kernel.org

Removing stable list as this is not applicable for previous major
release. Sent a patch to fix the same in different way.

> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>   drivers/mmc/host/omap_hsmmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 5434fd8..06d2e03 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -996,7 +996,8 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>   		else if (status & (CMD_CRC | DATA_CRC))
>   			hsmmc_command_incomplete(host, -EILSEQ);
>
> -		end_cmd = 1;
> +		if (host->cmd)
> +			end_cmd = 1;
>   		if (host->data || host->response_busy) {
>   			end_trans = 1;
>   			host->response_busy = 0;
>

