From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Thu, 24 Mar 2016 15:30:56 +0000
Message-ID: <20160324153056.GT19428@n2100.arm.linux.org.uk>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
 <CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
 <CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:56695 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbcCXPbO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 11:31:14 -0400
Content-Disposition: inline
In-Reply-To: <CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Javier Martinez Canillas <javier@osg.samsung.com>

On Thu, Mar 24, 2016 at 12:26:43PM +0100, Enric Balletbo Serra wrote:
> I just saw that Russell introduced a patch [1] that will land on 4.6.
> I think that patch solves the same issue that we're trying to fix, but
> for sdhci controller.

It doesn't sound like the same issue to me, though it was a long while
back when I was looking at sdhci, so I may be misremembering.

> The problem that we have on peach-pi, with our patch applied, is that
> when we get a response CRC error on a command and we move to start
> sending data, the transfer doesn't receives a timeout interrupt (I
> don't know why). As I told, on rockchip works due the DTO quirk.
> exynos is not using this quirk. Also, please correct me if I'm wrong,
> looks like the sdhci controller has a timer to signal the command
> timed out.

>From what I remember, the problem I was seeing is that SDHCI sends a
command (iirc, a tuning command), and receives a response CRC error.
The card, however, knows nothing about the CRC error, so it moves into
the transfer state.

Meanwhile, SDHCI stopped processing the command, resetting the SDHCI
controller and reporting the error to the upper layers.

Then, a new command gets queued, issued to the card, and this fails
because the card is still in transfer state.  This totally screws up
the SDHCI UHS tuning.

This is not the only SDHCI UHS tuning bug: others exist which do not
yet have patches, where we can get spurious false positives/false
negatives for various tuning steps which totally confuse the code.

>From what you say above, your issue is that you get a response CRC
error, but the dw MMC masks the data side, which sounds like a
different solution is needed.  The MMC block driver error handling
is fairly robust, but there is no core error handling (because the
error handling is not obvious.)  So any command not eminating from
the MMC block driver that invokes a transfer from the card which
fails won't have a stop command sent for it.

Maybe that's a weakness of the core MMC code: when I originally
designed that part of the MMC code, my thoughts were to leave error
handling to the higher levels (such as MMC block) because its
dependent on those higher levels.  Eg, the various status bits
which report errors, whether a stop command needs to be issued,
etc.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
