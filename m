From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/9] Init runtime PM support for dw_mmc
Date: Tue, 18 Oct 2016 13:15:22 +0200
Message-ID: <CAPDyKFrHpfhJjHYEPvTDHBUV--MABiTqO1PjzC4_635V7zC+kQ@mail.gmail.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20161018085101epcas1p323c180baf3a9c34b97bc9fb4a9581c46@epcas1p3.samsung.com>
 <CAPDyKFopNgWh=+0RNFwJc+aaFPXGuJMAac5rPtfOawvLwSbN+g@mail.gmail.com>
 <17f821c0-46d3-76e7-06dd-fbb415de37eb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <17f821c0-46d3-76e7-06dd-fbb415de37eb-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>
>> Now, what also do puzzles me, is exactly that piece of code in
>> dw_mci_resume() that is being executed *when* the pm_flag contains
>> MMC_PM_KEEP_POWER:
>> if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>>      dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
>>      dw_mci_setup_bus(slot, true);
>> }
>
> There is no place to set this in dw_mmc controller..Maybe it should be located in other vendor driver.
> Almost all cards that used SDIO might be WiFi..Of course..there might be other cards.
> e.g) In exnyos, use the sdio as WiFi card(broadcom chipset) then broadcom driver also used..
> When broadcom driver initialized or suspending time, it should be set to this flag..
> As i mentioned..it's not normal case.
>
>>
>> So, in the system resume path, the above do makes sense as you need to
>> restore the registers etc for the dw_mmc controller to enable it to
>> operate the SDIO card. Such as bus width, clocks, etc.
>>
>> Although, I would expect something similar would be needed in the new
>> runtime resume path as well. And in particular also for eMMC/SD cards,
>> as you need to restore the dw_mmc registers to be able to operate the
>> card again. Don't you?
>
> Need to check :)
>
>>
>> So in the end, perhaps you should *always* call dw_mci_set_ios() and
>> dw_mci_setup_bus() in dw_mci_resume() instead of conditionally check
>> for MMC_PM_KEEP_POWER? Or maybe only a subset of those functions?
>
> It's reasonable..but it also needs to check on real case and stress test.

Yes, and we can try out that later on top of this series.

Anyway, I wanted to highlight my concern, as I think it's only a
matter of time before we needed this on for runtime PM for some SoCs
that uses dw_mmc.

Kind regards
Uffe
