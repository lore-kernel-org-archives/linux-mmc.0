From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH] mmc: dw_mmc: avoid race condition of cpu and IDMAC
Date: Wed, 17 Aug 2016 18:52:19 +0900
Message-ID: <2562aa02-f83c-9d04-9cd9-c2de2a34d629@samsung.com>
References: <CGME20160816032803epcas1p4e04d5cf42e25d1dd6480961cc0c96475@epcas1p4.samsung.com>
 <1471317827-6049-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-reply-to: <1471317827-6049-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 08/16/2016 12:23 PM, Shawn Lin wrote:
> We could see an obvious race condition by test that
> the former write operation by IDMAC aiming to clear
> OWN bit reach right after the later configuration of
> the same desc, which makes the IDMAC be in SUSPEND
> state as the OWN bit was cleared by the asynchronous
> write operation of IDMAC. The bug can be very easy
> reproduced on RK3288 or similar when lowering the
> bandwidth of bus and aggravating the Qos to make the
> large numbers of IP fight for the priority. One possible
> replaceable solution may be alloc dual buff for the
> desc to avoid it but could still race each other
> theoretically.

It makes sense.
But Sorry..i didn't understand what "when lowering the bandwidth of bus.." means..

According to TRM, we need to check whether OWN bit is set or not.
But it seems that it's related with controlling PLDMND register. 
I need to check and read TRM in more detail.

> 
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 32380d5..7b01fab 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -490,6 +490,23 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
>  				length -= desc_len;
>  
>  				/*
> +				 * OWN bit should be clear by IDMAC after
> +				 * finishing transfer. Let's wait for the
> +				 * asynchronous operation of IDMAC and cpu
> +				 * to make sure that we do not rely on the
> +				 * order of Qos of bus and architecture.
> +				 * Otherwise we could see a race condition
> +				 * here that the former write operation of
> +				 * IDMAC(to clear the OWN bit) reach right
> +				 * after the later new configuration of desc
> +				 * which makes value of desc been covered
> +				 * leading to DMA_SUSPEND state as IDMAC fecth
> +				 * the wrong desc then.
> +				 */
> +				while ((readl(&desc->des0) & IDMAC_DES0_OWN))
> +					;

Well, I don't like this style..because it has the potential risk for infinite loop.
And Could you make the comment more simpler than now?

> +
> +				/*
>  				 * Set the OWN bit and disable interrupts
>  				 * for this descriptor
>  				 */
> @@ -535,6 +552,23 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
>  				length -= desc_len;
>  
>  				/*
> +				 * OWN bit should be clear by IDMAC after
> +				 * finishing transfer. Let's wait for the
> +				 * asynchronous operation of IDMAC and cpu
> +				 * to make sure that we do not rely on the
> +				 * order of Qos of bus and architecture.
> +				 * Otherwise we could see a race condition
> +				 * here that the former write operation of
> +				 * IDMAC(to clear the OWN bit) reach right
> +				 * after the later new configuration of desc
> +				 * which makes value of desc been covered
> +				 * leading to DMA_SUSPEND state as IDMAC fecth
> +				 * the wrong desc then.
> +				 */
> +				while ((readl(&desc->des0) & IDMAC_DES0_OWN))
> +					;

Ditto.

> +
> +				/*
>  				 * Set the OWN bit and disable interrupts
>  				 * for this descriptor
>  				 */
> 
