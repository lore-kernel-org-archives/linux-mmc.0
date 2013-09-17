From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/7] mmc: core: Fixup ocr mask setup to prevent spec violation
Date: Tue, 17 Sep 2013 10:00:11 +0200
Message-ID: <CAPDyKFrvPkwAVfi8gv0hG3DKeiJm+_AqODhERX=O0ZxB-gcHiw@mail.gmail.com>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.64.1309162253320.17217@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:42331 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab3IQIAM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 04:00:12 -0400
Received: by mail-ve0-f182.google.com with SMTP id oy12so3795902veb.41
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2013 01:00:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1309162253320.17217@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prasanna NAVARATNA <prasanna.navaratna@gmail.com>

On 16 September 2013 22:57, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Ulf
>
> On Mon, 16 Sep 2013, Ulf Hansson wrote:
>
>> According to the eMMC/SD/SDIO specs the VDD voltage level must not be changed
>> during the initialization, without a complete power cycle of the card.
>>
>> Before this patchset, some host drivers were trying to change voltage level
>> at MMC_POWER_ON state, which is also what the protocol layer advised them to.
>> This was not correctly done and is the reason to why quite messy code in
>> the protocol layer has been needed, to handle a re-initialization sequence,
>> typically triggered from a power_restore or resume.
>>
>> I have tried to make each patch in the patchset as small and separate as
>> possible, surely the is room for improvments. Any suggestions are appreciated.
>>
>> An important note; MMC_CAP2_FULL_PWR_CYCLE, will need to be set by a host
>> to tell the protocol layer that the host is able to perform a complete power
>> cycle. Thus the protocol layer will try to negotiate the lowest possible VDD
>> voltage level between the card and host.

Hi Guennadi,

>
> I've got a question to this one. You mean a power cycle of a card, right?

Correct!

> What if the card power is supplied by a regulator. How do you tell whether
> you can power cycle it or not? Maybe you can theoretically switch that
> regulator - sometimes. On other occasions other users might be preventing
> it from really powering off. Do you really need a guarantee, that every
> time you issue a power down .set_ios() the card will really be switched
> off? I don't see how this can be possible in my example?

Yes, we need a guarantee to be able to conform to the specs.

In one of my cases I am also using a regulator, but from a board
configuration point of view I know I am the only user on this
regulator, thus I can be sure I can switch it off when I want.

I see your point though, and I am not sure how to adapt to this
configuration. I suggest you to not set the MMC_CAP2_FULL_PWR_CYCLE
for that mmc host - unless you can find a way to make sure you can cut
and restore power when needed.

Kind regards
Ulf Hansson

>
> Thanks
> Guennadi
>
>>
>>
>> Ulf Hansson (7):
>>   mmc: core: Let mmc_power_up|cycle take ocr as parameter
>>   mmc: core: Let mmc_set_signal_voltage take ocr as parameter
>>   mmc: core: Remove unnecessary retry mechanism at SDIO attach
>>   mmc: core: Cleanup code for setting ocr mask for SDIO
>>   mmc: core: Move cached value of the negotiated ocr mask to card
>>     struct
>>   mmc: core: Prevent violation of specs while initializing cards
>>   mmc: core: Collect common code for card ocr validation
>>
>>  drivers/mmc/core/core.c  |   66 +++++++++++++++++--------------------
>>  drivers/mmc/core/core.h  |    6 ++--
>>  drivers/mmc/core/mmc.c   |   29 +++++-----------
>>  drivers/mmc/core/sd.c    |   41 +++++++----------------
>>  drivers/mmc/core/sdio.c  |   82 ++++++++++++++--------------------------------
>>  include/linux/mmc/card.h |    1 +
>>  include/linux/mmc/host.h |    1 -
>>  7 files changed, 79 insertions(+), 147 deletions(-)
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
