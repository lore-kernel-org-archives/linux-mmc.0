From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Thu, 31 Mar 2016 09:56:18 +0800
Message-ID: <56FC83C2.3000703@rock-chips.com>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
 <CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
 <CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
 <20160324153056.GT19428@n2100.arm.linux.org.uk>
 <CAD=FV=VkQKaVBdR6gaoeXDso5L37aGaXV717=y=0tyAMwigpbA@mail.gmail.com>
 <20160324162220.GV19428@n2100.arm.linux.org.uk>
 <CAFqH_53Dsm5Cd6XzLai=_zGSvjQ_-uO4jQGKpBp-crztTXc-mg@mail.gmail.com>
 <20160330172604.GI19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:43542 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbcCaB4b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2016 21:56:31 -0400
In-Reply-To: <20160330172604.GI19428@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: shawn.lin@rock-chips.com, Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Javier Martinez Canillas <javier@osg.samsung.com>

=E5=9C=A8 2016/3/31 1:26, Russell King - ARM Linux =E5=86=99=E9=81=93:
> On Wed, Mar 30, 2016 at 07:16:18PM +0200, Enric Balletbo Serra wrote:
>> 2016-03-24 17:22 GMT+01:00 Russell King - ARM Linux <linux@arm.linux=
=2Eorg.uk>:
>>> On Thu, Mar 24, 2016 at 09:06:45AM -0700, Doug Anderson wrote:
>>>> Russell,
>>> ...
>>>> Presumably this is similar to what you saw: the host saw the CRC e=
rror
>>>> but the card knew nothing about it.  Sending the stop command duri=
ng
>>>> this time confused the card.  Presumably the card was in transfer
>>>> state during this time?
>>>
>>> If the card was in transfer state for a command which expects a sto=
p
>>> command, and that stop command was issued after the card entered
>>> the transfer state, then I'd expect the card to handle it... though
>>> there's always the firmware bug issue.
>>>
>>> If the card hadn't entered transfer state at the time the stop comm=
and
>>> was issued.. I think that's more likely to hit card firmware issues=
=2E
>>>
>>> With the tuning commands, there's another case you can hit though:
>>> the data transfer may have completed before you get around to sendi=
ng
>>> the stop command.
>>>
>>> That's why, for sdhci, I came to the conclusion that waiting for th=
e
>>> data transfer to complete or timeout was the best solution for SDHC=
I.
>>>
>>
>> In fact I only saw the problem with dw_mmc-exynos, on dw_mmc-rockchi=
p
>> it doesn't happen because it enables the DW_MCI_QUIRK_BROKEN_DTO
>> behaviour. What does this is use a kernel timer to signal when DTO
>> interrupt does NOT come. Note that if I disable this quirk I can als=
o
>> saw the problem on rockchip.
>>
>>> Maybe, if sending a STOP command does cause card firmware issues, t=
hen:
>>>
>>> 1) it provides evidence that trying to send a stop command on respo=
nse
>>>     CRC error is the wrong thing to do (it was talked about making =
SDHCI
>>>     do this.)
>>>
>>
>> Seems the same here, so guess is the wrong thing to do.
>>
>>> 2) it suggests that the solution I came up with for SDHCI is the be=
tter
>>>     solution, rather than trying to immediately recover the situati=
on by
>>>     sending a STOP command.
>>>
>>
>> I'm wondering if just enable this quirk on exynos too is the proper
>> solution. Unfortunately I don't have enough documentation to check
>> differences between those controllers.
>> Also will really help have access to some hardware that uses
>> dw_mmc-pltfm to check if, like on exynos, same issue is triggered.
>> Anyone with the hardware who can do some tests?
>
> I'd really suggest that the dw-mmc folk place a moritorium on quirk
> flags, and instead deal with situations like this without resorting
> to this kind of thing.
>

Some quirks and some callbacks have been cleaned in Jaehoon's repo,and
still some are going to removed. Finally we do plan to turn dw_mmc core
into a pure library..

> sdhci is a good example why the quirk flag approach is totally wrong,
> and shows that it leads to an unmaintainable mess.  If dw-mmc people
> don't want the driver to decend into the same state that sdhci is,
> then things like this should not be quirks.  sdhci already has a
> long-term moritorium on quirk flags until the resulting mess has been
> cleaned up.
>
> The danger that quirk flags cause is also highlighted in your mail:
> it's very likely that this _isn't_ a host controller issue at all,

Two issues found by dw_mmc-rockchip part,
(1) need reset idma when switching between fifo-transfer and
idma-transfer. When biu:ciu > 1:6, idma internal fsm take a risk of
a race condition to maintain its fifo lookup pointer. It can be very
easy reproduce by seting biu:ciu > 1:6.. Common bug for dw_mmc! But=20
unfortunately these details was missing in the commit msg.

(2) Missing DTO/DRTO; I missed the thread for this topic, so I need to
reproduce it by setting a simple C model code. I can't say more
currently until we can find a way to easily reproduce it. But I guess
it's NOT a host issue....since I slightly glance at the TMOUT reg at=20
dw_mmc databook and find a software timer requirement:

31:8 data_timeout 0xffffff
Value for card Data Read Timeout; same value also used for Data
Starvation by Host timeout. The timeout counter is started only after=20
thecard clock is stopped. Value is in number of card output clocks =E2=80=
=93=20
cclk_out of selected card.

Note: The software timer should be used if the timeout value is in the=20
order of 100 ms. In this case, read data timeout interrupt needs to be=20
disabled.

> but a MMC protocol issue or a card issue - and the behaviour required
> here is not specific to any particular host controller.  The problem
> with having a quirk flag for it is that you end up with some hosts
> enabling it, and other hosts having it disabled only because they
> haven't yet tripped over the issue.
>


--=20
Best Regards
Shawn Lin

