From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/7] mmc: core: Fixup ocr mask setup to prevent spec violation
Date: Tue, 17 Sep 2013 11:29:21 +0200
Message-ID: <CAPDyKFpfe7mL4aLBo4S4tibpoL8DoiK3TiVzPvc4V-eG1Yrm_w@mail.gmail.com>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.64.1309162253320.17217@axis700.grange>
	<CAPDyKFrvPkwAVfi8gv0hG3DKeiJm+_AqODhERX=O0ZxB-gcHiw@mail.gmail.com>
	<Pine.LNX.4.64.1309171008190.20367@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:59771 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab3IQJ3W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 05:29:22 -0400
Received: by mail-ve0-f177.google.com with SMTP id db12so3847652veb.8
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2013 02:29:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1309171008190.20367@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Mark Brown <broonie@kernel.org>

On 17 September 2013 10:16, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> (adding Mark to cc)
>
> On Tue, 17 Sep 2013, Ulf Hansson wrote:
>
>> On 16 September 2013 22:57, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
>> > Hi Ulf
>> >
>> > On Mon, 16 Sep 2013, Ulf Hansson wrote:
>> >
>> >> According to the eMMC/SD/SDIO specs the VDD voltage level must not be changed
>> >> during the initialization, without a complete power cycle of the card.
>> >>
>> >> Before this patchset, some host drivers were trying to change voltage level
>> >> at MMC_POWER_ON state, which is also what the protocol layer advised them to.
>> >> This was not correctly done and is the reason to why quite messy code in
>> >> the protocol layer has been needed, to handle a re-initialization sequence,
>> >> typically triggered from a power_restore or resume.
>> >>
>> >> I have tried to make each patch in the patchset as small and separate as
>> >> possible, surely the is room for improvments. Any suggestions are appreciated.
>> >>
>> >> An important note; MMC_CAP2_FULL_PWR_CYCLE, will need to be set by a host
>> >> to tell the protocol layer that the host is able to perform a complete power
>> >> cycle. Thus the protocol layer will try to negotiate the lowest possible VDD
>> >> voltage level between the card and host.
>>
>> Hi Guennadi,
>>
>> >
>> > I've got a question to this one. You mean a power cycle of a card, right?
>>
>> Correct!
>>
>> > What if the card power is supplied by a regulator. How do you tell whether
>> > you can power cycle it or not? Maybe you can theoretically switch that
>> > regulator - sometimes. On other occasions other users might be preventing
>> > it from really powering off. Do you really need a guarantee, that every
>> > time you issue a power down .set_ios() the card will really be switched
>> > off? I don't see how this can be possible in my example?
>>
>> Yes, we need a guarantee to be able to conform to the specs.
>>
>> In one of my cases I am also using a regulator, but from a board
>> configuration point of view I know I am the only user on this
>> regulator, thus I can be sure I can switch it off when I want.
>>
>> I see your point though, and I am not sure how to adapt to this
>> configuration. I suggest you to not set the MMC_CAP2_FULL_PWR_CYCLE
>> for that mmc host - unless you can find a way to make sure you can cut
>> and restore power when needed.
>
> So, do I understand correctly, that if we get a regulator exclusively and
> it is capable of changing status (REGULATOR_CHANGE_STATUS) and it is not
> always on, then we can assume, that every call to regulator_enable() /
> regulator_disable() with a suitable use count _will_ switch power off or
> on? Maybe then we could adjust mmc_regulator_get_supply() accordingly -
> first try to get the regulator exclusively, if it fails, try shared. If
> succeeded and the conditions are satisfied - set the new PWR_CYCLE flag.

For SD and SDIO cards, that would be enough - but not for eMMC since
we have both VCC and VCCQ.

If you want to change voltage level for eMMC, both VCC and VCCQ must
be possible to power cycle, unless you have a hw-reset wire connected
to the eMMC which is implemented by a host->ops callback. This
complicates things for SD/SDIO as well, while trying to setup the
conditions for when to set the PWR_CYCLE flag.

BTW, thanks for bringing up this discussion! I have been thinking a
bit around this as well. :-)

Kind regards
Ulf Hansson

>
> Thanks
> Guennadi
>
>> Kind regards
>> Ulf Hansson
>>
>> >
>> > Thanks
>> > Guennadi
>> >
>> >>
>> >>
>> >> Ulf Hansson (7):
>> >>   mmc: core: Let mmc_power_up|cycle take ocr as parameter
>> >>   mmc: core: Let mmc_set_signal_voltage take ocr as parameter
>> >>   mmc: core: Remove unnecessary retry mechanism at SDIO attach
>> >>   mmc: core: Cleanup code for setting ocr mask for SDIO
>> >>   mmc: core: Move cached value of the negotiated ocr mask to card
>> >>     struct
>> >>   mmc: core: Prevent violation of specs while initializing cards
>> >>   mmc: core: Collect common code for card ocr validation
>> >>
>> >>  drivers/mmc/core/core.c  |   66 +++++++++++++++++--------------------
>> >>  drivers/mmc/core/core.h  |    6 ++--
>> >>  drivers/mmc/core/mmc.c   |   29 +++++-----------
>> >>  drivers/mmc/core/sd.c    |   41 +++++++----------------
>> >>  drivers/mmc/core/sdio.c  |   82 ++++++++++++++--------------------------------
>> >>  include/linux/mmc/card.h |    1 +
>> >>  include/linux/mmc/host.h |    1 -
>> >>  7 files changed, 79 insertions(+), 147 deletions(-)
>> >>
>> >> --
>> >> 1.7.9.5
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
