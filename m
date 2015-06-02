From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Usage of restart_handler in pwrseq_emmc
Date: Tue, 02 Jun 2015 17:29:56 +0200
Message-ID: <1789396.sexGZzDeEb@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:40858 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932501AbbFBPaE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Jun 2015 11:30:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I'm confused by the pwrseq-emmc registering a restart_handler for resetting an 
emmc in a panic-reboot case at priority 129 to "schedules it just before 
system reboot".

>From what I remember from the restart-handler discussion the actuall usage is 
traversing the ordered list until one registered handler sucessfully restarts 
the system and not to have arbitary actions in there not related to the actual 
restart process?

The actual documentation in kernel/reboot.c supports this assumption, 
describing register_restart_handler as "Register function to be called to 
reset the system".


Additionally, 128 isn't even _the_ priority to reboot the system as described 
above and some drivers use higher priorities per default, see in 
drivers/power/reset arm-versatile-reboot.c; at91-reset.c; rmobile-reset.c and 
some more.


So I guess this should use some other mechanism (reboot notifier) instead of 
restart_handlers?


Heiko
