From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] Move MMCI header to amba include dir
Date: Mon, 21 Sep 2009 16:11:07 +0100
Message-ID: <20090921151107.GC30821@n2100.arm.linux.org.uk>
References: <1252529727-7957-1-git-send-email-linus.walleij@stericsson.com> <20090921150103.GB30821@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38828 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442AbZIUPLf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2009 11:11:35 -0400
Content-Disposition: inline
In-Reply-To: <20090921150103.GB30821@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Sep 21, 2009 at 04:01:03PM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 09, 2009 at 10:55:27PM +0200, Linus Walleij wrote:
> > This moves the mmci platform data definition struct away from
> > arch/arm/include/asm/mach/mmc.h into the more proper place among
> > the other primecells in include/linux/amba/mmci.h and at the same
> > time renames it to "mmci.h", and also the struct in this file
> > confusingly named mmc_platform_data has been renamed
> > mmci_platform_data for clarity.
> 
> Not sure what's happened, but this patch appears to conflict with
> another, resulting in:

It's also meant that 5702/1 has been dropped in addition to 5699/1.
In future, please ensure that you run a build check on the machines
which you've modified.  Thanks.
