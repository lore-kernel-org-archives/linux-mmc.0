From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: Test bus-width for old MMC devices (v2)
Date: Tue, 21 Dec 2010 22:56:32 -0500
Message-ID: <AANLkTim6pQW0sDtZRNbXbgbvzuXKCdsju7z_ADBxvXPd@mail.gmail.com>
References: <s5hfwtzbj8v.wl%tiwai@suse.de>
	<20101216234032.GA17239@void.printf.net>
	<50D31EC8-BD9E-4920-8CEB-2AD10DF9C5C5@marvell.com>
	<20101217034342.GA19673@void.printf.net>
	<s5hy67o95to.wl%tiwai@suse.de>
	<AANLkTimSt5a998m1oqdppsWjGCVid0-Ub81pKgsPR36f@mail.gmail.com>
	<E81C83FE-E3AD-49DA-86BE-95631F1B81CD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:48223 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab0LVD4e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2010 22:56:34 -0500
In-Reply-To: <E81C83FE-E3AD-49DA-86BE-95631F1B81CD@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Takashi Iwai <tiwai@suse.de>, Chris Ball <cjb@laptop.org>, Aries Lee <arieslee@jmicron.com>, Qiming Wu <wuqm@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Dec 21, 2010 at 11:36 AM, Philip Rakity <prakity@marvell.com> w=
rote:
>
>
> Can you please try this diff and see if it works for you.
>
> Will do formal patch after your testing. =A0What card is failing ?
>
> Please let me know the manufacturing information so can add card to m=
y test suite.
>
> Philip
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1d8409f..77072c8 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -558,6 +558,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd_bits[idx][0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set=
_bus_width_ddr(card->host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width, MMC_SDR_MODE);
Test OK,
Curious why move here, then mmc_set_bus_width_ddr is called twice in
fact when ddr=3D0 &&  (!(host->caps & MMC_CAP_BUS_WIDTH_TEST)), though
not impact function.
mmc_set_bus_width is mmc_set_bus_width_ddr(host, width, MMC_SDR_MODE).

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If =
controller can't handle bus width test,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * use=
 the highest bus width to maintain
> @@ -565,8 +567,6 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(=
host->caps & MMC_CAP_BUS_WIDTH_TEST))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set=
_bus_width_ddr(card->host,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width, MMC_SDR_MODE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D=
 mmc_bus_test(card, bus_width);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!e=
rr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0break;
> @@ -586,7 +586,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (ddr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_set_ddr_mode(=
card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_set_bus_width_ddr(=
card->host, bus_width, ddr);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width (card=
->host, bus_width);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!oldcard)
>
>
> Philip
>
> On Dec 21, 2010, at 2:59 AM, zhangfei gao wrote:
>
>> On Fri, Dec 17, 2010 at 3:11 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>> At Fri, 17 Dec 2010 03:43:42 +0000,
>>> Chris Ball wrote:
>>>>
>>>> Hi Philip,
>>>>
>>>> On Thu, Dec 16, 2010 at 06:33:49PM -0800, Philip Rakity wrote:
>>>>> It is not possible for bus_width to be not initialized. =A0This w=
ould imply ARRAY_SIZE(bus_widths) is 1. =A0Certainly not true.
>>>>
>>>> Right, I agree. =A0We should fix the warning anyway.
>>>
>>> Well, this is always a gray-zone question. =A0One prefers fixing it
>>> either via uninitialized_var() or by setting a bogus value. =A0But,=
 this
>>> would cover any possible real bug in future. =A0Thus another prefer=
s
>>> ignoring it, because it's just a compiler bug (mostly of old gcc).
>>>
>>> After all, it's up to maintainer, so take as you like :)
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>
>>>>> We could just initialize by changing
>>>>> + =A0 =A0 =A0 =A0 =A0 unsigned idx, bus_width;
>>>>> to
>>>>> + =A0 =A0 =A0 =A0 =A0 unsigned idx, bus_width =3D 0;
>>>>
>>>> Okay, I've pushed to mmc-next with that change.
>>>>
>>>>> I wonder what compiler are you using so we can avoid this issue i=
n future.
>>>>
>>>> Ah, good point -- I was building with a gcc 4.1.2 ARM cross-compil=
er,
>>>> and using a gcc 4.5.1 cross-build instead avoids the warning.
>>>>
>>>> Thanks,
>>>>
>>>> --
>>>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>>>> One Laptop Per Child
>>>>
>>>
>>
>> Could you help adding this modification?
>> We found error happen since bus_width is not set at these condition:
>> 1. ddr=3D0
>> 2. not set MMC_CAP_BUS_WIDTH_TEST
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 1d8409f..86cac0d 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -586,7 +586,11 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ddr) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_ddr_mode(ca=
rd);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width_ddr(ca=
rd->host, bus_width, ddr);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->ho=
st,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bus_widths[idx]);
>> +
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (!oldcard)
>
>
