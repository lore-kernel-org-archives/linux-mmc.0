From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Thu, 31 Mar 2016 11:12:50 -0700
Message-ID: <CAD=FV=XQ0r0QoJkxkoybxMQe2T0ef6ZU4Jo9TCOj-BB4OULKzw@mail.gmail.com>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
	<CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
	<CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
	<20160324153056.GT19428@n2100.arm.linux.org.uk>
	<CAD=FV=VkQKaVBdR6gaoeXDso5L37aGaXV717=y=0tyAMwigpbA@mail.gmail.com>
	<20160324162220.GV19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35701 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbcCaSMx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2016 14:12:53 -0400
Received: by mail-vk0-f45.google.com with SMTP id e6so113739274vkh.2
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2016 11:12:52 -0700 (PDT)
In-Reply-To: <20160324162220.GV19428@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Javier Martinez Canillas <javier@osg.samsung.com>

Hi,

On Thu, Mar 24, 2016 at 9:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> That's why, for sdhci, I came to the conclusion that waiting for the
> data transfer to complete or timeout was the best solution for SDHCI.
>
> Maybe, if sending a STOP command does cause card firmware issues, then:
>
> 1) it provides evidence that trying to send a stop command on response
>    CRC error is the wrong thing to do (it was talked about making SDHCI
>    do this.)
>
> 2) it suggests that the solution I came up with for SDHCI is the better
>    solution, rather than trying to immediately recover the situation by
>    sending a STOP command.
>
> Maybe dw-mmc can do something similar, but with the lack of data transfer
> timeout, maybe it's possible to do something with a kernel timer instead,
> and check what the hardware is doing after a response CRC error?

Since the problem only reproduced with a single model of a single
brand of card, it is probably a card firmware issue as you say.
Presumably if we put this card in an exynos that had tuning enabled
we'd seem similar issues.  I haven't had a chance to test this.

dw_mmc does have a data transfer timeout, but for some reason it
doesn't seem to fire reliably on Rockchip.  Sounds like Shawn may be
digging here?  In the past I've found that the same code running on
rk3288 and exynos would fire the timeout on exynos but not on rk3288.
That's the reason why rk3288 has a special quirk to enable a software
timer.

In the case of CRC error perhaps the controller sin't sending a data
timeout because it already told us about the CRC error (so need to
report further?), but I guess the quirk on the Rockhip platform makes
it work.


Sounds like the right fix is to enable a timer after the CRC error
(similar to the DTO quirk) and not send a STOP.  Even if it's not a
firmware problem, keeping dw_mmc behaving more like SDHCI is a good
idea because presumably SD cards out there will not test against all
controllers, so we'll have the most compatibility if all controllers
behave the same (even if the spec technically allows them to behave
otherwise).


-Doug
