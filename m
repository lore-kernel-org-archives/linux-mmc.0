From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Wed, 30 Mar 2016 08:46:32 +0800
Message-ID: <56FB21E8.30008@rock-chips.com>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
 <1457254062-22677-2-git-send-email-guodong.xu@linaro.org>
 <56DC3BAD.8020107@rock-chips.com>
 <CAFGCpxz3GfFeduaz1Dkg0WvRJWs+GHdVu8uY0-wV=RGyRfBE=A@mail.gmail.com>
 <56F9E6E5.9000100@kernel-upstream.org> <56FA3B70.2090902@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FA3B70.2090902@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>, Guodong Xu <guodong.xu@linaro.org>
Cc: shawn.lin@rock-chips.com, robh+dt@kernel.org, =?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, Kumar Gala <galak@codeaurora.org>, jh80.chung@samsung.com, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2016/3/29 16:23, zhangfei =E5=86=99=E9=81=93:
>
>
> On 03/29/2016 10:22 AM, Shawn Lin wrote:
>
>>>
>>>
>>>
>>>         +               else if (IS_ERR(host->pdata)) {
>>>                                  dev_err(host->dev, "platform data =
not
>>>         available\n");
>>>                                  return -EINVAL;
>>>                          }
>>>         @@ -3012,6 +3022,9 @@ int dw_mci_probe(struct dw_mci *host)
>>>                          }
>>>                  }
>>>
>>>         +       if (host->pdata->rstc !=3D NULL)
>>>         +               reset_control_deassert(host->pdata->rstc);
>>>         +
>>>
>>>
>>>     sorry, I can't follow your intention here. Shouldn't it be some=
thing
>>>     like "assert mmc -> may need delay -> deassert mmc". As your cu=
rrent
>>>     code, nothing happend right?
> Should be abstracted in reset driver.
>
>>>
>>>
>>> The chip exits from bootloader with this bit asserted. And when ent=
ering
>>> kernel, we only need to deassert.
>>>
>>> In my current code, the driver deassert mmc in _probe(), and assert=
 mmc
>>> in _remove().
>>
>> I catch your point. From the previous discussion, we add it to make =
sure
>> dw_mmc in good state after leaving bootloader to kernel. But My real
>> question is that you can assert it in  bootloader, so you can also
>> dessert it in bootloaer to make sure dw_mmc work fine when probing
>> in kernel. In that way, we don't need this patch?
>
> uefi does not have exit point, and kernel may not assume mmc controll=
er
> state is always correct when boot.
> If Uefi need copy Image from mmc, mmc controller is in working state.
> When jump to kernel, uefi mmc driver can not recover itself.
> If kernel assume mmc controller state is clean, mmc will be in abnorm=
al
> state.
> Some controller will clear itself when set clock, however, hip660 doe=
s
> not, it need special register to access.
>

yep, I understand your requirement.

>
>>
>> More to think, Is it ok to match the behaviour of bootloader stage?
>> My bootloader doesn't assert the reset pin of dw_mmc, so it seams if
>> I want to fix you issue on kernel stage, I need a new round of
>> assert->delay->deassert.
>
> The process like delay (if required) should be abstracted in reset dr=
iver.
> reset framework just export reset_control_assert/reset_control_deasse=
rt
> API.
> Unfortunately not find clear description in Documentation/.
> Suppose deassert is like start, while assert is like stop.
>

yes, no docs except dt-bindings..... So seems the usage of these two
APIs depends on the implementation of reset controller driver

> drivers/reset/core.c
> reset_control_deassert - deasserts the reset line
> reset_control_assert - asserts the reset line
>
> More example:
> drivers/mmc/host/sdhci-st.c
> drivers/mmc/host/sunxi-mmc.c
> drivers/usb/host/ohci-platform.c
> drivers/i2c/busses/i2c-mv64xxx.c

But I'm afraid I have to nack here....

Looking at these files:
drivers/dma/stm32-dma.c
drivers/net/ethernet/mediatek/mtk_eth_soc.c
drivers/devfreq/tegra-devfreq.c
drivers/crypto/rockchip/rk3288_crypto.c
drivers/thermal/rockchip_thermal.c
drivers/thermal/tegra_soctherm.c
drivers/i2c/busses/i2c-tegra.c
=2E...

they just do the way like: assert->[delay](maybe abstracted)->deassert
I think these drivers are vendor specific, so they can do
the reset operations in consistent with the implementation of
their platforms' reset controller drivers.

But, dw_mmc is shared by many Socs. So It's not good to do it in
dw_mci_probe, otherwise you force my reset controller driver to be
implemented in the same way as yours..... Right?

How about move it to your drv_data->init callback?


>
> Thanks
>
>
>
>


--=20
Best Regards
Shawn Lin
