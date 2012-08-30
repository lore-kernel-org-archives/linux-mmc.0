From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmc: core: Quieten "could not set regulator OCR" error.
Date: Thu, 30 Aug 2012 10:30:57 -0700
Message-ID: <20120830173055.GF4356@opensource.wolfsonmicro.com>
References: <87a9xfyko6.fsf@octavius.laptop.org>
 <CAPDyKFofwC-t-7vhxjF5PUZKTiqYxZh8Kh6J6cLCTFuDTw1-eQ@mail.gmail.com>
 <87mx1dvo9s.fsf@octavius.laptop.org>
 <20120830171214.GD4356@opensource.wolfsonmicro.com>
 <873934qok9.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53949 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752545Ab2H3RbB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Aug 2012 13:31:01 -0400
Content-Disposition: inline
In-Reply-To: <873934qok9.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>

On Thu, Aug 30, 2012 at 01:25:58PM -0400, Chris Ball wrote:
> On Thu, Aug 30 2012, Mark Brown wrote:

> > Conversely there is nothing stopping other regulator drivers having
> > similar properties to the dummy driver, or constraints stopping them
> > implementing things.  If the MMC framework wants to silently accept
> > regulators that don't allow the voltage to be set then the MMC framework
> > should enumerate the range of voltages which can be set using the
> > regulator it has and then take appropriate action.

> I didn't do this because I don't want to silently accept real regulators
> with insufficient voltage ranges, because that would make it harder to
> debug real MMC failures.

> Sounds like my response to the bug reports should be "persuade your
> distro kernel maintainers to turn off CONFIG_REGULATOR" -- I'll try
> doing that.

Or alternatively persuade someone to provide the appropriate fixed
voltage regulators as part of instantiating the MMC device on these
systems.
