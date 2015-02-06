From: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/2] mmc: dw_mmc: exynos: Add HS400 support
Date: Fri, 6 Feb 2015 11:22:34 +0530
Message-ID: <CAFp+6iEGCEiGf5WooHJyh=cnJF_c7j=n_YhHLowfwjpLiXUPiQ@mail.gmail.com>
References: <1422499318-13726-1-git-send-email-alim.akhtar@samsung.com>
	<54D41654.8030702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54D41654.8030702-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Alim Akhtar <alim.akhtar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,


On Fri, Feb 6, 2015 at 6:48 AM, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi, Alim.
>
> On my board, this patch isn't working fine.
> So when i complete to test on my board(exynos5), i will reply with comments.
> Sorry for late testing.

I tested this series on linux-next, on Exynos5800-peach-pi board, and HS400
seems to be working fine.
I can see the card getting detected as HS400, and then i ran iozone as well.
The iozone numbers are also as required.

On peach-pit board too, the HS200 mode seems to be working good.

What are the observations you saw on your board ?

>
> Best Regards,
> Jaehoon Chung
>
> On 01/29/2015 11:41 AM, Alim Akhtar wrote:
>> This adds HS400 mode support for exynos dw_mmc host controller.
>>
>> Currently tested on Exynos5800-peach-pi and Exyons7 platform for HS400 mode.
>> Tested HS200 mode with this series applied, HS200 still works.
>>
>> Appreciate testing on other exynos5/7 platform which supports emmc5.0
>>
>> Changes in V5:
>>       * Enable HS400 on Exynos5800-peach-pi boards
>>       * Addressed other review comments from Jaehoon Chung
>>
>> Changes in V4:
>>       * drop the idea of changing existing binding for ciu_div as per [1]
>>         * addressed comments from Jaehoon Chung [2]
>>
>> [1] http://www.spinics.net/lists/linux-samsung-soc/msg40923.html
>> [2] http://www.spinics.net/lists/devicetree/msg64373.html
>>
>> Changes in V3:
>>       rebased on ulf's next (commit: 607b448 mmc: core: Make tuning block patterns static)
>>
>> Seungwon Jeon (2):
>>   mmc: dw_mmc: exynos: Support eMMC's HS400 mode
>>   ARM: dts: Add HS400 support for exynos5420 and exynos5800
>>
>>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    7 +
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |    4 +-
>>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +
>>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 +-
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |    7 +-
>>  drivers/mmc/host/dw_mmc-exynos.c                   |  185 ++++++++++++++++----
>>  drivers/mmc/host/dw_mmc-exynos.h                   |   19 +-
>>  drivers/mmc/host/dw_mmc.c                          |   16 +-
>>  drivers/mmc/host/dw_mmc.h                          |    2 +
>>  9 files changed, 213 insertions(+), 38 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
