From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Revert "mmc: dw_mmc-rockchip: add runtime PM support"
Date: Mon, 23 Jan 2017 21:53:02 +0900
Message-ID: <845aea80-10a5-e8f9-5620-952bdcc37234@samsung.com>
References: <CGME20161228153516epcas2p253c6bc0371ab0df464573b63218795ef@epcas2p2.samsung.com>
 <1482939288-14950-1-git-send-email-ayaka@soulik.info>
 <e0cc8029-0155-4879-a643-ddc4239a55ab@samsung.com>
 <7e37b8ad-39d0-3a94-f75a-2166ae2caf10@samsung.com>
 <7fb90b9e-75c3-0184-4f0a-d4113899b860@rock-chips.com>
 <04b667d9-2591-51ff-e024-047bbb6e17c3@rock-chips.com>
 <6ccade72-ae20-2ffa-1504-2536b9f03adf@soulik.info>
 <95648282-38f5-42c2-fd8b-ab603eb3a168@gmail.com>
 <0ccf164f-0d35-9cc3-f288-9b582db23efb@soulik.info>
 <20afb1da-9e45-f515-01bf-2f5365d20d61@samsung.com>
 <8f8c66f1-82d6-5151-ff64-ef62596aa10d@rock-chips.com>
 <c8307da1-8e43-29b5-c87d-292a56831c98@samsung.com>
 <CABgxDo+3qMcHn6e2s_ZJy1crdi=ch5hQk6sy3W29Q12-ye33Qw@mail.gmail.com>
 <2cdd0b6c-a099-595d-1c0b-be7933b0d4a6@collabora.com>
 <fba28eda-51c7-2012-03ca-48b6f94e4a18@samsung.com>
 <20170123112432.08337d26.john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49098 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751016AbdAWMxG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2017 07:53:06 -0500
In-reply-to: <20170123112432.08337d26.john@metanate.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Romain Perier <romain.perier@collabora.com>, Romain Perier <romain.perier@gmail.com>, ulf.hansson@linaro.org, xzy.xu@rock-chips.com, Jaehoon Chung <jh80.chung@gmail.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Randy Li <randy.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, ayaka <ayaka@soulik.info>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi John,

On 01/23/2017 08:24 PM, John Keeping wrote:
> Hi,
> 
> On Fri, 20 Jan 2017 15:08:57 +0900, Jaehoon Chung wrote:
>> On 01/17/2017 10:38 PM, Romain Perier wrote:
>>> In my case I can reproduce the issue on the rock2 and the firefly-rk3288. A workaround is to
>>>
>>> comment the line ".pm = <&pm_ops_foo>" .  
>>
>> Sorry for late. I'm checking runtime PM for this. 
>> After that, i will decide whether revert or not.
> 
> I hit this problem on Rock2 when trying 4.10-rc4.  The following patch
> fixes it for me.

Could you check with Ulf's repository?

https://git.kernel.org/cgit/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=e86738ac78c22956f1c787ebafefc83d43cab30a

Shawn's patch was applied. If also occurred the same issue, let me know, plz.

> 
> I'm not sure if this is safe in general or whether it should be guarded
> by a quirk that is enabled for RK3288.
> 
> -- >8 --
> Subject: [PATCH] mmc: dw_mmc: restore CIU state on resume
> 
> At least on RK3288, asserting SDMMC_CTRL_RESET causes the CIU to reset
> and disable the clock.  We need to send SDMMC_CMD_UPD_CLK after doing
> this in order to avoid the MMC host hanging.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b44306b886cb..e7504dabcfb6 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3311,6 +3311,7 @@ int dw_mci_runtime_resume(struct device *dev)
>  {
>  	int i, ret = 0;
>  	struct dw_mci *host = dev_get_drvdata(dev);
> +	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
>  
>  	if (host->cur_slot &&
>  	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
> @@ -3357,6 +3358,9 @@ int dw_mci_runtime_resume(struct device *dev)
>  		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>  			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
>  			dw_mci_setup_bus(slot, true);
> +		} else {
> +			/* restore CIU */
> +			mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>  		}
>  	}
>  
> 

