From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/2=5d_mmc=3a_dw=5fmmc-rockchip=3a_fix_tra?=
 =?UTF-8?B?bnNmZXIgaGFuZ3Mgb24gcmszMTg444CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGlu?=
 =?UTF-8?B?dXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
Date: Thu, 21 Mar 2019 10:31:29 +0800
Message-ID: <8293b346-15a0-a70d-1bfd-c9b2251c729c@rock-chips.com>
References: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
 <1553104085-32312-3-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553104085-32312-3-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Kochetkov <al.kochet@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: shawn.lin@rock-chips.com, wxt@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

+ Caesar Wang

On 2019/3/21 1:48, Alexander Kochetkov wrote:
> I've found that sometimes dw_mmc in my rk3188 based board stop transfer
> any data with error:
> 
> kernel: dwmmc_rockchip 1021c000.dwmmc: Unexpected command timeout, state 3
> 
> Further digging into problem showed that sometimes one of EDMA-based
> transfers hangs and abort with HTO error. I've made test, that 100%

I'm not sure what 100% means, but Caesar fired QA test for RK3036 with
EDMA-based dwmmc in vendor 4.4 kernel, and seems not big deal. The
vendor 4.4 kernel didn't patch anything else wrt EDMA code, but we did
enhance PL330 code and fix some bug there, so you may have a try.

> reproduce the error. I found, that setting max_segs parameter to 1 fix
> the problem.
> 
> I guess the problem is hardware related and relates to DMA controller
> implementation for rk3188. Probably it can relates to missed FLUSHP,
> see commit 271e1b86e691 ("dmaengine: pl330: add quirk for broken no
> flushp"). It is possible that pl330 and dw_mmc become out of sync then
> pl330 driver switch from one scatterlist to another. If we limit
> scatterlist size to 1, we can avoid switching scatterlists and avoid
> hardware problem. Setting max_segs to 1 tells mmc core to use maximum
> one scatterlist for one transfer.
> 
> I guess that all other rk3xxx chips that lacks FLUSHP also affected by
> the problem. So I made fix for all rk3xxx chips from rk2928 to rk3188.

Hard to find these acient platforms to test, expecially some was EOL....

> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc-rockchip.c |   19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 8c86a80..2eed922 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -292,6 +292,24 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>   	return 0;
>   }
>   
> +static void dw_mci_rk2928_init_slot(struct dw_mci *host)
> +{
> +	struct mmc_host *mmc = host->slot->mmc;
> +
> +	if (host->use_dma == TRANS_MODE_EDMAC) {
> +		/*
> +		 * Using max_segs > 1 leads to rare EDMA transfer hangs
> +		 * resulting in HTO errors.
> +		 */
> +		mmc->max_segs = 1;
> +		mmc->max_blk_size = 65535;
> +		mmc->max_blk_count = 64 * 512;
> +		mmc->max_req_size =
> +				mmc->max_blk_size * mmc->max_blk_count;
> +		mmc->max_seg_size = mmc->max_req_size;
> +	}
> +}
> +
>   static int dw_mci_rockchip_init(struct dw_mci *host)
>   {
>   	/* It is slot 8 on Rockchip SoCs */
> @@ -314,6 +332,7 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>   
>   static const struct dw_mci_drv_data rk2928_drv_data = {
>   	.init			= dw_mci_rockchip_init,
> +	.init_slot		= dw_mci_rk2928_init_slot,
>   };
>   
>   static const struct dw_mci_drv_data rk3288_drv_data = {
> 
