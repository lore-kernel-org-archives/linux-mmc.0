From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
Date: Fri, 7 May 2010 11:13:57 +0200
Message-ID: <i2t63386a3d1005070213u2ad32613w694be1ecbeb46856@mail.gmail.com>
References: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34903 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0EGJOA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2010 05:14:00 -0400
In-Reply-To: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Dan is this patch set OK?

Sorry if you're busy, just need to check...

Patches 1 thru 4 should be uncontroversial, only affects
our ST-Ericsson platforms and have been thorougly reviewed.

As posted elsewhere this is tested on an ARM reference
design now as well, which IMHO would make it OK to apply
also the PL011 patch, nr 5.

(OK Russell?)

Nr 6 and 7 depend on changes in Russells -next branch
so unless you want to bring in the ARM next to your tree
as well, you can wait with these.

Yours,
Linus Walleij
