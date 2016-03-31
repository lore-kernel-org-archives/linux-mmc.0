From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/4] Cleanup setup_clock callback from dw_mmc
Date: Thu, 31 Mar 2016 15:37:07 +0900
Message-ID: <56FCC593.9020007@samsung.com>
References: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,


On 01/28/2016 10:30 AM, Shawn Lin wrote:
> Hello Jeahoon
> 
> Currently dw_mmc is a little too queen-size. As we had cleanup
> prepare_command callback some days before, there are also some
> ones deserve to remove. Also we should avoid add new quirks or
> callbacks into dw_mmc in order to avoid the dilemma sdhci meets
> now.
> 
> This patchset remove setup_clock callback. Obviously, adding a
> callback just for one-time-used clk stuff makes no sense. We combine
> what setup_clock does before into init callback. For exynos platfrom,
> it needs call init hook after resume, so we add new argument in init
> hook to indicate whether it needs do clk stuff or not.
> 

I sent the patch "mmc: dw_mmc: exynos: add the function for controlling SMU"
https://patchwork.kernel.org/patch/8707591/

Then it doesn't need this patch for adding setup_clk argument.
"mmc: dw_mmc: add setup_clk for init hook"

Could you resend the patch-set after applying my patch?

Best Regards,
Jaehoon Chung

> 
> 
> Shawn Lin (4):
>   mmc: dw_mmc-rockchip: remove setup_clock for rockchip
>   mmc: dw_mmc: add setup_clk for init hook
>   mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
>   mmc: dw_mmc: remove setup_clock callback
> 
>  drivers/mmc/host/dw_mmc-exynos.c   | 15 ++++-----------
>  drivers/mmc/host/dw_mmc-rockchip.c | 14 +++++---------
>  drivers/mmc/host/dw_mmc.c          | 11 +----------
>  drivers/mmc/host/dw_mmc.h          |  3 +--
>  4 files changed, 11 insertions(+), 32 deletions(-)
> 
