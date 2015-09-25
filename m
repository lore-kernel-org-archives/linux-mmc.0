From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/3] mmc: Wait for card_busy before starting sdio requests
Date: Fri, 25 Sep 2015 09:14:17 -0700
Message-ID: <CAD=FV=VVu5V77K073JAy884GZUAgeNUFmsJU4d-k4GGoW_6Tkg@mail.gmail.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
	<CAPDyKFqvnVTL0pDLc8S1Ssqmy5WXR9+=uCWq8ONmgrYU=Zzoow@mail.gmail.com>
	<5603C020.80603@redhat.com>
	<CAD=FV=UacwyVcX+ZwCJ+iuhTGyr8ktOw7EiMxng8G1EmwXomJQ@mail.gmail.com>
	<5604FD94.4020808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35958 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbbIYQOT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2015 12:14:19 -0400
Received: by ykdt18 with SMTP id t18so119466885ykd.3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2015 09:14:18 -0700 (PDT)
In-Reply-To: <5604FD94.4020808@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Arend van Spriel <arend@broadcom.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Addy Ke <addy.ke@rock-chips.com>

Hi,

I think Jaehoon has already responded to much of this, but...

On Fri, Sep 25, 2015 at 12:53 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> 1. Only one of the two callers of dw_mci_wait_while_busy() is handled
>> by your patch.  mci_send_cmd() is used internally in dw_mmc to throw
>> something in the CMD register without going through the normal MMC
>> path.  This is used exclusively to update the clock registers in
>> dw_mmc.  I'm pretty sure this needs the wait, too.  It's always seemed
>> weird / awkward to me that you need to use the CMD register to update
>> clock settings in dw_mmc, but c'est la vie.
>
>
> I would not expect the card to signal busy when trying to change clocks
> though, so I do not think this will really be a problem.

I just can't quite remember what problem I was seeing.  Let's see...
I'll comment out that and see if I can find any errors.

OK, I commented it out and ran a bit of stress testing for the 4
devices / 4 cards sitting at my desk.  I saw no issues.  I also ran
some of the MMC tests that have caused me problems in the past and saw
no problems.  I also looked back at
<https://chromium-review.googlesource.com/#/c/244850/> where this
landed in our tree and I see that my comment is:

> Actually, while this works I may need to extend it to also be used for mci_send_cmd().

That indicates no problems on my end without the check before updating
clocks.  ...but, oh, I see why this is.  It was even posted upstream!
:)

https://patchwork.kernel.org/patch/5858221/

I said:

> Sorry for the quick spin.  After I posted this I re-read all the
> messages and it looks like Addy has an actual SD card (not SDIO) that
> is also asserting busy.  He's seeing it assert busy around the clock
> update.

 ...so I guess the answer here is that I personally haven't seen any
problems, but adding this check in mci_send_cmd() shouldn't hurt,
should be safe, and might avoid some problems.  Note that it's
possible that Addy was seeing some other bug somewhere that simply
resulted in the "busy" line being asserted, but technically the
Designware databook recommends waiting for "not busy" before updating
clocks IIRC.


>> 2. If I remember correctly, we ran into other instances where non-SDIO
>> cards needed the busy check.  It wasn't terribly common, but I think I
>> ran into this when stress testing, but only on a few cards.
>
>
> Hmm, that would be a problem yes.

So perhaps it would be good to update your patch to check for all data commands?


>> The patch referenced here only seems to check for SDIO commands.  As I
>> understand it, to be correct, it should check for all data commands
>> (other than stop or voltage change commands).
>
>
> But that is not what the patch does, it actually waits for all commands,
> including non data commands. An earlier attempt of mine to fix the sdio
> wifi issues with the sunxi driver copied your approach, and I actually
> got reports of regressions with using normal micro-sd memory cards
> from several people testing that patch.

You're saying that my patch waits for all commands including non-data
commands.  I'm pretty sure that's not true.  It relies on a whole
bunch of other logic in dw_mmc that figures out that we have a data
command (and that logic also looks for stop commands).  Specifically
my patches keys off SDMMC_CMD_PRV_DAT_WAIT.  Looking how that gets set
in dw_mci_prepare_command():
* We don't set it for the various "stop" commands
* Else we set it for all commands with cmd->data, except "send status"


> And if you're right that we should wait for all data commands, then
> I wonder if this is a designware thing (I believe the allwinner
> mmc controller is designware derived) or a generic mmc / sdio thing ?

It seems hard to believe it would be Designware specific.  If I
understand correctly, "busy" is signaled by the card holding the data
lines low.  ...so if a normal SD card was really asserting busy then
you'd better not send a command.


>> The Designware Databook
>> makes no reference to only needing the wait for SDIO commands.
>
>
> Yet your commit message references problems with sdio wifi cards, and
> on sunxi we've only been seeing this problem with sdio wifi cards / sdio
> commands.

Yup.  Though I did some amount in parallel, I definitely focused on
SDIO problems first before focusing on UHS SD cards.  ...so my primary
focus was on SDIO here but I tried to code it in a generic way so it
would be useful for all data commands (since it seemed like it could
technically affect them).


-Doug
