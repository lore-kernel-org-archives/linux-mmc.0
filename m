From: Lee Jones <lee.jones@canonical.com>
Subject: Re: Patch "mmc: fix all hangs related to mmc/sd card insert/removal
 during suspend/resume" has been added to the 2.6.35-stable tree
Date: Thu, 16 Sep 2010 08:21:25 +0100
Message-ID: <4C91C575.5070500@canonical.com>
References: <12845889002548@site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:58035 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab0IPHVd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2010 03:21:33 -0400
In-Reply-To: <12845889002548@site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@suse.de
Cc: maximlevitsky@gmail.com, akpm@linux-foundation.org, david-b@pacbell.net, linux-mmc@vger.kernel.org, stern@rowland.harvard.edu, torvalds@linux-foundation.org, stable@kernel.org, stable-commits@vger.kernel.org

> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@kernel.org> know about it.

I actually intended this patch go on into .32-stable, but I see no solid
reason why it can't go into .35-stable too. There is one issue though. If 
you add this patch and leave out the one below you will break stable when
CONFIG_PM == !y.

mmc: build fix: mmc_pm_notify is only available with CONFIG_PM=y
  81ca03a0e2ea0207b2df80e0edcf4c775c07a505

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=81ca03a0e2ea0207b2df80e0edcf4c775c07a505
