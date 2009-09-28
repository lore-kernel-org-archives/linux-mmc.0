From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Move MMCI header to amba include dir
Date: Mon, 28 Sep 2009 19:17:42 +0100
Message-ID: <20090928181742.GH10671@n2100.arm.linux.org.uk>
References: <1253625972-19407-1-git-send-email-linus.walleij@stericsson.com> <9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48037 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZI1SSV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 14:18:21 -0400
Content-Disposition: inline
In-Reply-To: <9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Sep 28, 2009 at 10:11:29AM -0700, Scott Branden wrote:
> Hi Linus,
> 
> You changes cause the bcmring platform to fail to compile.
> 
> Can you go through all the ARM platforms and make the
> necessary adjustments with the change in header files
> for mmc?

Since Linus's change has been merged, and it's a conflict caused by
simultaneous development, you _both_ need to work towards sorting it
out.

Please put some time into looking at the changes and doing whatever's
necessary to sort bcmring out.  It's quite a simple change at the
end of the day - a move of a header file and a rename of a structure.
