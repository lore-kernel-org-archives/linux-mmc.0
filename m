From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] MMC: remove regulator refcount fiddling in mmc core
Date: Sat, 26 Jun 2010 21:37:52 +0100
Message-ID: <DDE00276-5AB7-4A7E-AA93-29755DE8E874@opensource.wolfsonmicro.com>
References: <1277392337-27627-1-git-send-email-linus.walleij@stericsson.com> <20100625112232.GA21217@opensource.wolfsonmicro.com> <AANLkTikiPByvzfbj-gwfyozWb5MMJXSWuINFbrLdcwtU@mail.gmail.com> (sfid-20100626_183725_929817_AB417141)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41114 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753132Ab0FZUh5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Jun 2010 16:37:57 -0400
In-Reply-To: <AANLkTikiPByvzfbj-gwfyozWb5MMJXSWuINFbrLdcwtU@mail.gmail.com> (sfid-20100626_183725_929817_AB417141)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Bengt Jonsson <bengt.g.jonsson@stericsson.com>

On 26 Jun 2010, at 18:37, Linus Walleij wrote:
> 2010/6/25 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>> 

>> So, the feedback from folks at the time this was originally written was
>> that the MMC code was unable to cope with sharing regulators since it
>> really needs to be able to set specific voltages.  This needn't be a
>> showstopper since people can force a single voltage in the constraints
>> but it does need to be considered here.

> Well hm, that's not strictly true. If you only provide one standard
> voltage ONLY in your OCR mask, i.e. MMC_VDD_* then you can use
> the same regulator for two or more MMC cards.

This is what I'm saying about forcing a voltage in the constraints - the
existing code should i believe implement the above automatically.

> Further that's a perfectly reasonable thing to do if you have e.g.
> two embedded eMMC cards and you know which voltage they like
> to operate on ... so share the same regulator, why not. The above
> assumption comes from a slot-based world.

Right, but this code supports all MMC cards. To repeat what I said
above this does need to be considered here. I don't think it's a
particular problem, probably just turning it into a consumer capable
of sharing the regulator would be enough.

> Another argument is that a function named
> mmc_regulator_set_ocr() shouldn't be enabling/disabling regulators
> anyway because it's hopeless to read the code, and the other
> functions in mmc/core.c only deals with voltages, not on/off:ing.
> (Maybe it's just me who have a hard time reading code like that.)

This seems rather surprising - are you saying that no other MMC drivers
are able to manage power to the slot? There was a strong insistence
when this code was originally written that it was essential to be able to
power up and down the regulators for MMC applications.
