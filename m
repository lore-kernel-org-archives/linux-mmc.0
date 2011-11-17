From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for testing of non read/write Commands
Date: Thu, 17 Nov 2011 14:41:48 +0000
Message-ID: <201111171441.48504.arnd@arndb.de>
References: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53200 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab1KQOmD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 09:42:03 -0500
In-Reply-To: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>, Girish K S <girish.shivananjappa@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Aries Lee <arieslee@jmicron.com>, Arindam Nath <arindam.nath@amd.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>

On Wednesday 16 November 2011, Shashidhar Hiremath wrote:
> The patch provides An infrastructure to test commands other than Read/Write commands using the IOCTL interface.The Patch can be useful incase of validating the device to verify whether device support a given command or not. The result of the sent command will be written to the  result element of the mmc_ioc_cmd structure passed through IOCTL interface.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Hi Shashidhar,

Unfortunately, I have to tell you that an implementation like this is
inappropriate for a number of reasons. My feeling is that most
importantly you should instead have the test logic entirely in user
space and only call the existing ioctl in the kernel. This would
make the entire patch obsolete, so I'm not commenting on the other
problems.

What has lead you to implementing the individual test cases in the
kernel?

	Arnd
