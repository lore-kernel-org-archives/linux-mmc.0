From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
Date: Thu, 31 Jan 2019 11:32:59 +0200
Message-ID: <ee3dc963-53f0-e362-caa5-069ce0e6eae7@intel.com>
References: <20190114191724.29960-1-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114191724.29960-1-alamy.liu@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 14/01/19 9:17 PM, Alamy Liu wrote:
> Prevent to use fixed value (NUM_SLOTS) after it had been determined
> and saved in a variable (cq_host->num_slots).

num_slots is always 32 (i.e. NUM_SLOTS) so why not go the other way and get
rid of num_slots and just use NUM_SLOTS?

> 
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 159270e947..26d63594b7 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>  		 * The only way to guarantee forward progress is to mark at
>  		 * least one task in error, so if none is indicated, pick one.
>  		 */
> -		for (tag = 0; tag < NUM_SLOTS; tag++) {
> +		for (tag = 0; tag < cq_host->num_slots; tag++) {
>  			slot = &cq_host->slot[tag];
>  			if (!slot->mrq)
>  				continue;
> 
