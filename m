From: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Wed, 30 Mar 2016 09:18:46 +0800
Message-ID: <56FB2976.60205@linaro.org>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org> <1457254062-22677-2-git-send-email-guodong.xu@linaro.org> <56DC3BAD.8020107@rock-chips.com> <CAFGCpxz3GfFeduaz1Dkg0WvRJWs+GHdVu8uY0-wV=RGyRfBE=A@mail.gmail.com> <56F9E6E5.9000100@kernel-upstream.org> <56FA3B70.2090902@linaro.org> <56FB21E8.30008@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FB21E8.30008-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, =?UTF-8?B?UGF3ZcWCIE1vbGw=?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org



On 03/30/2016 08:46 AM, Shawn Lin wrote:
> =E5=9C=A8 2016/3/29 16:23, zhangfei =E5=86=99=E9=81=93:

>>> More to think, Is it ok to match the behaviour of bootloader stage?
>>> My bootloader doesn't assert the reset pin of dw_mmc, so it seams i=
f
>>> I want to fix you issue on kernel stage, I need a new round of
>>> assert->delay->deassert.
>>
>> The process like delay (if required) should be abstracted in reset
>> driver.
>> reset framework just export reset_control_assert/reset_control_deass=
ert
>> API.
>> Unfortunately not find clear description in Documentation/.
>> Suppose deassert is like start, while assert is like stop.
>>
>
> yes, no docs except dt-bindings..... So seems the usage of these two
> APIs depends on the implementation of reset controller driver
>
>> drivers/reset/core.c
>> reset_control_deassert - deasserts the reset line
>> reset_control_assert - asserts the reset line
>>
>> More example:
>> drivers/mmc/host/sdhci-st.c
>> drivers/mmc/host/sunxi-mmc.c
>> drivers/usb/host/ohci-platform.c
>> drivers/i2c/busses/i2c-mv64xxx.c
>
> But I'm afraid I have to nack here....
>
> Looking at these files:
> drivers/dma/stm32-dma.c
> drivers/net/ethernet/mediatek/mtk_eth_soc.c
> drivers/devfreq/tegra-devfreq.c
> drivers/crypto/rockchip/rk3288_crypto.c
> drivers/thermal/rockchip_thermal.c
> drivers/thermal/tegra_soctherm.c
> drivers/i2c/busses/i2c-tegra.c
> ....
>
> they just do the way like: assert->[delay](maybe abstracted)->deasser=
t
> I think these drivers are vendor specific, so they can do
> the reset operations in consistent with the implementation of
> their platforms' reset controller drivers.

Yes, have checked drivers/i2c/busses/i2c-tegra.c
         reset_control_assert(i2c_dev->rst);
         udelay(2);
         reset_control_deassert(i2c_dev->rst);

This usage looks strange, reset does not mean gpio reset, it maybe=20
register accessing.
I think all these three operation should be abstracted to deassert=20
function, while cover the details for sharing.

However, not doc describing the assert/deassert behavior so causing=20
confusion.

>
> But, dw_mmc is shared by many Socs. So It's not good to do it in
> dw_mci_probe, otherwise you force my reset controller driver to be
> implemented in the same way as yours..... Right?
>
> How about move it to your drv_data->init callback?
Yes, we can.
But firstly we should consider put in common file for sharing, otherwis=
e=20
there maybe many assert/deassert in dw_mmc-xx.c.

Guodong may send another version and wait for Jaehoon's decision.

Thanks
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
