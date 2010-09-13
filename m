From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmc: Add architecture dependency for Marvell SoC
 controller
Date: Mon, 13 Sep 2010 13:02:48 +0100
Message-ID: <20100913120247.GJ16606@rakim.wolfsonmicro.main>
References: <1284366279-17140-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201009131248.38501.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37799 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754534Ab0IMMCu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Sep 2010 08:02:50 -0400
Content-Disposition: inline
In-Reply-To: <201009131248.38501.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 13, 2010 at 12:48:38PM +0200, Arnd Bergmann wrote:

> I think we normally try to do the the other way round: in order to increase
> build coverage, try to enable all drivers on as many platforms as possible,
> just don't have them in the defconfig.

This is not the general pattern for on-CPU devices on the embedded SoCs,
for those we normally only offer the config option when building for a
system which could physically have the device.  Looking at the existing
MMC host drivers you'll see this pattern is already heavily used there -
all the existing embedded controllers have similar dependencies.

> Do you get build errors on other platforms? If yes, there is probably
> a bug in the driver that should be fixed instead.

No, I didn't even try to build it - I saw that I was being offered a
device for a Marvell CPU when building for a non-Marvell CPU.
