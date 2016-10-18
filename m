From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Check regulator pointer
Date: Tue, 18 Oct 2016 12:28:36 +0200
Message-ID: <CAPDyKFov8_xoyLPYhq+YqKSt+b=TozL3mM2rTZacNLieQKD+LQ@mail.gmail.com>
References: <20161018084343.680-1-maxime.ripard@free-electrons.com>
 <CAPDyKFquN_f1ZKW3G6ZsTnnGJa-7N4R4-RpF=E4PN+7OTrxhZg@mail.gmail.com> <20161018094704.ohubpg4j3jhc7cay@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35844 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757953AbcJRK2i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 06:28:38 -0400
Received: by mail-qt0-f179.google.com with SMTP id m5so146232346qtb.3
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2016 03:28:38 -0700 (PDT)
In-Reply-To: <20161018094704.ohubpg4j3jhc7cay@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 18 October 2016 at 11:47, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Oct 18, 2016 at 11:03:02AM +0200, Ulf Hansson wrote:
>> On 18 October 2016 at 10:43, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > mmc_regulator_get_supply might silently fail if the regulators are not
>> > found, which is the right thing to do since both these regulators are
>> > optional.
>> >
>> > However, the drivers then have no way to know whether or not they should
>> > proceed and call mmc_regulator_set_ocr. And since this function doesn't
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

Through some other way, which is managed by the internal logic of the
mmc controller.

>
> Also, I'm wondering if VMMC is actually optional at all. In all cases
> I can think of, it would be represented as a regulator anyway.

Yes, you are right. For most cases, but not all.

Kind regards
Uffe
