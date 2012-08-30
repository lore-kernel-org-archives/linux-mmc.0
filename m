From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmc: core: Quieten "could not set regulator OCR" error.
Date: Thu, 30 Aug 2012 10:12:14 -0700
Message-ID: <20120830171214.GD4356@opensource.wolfsonmicro.com>
References: <87a9xfyko6.fsf@octavius.laptop.org>
 <CAPDyKFofwC-t-7vhxjF5PUZKTiqYxZh8Kh6J6cLCTFuDTw1-eQ@mail.gmail.com>
 <87mx1dvo9s.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52395 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753928Ab2H3RMS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Aug 2012 13:12:18 -0400
Content-Disposition: inline
In-Reply-To: <87mx1dvo9s.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>

On Wed, Aug 29, 2012 at 09:08:47AM -0400, Chris Ball wrote:
> On Wed, Aug 29 2012, Ulf Hansson wrote:
> > On 28 August 2012 01:33, Chris Ball <cjb@laptop.org> wrote:

> >> Some distributions build with CONFIG_REGULATOR_DUMMY=y -- this makes
> >> regulator setup succeed harmlessly, but then trying to set the voltage
> >> on the dummy regulator will fail as below:

> >> [ 6.413866] sdhci-pci 0000:03:00.0: SDHCI controller found [1180:e822]
> >> (rev 0)
> >> [ 6.414081] _regulator_get: 0000:03:00.0 supply vmmc not found, using
> >> dummy regulator
> >> [ 6.415252] mmc0: SDHCI controller on PCI [0000:03:00.0] using DMA
> >> [ 6.415294] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
> >> [ 6.444241] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
> >> [ 6.473648] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
> >> [..]

> >> Since this isn't an error in this case, move the error to pr_debug().
> >> Reference: https://bugs.archlinux.org/task/29008

> >> Signed-off-by: Chris Ball <cjb@laptop.org>

> > I am not sure this is the correct solution. Would it be possible
> > prevent sdhci-* from calling mmc_regulator_set_ocr when it has gotten
> > a "dummy" regulator some how?

> Looks like regulator_desc->name should be "dummy", but I think it would
> be an API violation for us to start caring about that.  Mark, would you
> be interested in offering an "regulator_is_dummy(supply)" function so
> that we can limit our error messages to non-dummy supplies?

No, that's a terrible idea as previously discussed.

The *sole* purpose of the dummy regulator driver is to provide a crutch
to keep systems with broken configuraitons running, it's not indended to
be used on production systems and is there solely as an aid for
development.  This is why it can only be enabled via Kconfig.  If there
is no software controllable regulator there the board should be
providing fixed regulator.

Conversely there is nothing stopping other regulator drivers having
similar properties to the dummy driver, or constraints stopping them
implementing things.  If the MMC framework wants to silently accept
regulators that don't allow the voltage to be set then the MMC framework
should enumerate the range of voltages which can be set using the
regulator it has and then take appropriate action.
