From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Wed, 30 Mar 2016 19:16:18 +0200
Message-ID: <CAFqH_53Dsm5Cd6XzLai=_zGSvjQ_-uO4jQGKpBp-crztTXc-mg@mail.gmail.com>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
	<CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
	<CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
	<20160324153056.GT19428@n2100.arm.linux.org.uk>
	<CAD=FV=VkQKaVBdR6gaoeXDso5L37aGaXV717=y=0tyAMwigpbA@mail.gmail.com>
	<20160324162220.GV19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34524 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbcC3RQT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2016 13:16:19 -0400
In-Reply-To: <20160324162220.GV19428@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Javier Martinez Canillas <javier@osg.samsung.com>

2016-03-24 17:22 GMT+01:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Mar 24, 2016 at 09:06:45AM -0700, Doug Anderson wrote:
>> Russell,
> ...
>> Presumably this is similar to what you saw: the host saw the CRC error
>> but the card knew nothing about it.  Sending the stop command during
>> this time confused the card.  Presumably the card was in transfer
>> state during this time?
>
> If the card was in transfer state for a command which expects a stop
> command, and that stop command was issued after the card entered
> the transfer state, then I'd expect the card to handle it... though
> there's always the firmware bug issue.
>
> If the card hadn't entered transfer state at the time the stop command
> was issued.. I think that's more likely to hit card firmware issues.
>
> With the tuning commands, there's another case you can hit though:
> the data transfer may have completed before you get around to sending
> the stop command.
>
> That's why, for sdhci, I came to the conclusion that waiting for the
> data transfer to complete or timeout was the best solution for SDHCI.
>

In fact I only saw the problem with dw_mmc-exynos, on dw_mmc-rockchip
it doesn't happen because it enables the DW_MCI_QUIRK_BROKEN_DTO
behaviour. What does this is use a kernel timer to signal when DTO
interrupt does NOT come. Note that if I disable this quirk I can also
saw the problem on rockchip.

> Maybe, if sending a STOP command does cause card firmware issues, then:
>
> 1) it provides evidence that trying to send a stop command on response
>    CRC error is the wrong thing to do (it was talked about making SDHCI
>    do this.)
>

Seems the same here, so guess is the wrong thing to do.

> 2) it suggests that the solution I came up with for SDHCI is the better
>    solution, rather than trying to immediately recover the situation by
>    sending a STOP command.
>

I'm wondering if just enable this quirk on exynos too is the proper
solution. Unfortunately I don't have enough documentation to check
differences between those controllers.
Also will really help have access to some hardware that uses
dw_mmc-pltfm to check if, like on exynos, same issue is triggered.
Anyone with the hardware who can do some tests?


> Maybe dw-mmc can do something similar, but with the lack of data transfer
> timeout, maybe it's possible to do something with a kernel timer instead,
> and check what the hardware is doing after a response CRC error?
>
> --
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
