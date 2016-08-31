From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: avoid race condition of cpu and IDMAC
Date: Wed, 31 Aug 2016 15:58:04 +0900
Message-ID: <30134bdf-bd25-9a7f-8888-a02b83dd178e@samsung.com>
References: <1471599615-6249-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160819095647epcas1p3e5d5153aa6a15a69285d50ca0dbae3d5@epcas1p3.samsung.com>
 <1471599615-6249-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49700 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbcHaG6H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 02:58:07 -0400
In-reply-to: <1471599615-6249-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 08/19/2016 06:40 PM, Shawn Lin wrote:
> We could see an obvious race condition by test that
> the former write operation by IDMAC aiming to clear
> OWN bit reach right after the later configuration of
> the same desc, which makes the IDMAC be in SUSPEND
> state as the OWN bit was cleared by the asynchronous
> write operation of IDMAC. The bug can be very easy
> reproduced on RK3288 or similar when we reduce the
> running rate of system buses and keep the CPU running
> faster. So as two separate masters, IDMAC and cpu
> write the same descriptor stored on the same address,
> and this should be protected by adding check of OWN
> bit before preparing new descriptors.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0a5a49f..e640f83 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -473,6 +473,7 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
>  {
>  	unsigned int desc_len;
>  	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
>  	int i;
>  
>  	desc_first = desc_last = desc = host->sg_cpu;
> @@ -489,6 +490,20 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
>  			length -= desc_len;
>  
>  			/*
> +			 * Wait for the former clear OWN bit operation
> +			 * of IDMAC to make sure that this descriptor
> +			 * isn't still owned by IDMAC as IDMAC's write
> +			 * ops and CPU's read ops are asynchronous.
> +			 */
> +			while (readl(&desc->des0) & IDMAC_DES0_OWN) {
> +				if (time_after(jiffies, timeout)) {
> +					dev_err(host->dev, "DESC is still owned by IDMAC.\n");
> +					break;

Doesn't it need the error handling? Just display the message?

Best Regards,
Jaehoon Chung

> +				}
> +				udelay(10);
> +			}
> +
> +			/*
>  			 * Set the OWN bit and disable interrupts
>  			 * for this descriptor
>  			 */
> @@ -525,6 +540,7 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
>  {
>  	unsigned int desc_len;
>  	struct idmac_desc *desc_first, *desc_last, *desc;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
>  	int i;
>  
>  	desc_first = desc_last = desc = host->sg_cpu;
> @@ -541,6 +557,20 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
>  			length -= desc_len;
>  
>  			/*
> +			 * Wait for the former clear OWN bit operation
> +			 * of IDMAC to make sure that this descriptor
> +			 * isn't still owned by IDMAC as IDMAC's write
> +			 * ops and CPU's read ops are asynchronous.
> +			 */
> +			while (readl(&desc->des0) & IDMAC_DES0_OWN) {
> +				if (time_after(jiffies, timeout)) {
> +					dev_err(host->dev, "DESC is still owned by IDMAC.\n");
> +					break;
> +				}
> +				udelay(10);
> +			}
> +
> +			/*
>  			 * Set the OWN bit and disable interrupts
>  			 * for this descriptor
>  			 */
> 

