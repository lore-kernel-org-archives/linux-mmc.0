From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: Check regulator pointer
Date: Tue, 18 Oct 2016 20:29:07 +0800
Message-ID: <c45bc12a-8389-2d7d-ea94-dab243bae428@rock-chips.com>
References: <20161018084343.680-1-maxime.ripard@free-electrons.com>
 <CAPDyKFquN_f1ZKW3G6ZsTnnGJa-7N4R4-RpF=E4PN+7OTrxhZg@mail.gmail.com>
 <20161018094704.ohubpg4j3jhc7cay@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:38800 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754431AbcJRM3U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 08:29:20 -0400
In-Reply-To: <20161018094704.ohubpg4j3jhc7cay@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

在 2016/10/18 17:47, Maxime Ripard 写道:
> Hi,
>
> On Tue, Oct 18, 2016 at 11:03:02AM +0200, Ulf Hansson wrote:
>> On 18 October 2016 at 10:43, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>> mmc_regulator_get_supply might silently fail if the regulators are not
>>> found, which is the right thing to do since both these regulators are
>>> optional.
>>>
>>> However, the drivers then have no way to know whether or not they should
>>> proceed and call mmc_regulator_set_ocr. And since this function doesn't
>>
>> Host drivers should check "if (!IS_ERR(mmc->supply.vmmc))" before
>> invoking mmc_regulator_set_ocr(). I wasn't aware that some didn't.
>
> Ok, so the sunxi one definitely doesn't:
> http://lxr.free-electrons.com/source/drivers/mmc/host/sunxi-mmc.c#L735
>
>> My point is, that in some cases the regulator is optional, then a host
>> driver need to take other actions to power on/off the card.
>
> What are those actions? Just power up the card through some other
> mean, or is it more tied to the MMC protocol?
>
> Also, I'm wondering if VMMC is actually optional at all. In all cases
> I can think of, it would be represented as a regulator anyway.

If I understand your point correctly, for sunxi's mmc controller, the
only way to power-on/off the vmmc is to call  mmc_regulator_set_ocr?

There are some cases for mmc-core/host to control the power:
1) assign a vmmc-supply for no matter of gpio-based regulator or PMIC
2) use mmc_pwrseq which is often used by sdio fucntion or emmc.
3) use a functional port to control it which is similar to gpio-based
regulator but the host drivers could control this via internal register,
for instance, dw_mmc..

4) And I even see some boards use fixed power which means we cannot
power off vmmc from the hardware part. And also, if I decide to add
alwyas-on and boot-on for the vmmc regulator I was using, and also
there is  no really need for mmc-core/driver to know whether we have
vmmc, right!?



>
> Thanks,
> Maxime
>


-- 
Best Regards
Shawn Lin

