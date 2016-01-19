From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/3] Convert dw_mci_pltfm_prepare_command into a library
 call
Date: Tue, 19 Jan 2016 13:07:56 +0900
Message-ID: <569DB69C.5060003@samsung.com>
References: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi, Shawn.

On 01/19/2016 12:39 PM, Shawn Lin wrote:
> This patchset expose dw_mci_pltfm_prepare_command towards to
> library call and remove the redundant code from dw_mmc-rockchip.
> Meanwhile we make dw_mmc-exynos to call it instead of changing cmdr
> in its variant drivers.

Thanks for your effort.
Right way. We need to try that remove the hook for operation.
Looks good to me. After check, i will pick these. Also other your patch. :)

Best Regards,
Jaehoon Chung

> 
> 
> 
> Shawn Lin (3):
>   mmc: dw_mmc: expose dw_mci_pltfm_prepare_command
>   mmc: dw_mmc-rockchip: remove prepare_command hook
>   mmc: dw_mmc-exynos: wrapper prepare_command
> 
>  drivers/mmc/host/dw_mmc-exynos.c   | 4 ++--
>  drivers/mmc/host/dw_mmc-pltfm.c    | 3 ++-
>  drivers/mmc/host/dw_mmc-pltfm.h    | 2 +-
>  drivers/mmc/host/dw_mmc-rockchip.c | 9 ++-------
>  4 files changed, 7 insertions(+), 11 deletions(-)
> 
