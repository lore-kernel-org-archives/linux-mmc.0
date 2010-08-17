From: Russell King <rmk@arm.linux.org.uk>
Subject: MMC breakage
Date: Tue, 17 Aug 2010 14:54:56 +0100
Message-ID: <20100817135455.GB6681@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40857 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0HQNzk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 09:55:40 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

I get the following build error:

	drivers/built-in.o: In function `mmc_alloc_host':
	mmci.c:(.text+0x80c44): undefined reference to `mmc_pm_notify'

Seems to be down to 4c2ef25fe.  The commit claims to fix the CONFIG_PM=n
build, but it seems not to as mmc_pm_notify() is within an #ifdef CONFIG_PM
block but the initialization isn't.

akpm - do you still have your "fix CONFIG_PM=n" changes for this patch?

-- 
Russell King
