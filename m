From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RESEND PATCH 0/9] Init runtime PM support for dw_mmc
Date: Mon, 10 Oct 2016 11:10:35 +0900
Message-ID: <9c4dd4aa-af9f-1765-fae6-f279ca45e60e@samsung.com>
References: <CGME20161009135255epcas1p4d5a9db74bb1dea56f61fcb2a720a07f0@epcas1p4.samsung.com>
 <1476021506-869-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39666 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbcJJCLT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Oct 2016 22:11:19 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OET022C57DOMHB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 10 Oct 2016 11:10:36 +0900 (KST)
In-reply-to: <1476021506-869-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 10/09/2016 10:58 PM, Shawn Lin wrote:
> Hi Jaehoon and Ulf,
> 
>    This patch is gonna support runtime PM for dw_mmc.
> It could support to disable ciu_clk by default and disable
> biu_clk if the devices are non-removeable, or removeable
> with gpio-base card detect.
> 
>    Then I remove the system PM since the runtime PM actually
> does the same thing as it. So I help migrate the dw_mmc variant
> drivers to use runtime PM pairs and pm_runtime_force_*. Note
> that I only enable runtime PM for dw_mmc-rockchip as I will
> leave the decision to the owners of the corresponding drivers.
> I just tested it on my RK3288 platform with linux-next to make
> the runtime PM and system PM work fine for my emmc, sd card and
> sdio. But I don't have hardware to help test other variant drivers.
> But in theory it should work fine as I mentioned that the runtime
> PM does the same thing as system PM except for disabling ciu_clk
> aggressively which should not be related to the variant hosts.

I'm testing this patchset with exynos SoCs. If it's possible to use other SoCs,
then I think your patches will be changed more clear than now.
e.g) Not need to define the each driver's runtime_pm_suspend/resume function.

> 
>    As you could see that I just extend the slot-gpio a bit, so the
> ideal way is Ulf could pick them up with Jaehoon's ack. :)
> 
> 
> 
> Shawn Lin (9):
>   mmc: dw_mmc: add runtime PM callback
>   mmc: dw_mmc-rockchip: add runtime PM support
>   mmc: core: expose the capability of gpio card detect
>   mmc: dw_mmc-rockchip: disable biu clk if possible
>   mmc: dw_mmc-k3: deploay runtime PM facilities
>   mmc: dw_mmc-exynos: deploay runtime PM facilities
>   mmc: dw_mmc-pci: deploay runtime PM facilities
>   mmc: dw_mmc-pltfm: deploay runtime PM facilities

Maybe s/deploay/deploy

Best Regards,
Jaehoon Chung

>   mmc: dw_mmc: remove system PM callback
> 
>  drivers/mmc/core/slot-gpio.c       |  8 +++++
>  drivers/mmc/host/dw_mmc-exynos.c   | 21 ++++++-----
>  drivers/mmc/host/dw_mmc-k3.c       | 37 +++++++++----------
>  drivers/mmc/host/dw_mmc-pci.c      | 25 ++++++++-----
>  drivers/mmc/host/dw_mmc-pltfm.c    | 26 ++++++++------
>  drivers/mmc/host/dw_mmc-rockchip.c | 73 ++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/host/dw_mmc.c          | 24 ++++++-------
>  drivers/mmc/host/dw_mmc.h          |  6 ++--
>  include/linux/mmc/slot-gpio.h      |  1 +
>  9 files changed, 152 insertions(+), 69 deletions(-)
> 

