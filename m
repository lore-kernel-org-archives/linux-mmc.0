From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
	the driver
Date: Fri, 14 Dec 2012 15:10:03 +0000
Message-ID: <20121214151002.GK14363@n2100.arm.linux.org.uk>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com> <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59964 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524Ab2LNPKM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 10:10:12 -0500
Content-Disposition: inline
In-Reply-To: <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Fri, Dec 14, 2012 at 03:30:29PM +0100, Ulf Hansson wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> There are currently two instances of the ios_handler being used.
> Both of which mearly toy with some regulator settings. Now there
> is a GPIO regulator API, we can use that instead, and lessen the
> per platform burden. By doing this, we also become more Device
> Tree compatible.

Err, why is this needed?  What's wrong with using the 'vmmc' for this?

>From what I read in the mmc core, vmmc handling via mmc_regulator_set_ocr()
can cope with GPIO-based regulators, and if you have a single GPIO signal
then you have a single supply (it's either on or off).  So what's wrong
with using the existing regulator hooks for this which are already there?
