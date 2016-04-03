From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 0/3] Cleanup setup_clock callback from dw_mmc
Date: Mon, 04 Apr 2016 08:46:48 +0900
Message-ID: <5701AB68.2080208@samsung.com>
References: <1459409616-20306-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1459409616-20306-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Picked this patch-set on my repository.

Best Regards,
Jaehoon Chung

On 03/31/2016 04:33 PM, Shawn Lin wrote:
> Hello Jeahoon
> 
> Currently dw_mmc is a little too queen-size. As we had cleanup
> prepare_command callback some days before, there are also some
> ones deserve to remove. Also we should avoid add new quirks or
> callbacks into dw_mmc in order to avoid the dilemma sdhci meets
> now.
> 
> This patchset remove setup_clock callback. Obviously, add a callback
> just for one-time-used clk stuff make no sense. We combine what
> setup_clock does before into init callback. For exynos platfrom, it
> needs call init hook after resume, so we add new argument in init hook
> to indicate whether it needs do clk stuff or not.
> 
> 
> Changes in v2:
> - rebase on linux-mmc next
> - remove add setup_clk flag for init callback
> 
> Shawn Lin (3):
>   mmc: dw_mmc-rockchip: remove setup_clock for rockchip
>   mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
>   mmc: dw_mmc: remove setup_clock callback
> 
>  drivers/mmc/host/dw_mmc-exynos.c   |  8 --------
>  drivers/mmc/host/dw_mmc-rockchip.c | 12 ++++--------
>  drivers/mmc/host/dw_mmc.c          |  9 ---------
>  drivers/mmc/host/dw_mmc.h          |  2 --
>  4 files changed, 4 insertions(+), 27 deletions(-)
> 
