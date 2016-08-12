From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 0/2] mmc: dw_mmc: host controller reset support
Date: Fri, 12 Aug 2016 18:19:39 +0900
Message-ID: <724bc267-1f6b-0211-4645-10cc49eedd48@samsung.com>
References: <CGME20160812085218epcas1p34d84a42a931dcc09fe7a77be59065499@epcas1p3.samsung.com>
 <1470991886-22412-1-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1470991886-22412-1-git-send-email-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Guodong,

On 08/12/2016 05:51 PM, Guodong Xu wrote:
> mmc host controller registers may in abnormal state if mmc is used in
> bootloader, eg. to load kernel from eMMC. Some controllers cann't
> clear their registers when clk is set. They use dedicated reset
> logics to do this.
> 
> In this patch, a 'resets' property is added into dw_mmc dts
> node. When driver does parse_dt and probe, it calls reset API to
> triiger 'reset' of dwmmc host controller. When probe error or
> remove, it calls reset API to assert it.
> 
> Chip vendor's actual reset logics is implemented in reset driver, not
> in dw_mmc code.
> 
> Please also refer to Documentation/devicetree/bindings/reset/reset.txt
> 
> Changelog:
> v5:
>  * rebase onto https://github.com/jh80chung/dw-mmc
> v4:
>  * add reset_control_assert() and usleep() before calling _deassert().
> 
> Guodong Xu (2):
>   Documentation: synopsys-dw-mshc: add binding for resets
>   mmc: dw_mmc: add reset support to dwmmc host controller

Applied on my dw-mmc tree. Thanks!

Best Regards,
Jaehoon Chung

> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  4 ++++
>  drivers/mmc/host/dw_mmc.c                          | 23 +++++++++++++++++++++-
>  include/linux/mmc/dw_mmc.h                         |  2 ++
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
