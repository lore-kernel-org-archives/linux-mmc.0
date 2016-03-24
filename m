From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Thu, 24 Mar 2016 16:22:20 +0000
Message-ID: <20160324162220.GV19428@n2100.arm.linux.org.uk>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
 <CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
 <CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
 <20160324153056.GT19428@n2100.arm.linux.org.uk>
 <CAD=FV=VkQKaVBdR6gaoeXDso5L37aGaXV717=y=0tyAMwigpbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:56892 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbcCXQWg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 12:22:36 -0400
Content-Disposition: inline
In-Reply-To: <CAD=FV=VkQKaVBdR6gaoeXDso5L37aGaXV717=y=0tyAMwigpbA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Javier Martinez Canillas <javier@osg.samsung.com>

On Thu, Mar 24, 2016 at 09:06:45AM -0700, Doug Anderson wrote:
> Russell,
...
> Presumably this is similar to what you saw: the host saw the CRC error
> but the card knew nothing about it.  Sending the stop command during
> this time confused the card.  Presumably the card was in transfer
> state during this time?

If the card was in transfer state for a command which expects a stop
command, and that stop command was issued after the card entered
the transfer state, then I'd expect the card to handle it... though
there's always the firmware bug issue.

If the card hadn't entered transfer state at the time the stop command
was issued.. I think that's more likely to hit card firmware issues.

With the tuning commands, there's another case you can hit though:
the data transfer may have completed before you get around to sending
the stop command.

That's why, for sdhci, I came to the conclusion that waiting for the
data transfer to complete or timeout was the best solution for SDHCI.

Maybe, if sending a STOP command does cause card firmware issues, then:

1) it provides evidence that trying to send a stop command on response
   CRC error is the wrong thing to do (it was talked about making SDHCI
   do this.)

2) it suggests that the solution I came up with for SDHCI is the better
   solution, rather than trying to immediately recover the situation by
   sending a STOP command.

Maybe dw-mmc can do something similar, but with the lack of data transfer
timeout, maybe it's possible to do something with a kernel timer instead,
and check what the hardware is doing after a response CRC error?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
