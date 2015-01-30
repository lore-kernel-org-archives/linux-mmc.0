From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: core: use card pointer as the first parameter of execute_tuning()
Date: Thu, 29 Jan 2015 16:13:34 -0800
Message-ID: <CAD=FV=XCBebTzWpNPn9GaTRU3O1BMurhoTDWcXHYXBChBRnOjQ@mail.gmail.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
	<1422271175-19445-2-git-send-email-addy.ke@rock-chips.com>
	<CAPDyKFp=5epMggHu0+u_LU7ETujcoeP2xOpB7iD6JF2bs8BnEA@mail.gmail.com>
	<CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
	<CAPDyKFqjG=yxDcwnk4jbXMZ05hMkWR2x37uVpRNd_11-eB4G7w@mail.gmail.com>
	<CAD=FV=VQg+sQUpgbKw7Zz=-f+jPM=6O-+3gUpohWhj8JeSPu6Q@mail.gmail.com>
	<CAPDyKFqjY-Sn2mNqjy1FH3RPFuJSfhTX_esQDao1Yb4qumHYcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:47663 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbbA3ANf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 19:13:35 -0500
Received: by mail-ig0-f171.google.com with SMTP id r10so13855199igi.4
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2015 16:13:34 -0800 (PST)
In-Reply-To: <CAPDyKFqjY-Sn2mNqjy1FH3RPFuJSfhTX_esQDao1Yb4qumHYcg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Ulf,

On Thu, Jan 29, 2015 at 1:16 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> - Drastically decreased cc-list.
>
> On 29 January 2015 at 01:55, Doug Anderson <dianders@chromium.org> wrote:
>> Ulf,
>>
>> On Tue, Jan 27, 2015 at 7:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> I asked Addy to post upstream against mmc_send_tuning(), but I guess
>>>> he didn't (he posted against Alex's NAKed patch instead).
>>>>
>>>> ...when I talked to him about it, Addy was asserting that when tuning
>>>> fails it is important (at least on dw_mmc on rk3288) that we wait for
>>>> the card to stop being busy and that the way to detect was using
>>>> mmc_send_status().
>>>
>>> So, could that be due to the internal logic of the error handling in
>>> dw_mmc driver? Or you think this is a generic issue?
>>>
>>> According to the specifications (eMMC and SD) both states that the
>>> tuning command has an R1 response. So, there shouldn't be any busy
>>> signalling involved - at least according to spec.
>>
>> I did a bit of digging into this issue myself.  What I found was that
>> a "response CRC" and "end of transfer".  This was why I posted up
>> <https://patchwork.kernel.org/patch/5623071/>.  From that patch:
>>
>>> Specifically it looks like in certain error conditions (I saw this
>>> with Response CRC errors) that data keeps showing up in the FIFO even
>>> after the error is reported and the CD (command done) bit is set.  If
>>> we don't wait for this data to finish transferring then it confuses
>>> the next transaction.  In the specific failure case I ran into I found
>>> that I could monitor the data_state_mc_busy bit and wait for it to
>>> clear, but in other failure cases this bit was stuck at busy when we
>>> saw an error.  Hence a generic big delay seems like the only option.
>
> I haven't queued that patch, I was waiting for an ack from Seungwon or Jaehoon.
>
> Do you think it could solve this issue, we could give it a try!?

My big fat delay does seem to solve the issue, but it has the side
effect of slowing down tuning quite a bit so I'd rather find a more
proper fix.  We're talking several hundred extra milliseconds slower
per slot that is tuned...

I still don't exactly have a warm fuzzy about using the send_status()
command like this, but it seems to work (actually, I should verify
that myself--I've been taking Addy's word that his solution works).  I
do wish someone could tell me "oh right, yeah, we do need a
send_status in that case".  ;)  Addy said that in the non-tuning case
that the core will always do a send_status so that this fix is really
only for tuning and doesn't need to be applied in general.  I also
haven't validated that myself...

Overall it does sorta seem like this might just be a quirk with the
rk3288 dw_mmc.  It feels like the controller is in a wonky state and
maybe this extra send_status helps it get out?


>> ...Addy instead fixed the problem using mmc_send_status() to try to
>> detect when the transfer was all done and it apparently worked, but it
>> seemed odd to me.  My MMC "expertise" pretty much ends with looking
>> for simple logic errors in the MMC driver, so my hope was that one of
>> you guys would know this better...
>>
>>
>>>> That would mean that against upstream you'd need to change
>>>> mmc_send_tuning() to take in the card as well (or move the "host->card
>>>> = card" assignment to before UHS init, which seems less desirable?)
>
> I get your point now.
>
> Changing mmc_send_tuning() to take "card" will work due to $subject
> patch changed the ->execute_tuning() callbacks to take "card" as well.
>
>>>>
>>>> What do you think about that?  Is there a better solution?
>>>
>>> Why do we need to change mmc_send_tuning()? I thought the issue was
>>> that mmc_send_status(), which currently takes "card" as a parameter.
>>
>> Well, if mmc_send_tuning() needed to call mmc_send_status() then
>> mmc_send_tuning() would need the card parameter, right?
>
> Correct, got it now. :-)
>
> I didn't understand that you wanted mmc_send_tuning() to invoke
> mmc_send_status() while it got some errors. From Addy's patch2,
> mmc_send_status() is invoked from the host driver.
>
> Anyway, I think we should follow your suggestion to change the
> behaviour of mmc_send_tuning(). Though, I think it should use
> bus_ops->alive() callback instead (and that callback then also need to
> change to take "card" as a parameter), since that would be generic and
> the cover the SDIO case as well.

That sounds reasonable to me.

Addy: you've been very quiet.  What do you think?

-Doug
