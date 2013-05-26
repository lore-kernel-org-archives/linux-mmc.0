From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: sdhci: support runtime PM for BYT SD cards
Date: Sun, 26 May 2013 14:21:49 -0400
Message-ID: <87r4gtk3eq.fsf@octavius.laptop.org>
References: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55967 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab3EZSVz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 14:21:55 -0400
In-Reply-To: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 6 May 2013 12:17:31 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi Adrian,


On Mon, May 06 2013, Adrian Hunter wrote:
> Hi
>
> Here are 3 patches to support runtime PM for BYT SD cards
>
> Please note that these patches are dependent upon 2 gpio patches
> that are in linux-next and linux-gpio but not the mmc tree.
> Those patches are:
>
> 	author	Mika Westerberg <mika.westerberg@linux.intel.com>	2013-04-03 10:56:54 (GMT)
> 	committer	Linus Walleij <linus.walleij@linaro.org>	2013-04-11 22:31:18 (GMT)
> 	commit	12028d2d216220618f76284af5f8ed510b11da55 (patch)
> 	gpiolib-acpi: introduce acpi_get_gpio_by_index() helper
>
> 	author	Rafael J. Wysocki <rafael.j.wysocki@intel.com>	2013-04-09 13:57:25 (GMT)
> 	committer	Linus Walleij <linus.walleij@linaro.org>	2013-04-10 21:41:17 (GMT)
> 	commit	7fc7acb9a0b0ff3ffdf21818fe0735ebaf4fecb8 (patch)
> 	gpio / ACPI: Handle ACPI events in accordance with the spec
>
> I think those patches are queued for 3.10.

Thanks, I'll pushed these to mmc-next for 3.11 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
