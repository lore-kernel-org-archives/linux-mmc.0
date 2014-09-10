From: Marek Vasut <marex@denx.de>
Subject: Re: [GIT PULL 1/2] SOCFPGA updates for 3.18
Date: Wed, 10 Sep 2014 16:36:47 +0200
Message-ID: <201409101636.47989.marex@denx.de>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com> <4134101.OOENTRabu1@wuerfel> <20140909210232.GA539@amd>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33863 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbaIJOgu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Sep 2014 10:36:50 -0400
In-Reply-To: <20140909210232.GA539@amd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, dinguyen@opensource.altera.com, khilman@linaro.org, olof@lixom.net, arm@kernel.org, dinh.linux@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Tuesday, September 09, 2014 at 11:02:32 PM, Pavel Machek wrote:
> On Tue 2014-09-09 17:02:34, Arnd Bergmann wrote:
> > On Tuesday 09 September 2014 16:17:56 Pavel Machek wrote:
> > > > Jaehoon Chung (1):
> > > >       ARM: dts: socfpga: unuse the slot-node and deprecate the
> > > >       supports-highspeed for dw-mmc
> > > 
> > > This patch is a bad idea. It removes support for two mmc cards on a
> > > single controller -- configuration hardware supports and configuration
> > > that allows using u-SD card on mcvevk board.

This is not true, the MCVEVK does _NOT_ have two cards on a single controller.

> > Your objection comes too late, and to the wrong patch, since the
> > driver and all other users have already been changed. We had a long
> > discussion about this when the issue first came up, and we could
> > not find any example of dw-mmc actually being used in a scenario
> > with one controller that has multiple devices attached.
> 
> Well, this is not first time I raised this. 3.17 is not yet out, so we
> still have chance to fix regressions without major fuss.
> 
> > Apparently every user out there instead uses multiple controller
> > instances instead. Are you sure that the socfpga implementation
> > is an exception from this?
> 
> Marek Vasut has the hardware. His board apprently has uSD and eMMC,
> and I believe it has just one controller. I'll try to get details.

So please go ahead with this PR, sorry for blocking it.

Best regards,
Marek Vasut
