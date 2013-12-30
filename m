From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Tue, 31 Dec 2013 01:19:48 +0800
Message-ID: <52C1AB34.3010402@linaro.org>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org>	<1388241295-20051-3-git-send-email-zhangfei.gao@linaro.org>	<201312292205.02135.arnd@arndb.de>	<52C0B662.4070608@samsung.com> <CAMj5Bkif9pQHVdA71QccamVQkfgTheUNzowW6AyTwC3dy5XF+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62763 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288Ab3L3RT4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2013 12:19:56 -0500
Received: by mail-pa0-f45.google.com with SMTP id fb1so11829678pad.4
        for <linux-mmc@vger.kernel.org>; Mon, 30 Dec 2013 09:19:56 -0800 (PST)
In-Reply-To: <CAMj5Bkif9pQHVdA71QccamVQkfgTheUNzowW6AyTwC3dy5XF+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, cpgs@samsung.com, Kumar Gala <galak@codeaurora.org>, Chris Ball <cjb@laptop.org>, Zhigang Wang <brooke.wangzhigang@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>



On 12/30/2013 10:32 AM, Zhangfei Gao wrote:
> On Mon, Dec 30, 2013 at 7:55 AM, Jaehoon Chung <jh80.chung@samsung.co=
m> wrote:
>> On 12/30/2013 06:05 AM, Arnd Bergmann wrote:
>>> On Saturday 28 December 2013, Zhangfei Gao wrote:
>>>> Add dw_mmc-k3.c for k3v2, support sd/emmc
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>> Signed-off-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
>>>> ---
>>>>   .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   60 ++++++=
++++
>>>>   drivers/mmc/host/Kconfig                           |   10 ++
>>>>   drivers/mmc/host/Makefile                          |    1 +
>>>>   drivers/mmc/host/dw_mmc-k3.c                       |  126 ++++++=
++++++++++++++
>>>>   4 files changed, 197 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-m=
shc.txt
>>>>   create mode 100644 drivers/mmc/host/dw_mmc-k3.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt =
b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>>> new file mode 100644
>>>> index 000000000000..d7e2d7f159bb
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>>>> @@ -0,0 +1,60 @@
>>>> +* Hisilicon specific extensions to the Synopsys Designware Mobile
>>>> +  Storage Host Controller
>>>> +
>>>> +Read synopsys-dw-mshc.txt for more details
>>>> +
>>>> +The Synopsys designware mobile storage host controller is used to=
 interface
>>>> +a SoC with storage medium such as eMMC or SD/MMC cards. This file=
 documents
>>>> +differences between the core Synopsys dw mshc controller properti=
es described
>>>> +by synopsys-dw-mshc.txt and the properties used by the Hisilicon =
specific
>>>> +extensions to the Synopsys Designware Mobile Storage Host Control=
ler.
>>>> +
>>>> +Required Properties:
>>>> +
>>>> +* compatible: should be one of the following.
>>>> +  - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 speci=
fic extentions.
>>>
>>> I wonder if this is actually a different variant of the mshc hardwa=
re, or just
>>> wired up in a different way. Do you know details?
>>>
>>> Since the only difference in the binding is the presence of the "cl=
ock-freq-table"
>>> property, we could also make this property generic for the mshc dri=
ver and use
>>> it if present but fall back to the normal behavior when it is absen=
t.
>
> There are still other differences and limitations besides "clock-freq=
-table".
> The controller seems less intelligent than other Synopsys mmc control=
ler.
> The tuning process like HS200 is not intelligent, as a result, some
> local registers are added to help this.
>
>>>
>>>> +* clock-freq-table: should be the frequency (in Hz) array of the =
ciu clock
>>>> +    in each supported mode.
>>>> +    0. CIU clock rate in Hz for DS mode
>>>> +    1. CIU clock rate in Hz for MMC HS mode
>>>> +    2. CIU clock rate in Hz for SD HS mode
>>>> +    3. CIU clock rate in Hz for SDR12 mode
>>>> +    4. CIU clock rate in Hz for SDR25 mode
>>>> +    5. CIU clock rate in Hz for SDR50 mode
>>>> +    6. CIU clock rate in Hz for SDR104 mode
>>>> +    7. CIU clock rate in Hz for DDR50 mode
>>>> +    8. CIU clock rate in Hz for HS200 mode
>>>
>>> This looks god now.
>>>
>>>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios=
 *ios)
