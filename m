From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers: mmc: card: Fixing few coding style errors from
 file block.c
Date: Sat, 31 Jan 2015 10:44:50 -0800
Message-ID: <1422729890.2682.1.camel@perches.com>
References: <1422727667-15785-1-git-send-email-sheetal.tigadoli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:53585 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753459AbbAaSoy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Jan 2015 13:44:54 -0500
In-Reply-To: <1422727667-15785-1-git-send-email-sheetal.tigadoli@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org

On Sat, 2015-01-31 at 23:37 +0530, Sheetal Tigadoli wrote:
> The patch fixes some of the following error/warnings from the file block.c
> 
> ./scripts/checkpatch.pl  --file --terse drivers/mmc/card/block.c

Hi.

It's a lot easier to review and accept these sorts of
changes if you break them into more discrete patches.

Try bundling all the similar types of changes into
single patches, each doing more or less the same thing.

Something like:

1: line length conversions
   btw: Please use checkpatch --strict to make sure that
	multi-line statements are aligned appropriately
2: adding removing blank lines and braces position/removals
3: strto -> kstrto conversions
4: else not necessary
5: coalescing split strings
6: include path conversions

Also please use a cover letter when submitting multiple patches.
It makes it easier to ack and apply the whole set.

> drivers/mmc/card/block.c:45: WARNING: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
> drivers/mmc/card/block.c:102: WARNING: line over 80 characters
> drivers/mmc/card/block.c:186: WARNING: Missing a blank line after declarations
> drivers/mmc/card/block.c:238: WARNING: line over 80 characters
> drivers/mmc/card/block.c:251: WARNING: line over 80 characters
> drivers/mmc/card/block.c:279: WARNING: simple_strtoul is obsolete, use kstrtoul instead
> drivers/mmc/card/block.c:280: WARNING: Missing a blank line after declarations
> drivers/mmc/card/block.c:578: WARNING: line over 80 characters
> drivers/mmc/card/block.c:586: WARNING: line over 80 characters
> drivers/mmc/card/block.c:620: WARNING: Missing a blank line after declarations
> drivers/mmc/card/block.c:1209: WARNING: line over 80 characters
> drivers/mmc/card/block.c:1333: WARNING: quoted string split across lines
> drivers/mmc/card/block.c:1720: WARNING: Missing a blank line after declarations
> drivers/mmc/card/block.c:1734: WARNING: braces {} are not necessary for single statement blocks
> drivers/mmc/card/block.c:1881: WARNING: else is not generally useful after a break or return
> drivers/mmc/card/block.c:2019: WARNING: braces {} are not necessary for single statement blocks
> drivers/mmc/card/block.c:2226: WARNING: line over 80 characters
> drivers/mmc/card/block.c:2285: WARNING: line over 80 characters
> drivers/mmc/card/block.c:2362: ERROR: that open brace { should be on the previous line


