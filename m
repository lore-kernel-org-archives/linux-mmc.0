From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: remove waiting time when clkgate_delay is
 set
Date: Thu, 01 Mar 2012 12:04:04 +0530
Message-ID: <4F4F185C.7090503@codeaurora.org>
References: <1330494769-7558-1-git-send-email-chanho61.park@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:19510 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757907Ab2CAGeI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 01:34:08 -0500
In-Reply-To: <1330494769-7558-1-git-send-email-chanho61.park@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chanho Park <chanho61.park@samsung.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

On 2/29/2012 11:22 AM, Chanho Park wrote:
> Since recent commit("mmc: core: Use delayed work in clock gating
> framework":597dd9d79cfbbb1), we always wait "unnecessary" default
> clock delay(8 cycles). Actually, we don't need it if clkgate_delay
> (unit:ms) is set because we already wait sufficient time to change
> the clock due to delayed_workqueue.
> This patch removes duplicated waiting time when clkgate_delay is set.
>
> Signed-off-by: Chanho Park<chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> ---
>   drivers/mmc/core/host.c |    7 +++++--
>   1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index c3704e2..d710ce0 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -109,8 +109,11 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
>   	 */
>   	if (!host->clk_requests) {
>   		spin_unlock_irqrestore(&host->clk_lock, flags);
> -		tick_ns = DIV_ROUND_UP(1000000000, freq);
> -		ndelay(host->clk_delay * tick_ns);
> +		/* wait only when clk_gate_delay is 0*/

Actually, we should check whether the clkgate_delay is giving sufficient 
clock cycles instead of just >0 value. But since min. f_min in freq. 
table is 100KHz (8CLK cyles is ~80us) and clkgate_delay can only 
specified in milliseconds as of now, I think this should be fine.

> +		if (!host->clkgate_delay) {
> +			tick_ns = DIV_ROUND_UP(1000000000, freq);
> +			ndelay(host->clk_delay * tick_ns);
> +		}
>   	} else {
>   		/* New users appeared while waiting for this work */
>   		spin_unlock_irqrestore(&host->clk_lock, flags);

Reviewed-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

Thanks,
Sujit