>>>> +{
>>>> +    struct dw_mci_k3_priv_data *priv =3D host->priv;
>>>> +    u32 rate =3D priv->clk_table[ios->timing];
>>>> +    int ret;
>>>
>>> I think this should have some range checking to see if the mode tha=
t is
>>> being set had a clock frequency set in the DT.
>
> The range safety should be ensured by the clk_table array, MAX_NUMS=3D=
10.
>>>
>>>> +
>>>> +    ret =3D clk_set_rate(host->ciu_clk, rate);
>>>> +    if (ret)
>>>> +            dev_warn(host->dev, "failed to set clock rate %uHz\n"=
, rate);
>>>> +
>>>> +    host->bus_hz =3D clk_get_rate(host->ciu_clk);
>>>> +}
>>>
>>> Why do you call clk_get_rate() here, shouldn't it always be the sam=
e
>>> rate that you have just set?
>
> It is more accurate to use clk_get_rate here.
> For example, if switch to ios->clock as you suggested before, 52M wil=
l
> be set for mmc, while 50M is supported.
> However, it can simply use rate set currently.
>
>>>
>>>> +static int dw_mci_k3_parse_dt(struct dw_mci *host)
>>>> +{
>>>> +    struct dw_mci_k3_priv_data *priv;
>>>> +    struct device_node *node =3D host->dev->of_node;
>>>> +    struct property *prop;
>>>> +    const __be32 *cur;
>>>> +    u32 val, num =3D 0;
>>>> +
>>>> +    priv =3D devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>>>> +    if (!priv) {
>>>> +            dev_err(host->dev, "mem alloc failed for private data=
\n");
>>>> +            return -ENOMEM;
>>>> +    }
>>>> +    host->priv =3D priv;
>>>> +
>>>> +    of_property_for_each_u32(node, "clock-freq-table", prop, cur,=
 val) {
>>>> +            if (num >=3D MAX_NUMS)
>>>> +                    break;
>>>> +            priv->clk_table[num++] =3D val;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>
>>> If we make this property part of the generic binding, this function=
 could
>>> also get moved to the main dw_mci driver.
>
> This may be not general.
> The controller does not generate the clock itself, and set rate to th=
e
> outside clock source, which may be different according to the working
> mode.
>
>>>
>>>> +static int dw_mci_k3_suspend(struct device *dev)
>>>> +{
>>>> +    struct dw_mci *host =3D dev_get_drvdata(dev);
>>>> +    int ret =3D 0;
>>>> +
>>>> +    ret =3D dw_mci_suspend(host);
>>>
>>> You should never initialize local variables when they are set later=
 in the
>>> function (the ret =3D 0 part above). For more complex functions, th=
is prevents
>>> gcc from warning you about accidentally uninitialized uses.

I am sorry I may fall into the dead end, but still quite not understand=
=20
this rule.
I alwayes thought it would be a good habit to init local variables befo=
re.
Do you mean it should NOT init local variable as much as possible and=20
only init on demand, like solving the gcc warning.
Why not init the them at start in case random value cause unpredicted e=
rror?

>
> Frankly speaking, I didn't know this rule at all.
> Often see the warning before like =93Variable to be used not initiali=
zed=94,
> so preferred to init the local variable as much as possible.
> Looks like it is wrong.
>
>>>
>>>> +    if (!ret)
>>>> +            clk_disable_unprepare(host->ciu_clk);
>>>> +
>>>> +    return ret;
>>>> +}
>>>
>>> The suspend/resume code also looks very generic. Can't we make thes=
e the
>>> default for dw-mci? If you do both, you won't even need a k3 specif=
ic driver.
>>> I think in general we should try hard to add code like this to the =
common
>>> driver when there is a chance that it can be shared with other plat=
forms.
>>
>> Dw-mmc has the LOW_POWER mode feature at CLKENA register,
>> this feature is running like clock-gating.
>> So i have known it didn't control clock enable/disable in dw-mmc.c.
>
> It is added here since we have to set special register when resume
> back, which has been abstracted to ciu_clk prepare operation.
>
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>>        Arnd
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
