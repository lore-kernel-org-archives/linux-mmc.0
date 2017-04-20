From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: hide clock message when card is resuming
Date: Thu, 20 Apr 2017 19:06:12 +0900
Message-ID: <25b5c103-ed7c-d03f-d285-bde651691ba1@samsung.com>
References: <CGME20170419145649epcas2p428230d6fa04b2b6905e500f7b0a33297@epcas2p4.samsung.com>
 <1492613756-16740-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1492613756-16740-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Kochetkov <al.kochet@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Alexander,

On 04/19/2017 11:55 PM, Alexander Kochetkov wrote:
> Commit e9748e0364fe ("mmc: dw_mmc: force setup bus if active slots exist")
> made a change resulted in clock message appears every time the card is
> resuming (every 5 second in average). Add condition that previously used to
> print the message.

I think you are not using the latest kernel. which version do you use?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce69e2fea093b7fa3991c87849c4955cd47796c9

Could you check this?

Best Regards,
Jaehoon Chung

> 
> Fixes: e9748e0364fe ("mmc: dw_mmc: force setup bus if active slots exist")
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 73db085..faaf2c1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1178,7 +1178,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  
>  		if ((clock != slot->__clk_old &&
>  			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
> -			force_clkinit) {
> +		    (force_clkinit &&
> +			(slot->mmc->pm_flags & MMC_PM_KEEP_POWER))) {
>  			dev_info(&slot->mmc->class_dev,
>  				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
>  				 slot->id, host->bus_hz, clock,
> 
