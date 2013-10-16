From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase in system manager
Date: Wed, 16 Oct 2013 20:56:49 +0200
Message-ID: <201310162056.49706.arnd@arndb.de>
References: <1381780051-1826-1-git-send-email-dinguyen@altera.com> <201310152147.27569.arnd@arndb.de> <525DA3BE.2030304@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58919 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761302Ab3JPS5M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 14:57:12 -0400
In-Reply-To: <525DA3BE.2030304@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: dinguyen@altera.com, Pavel Machek <pavel@denx.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 15 October 2013, Dinh Nguyen wrote:
> This makes sense for the SD/MMC driver, but do you think I can use the 
> same approach for
> other drivers that this system manager touches?

It might not be as straightforward for every driver, but something like
this should work at least for some of the more interesting ones. For the
rest, you can have a system manager driver that exports functions.

> i.e. The ethernet IP's 
> PHY setting is controlled
> by a register that is in the system manager as well.
>
> I have submitted this patch for enabling ethernet. It is making use of 
> the driver platform specific
> driver calls to touch the system manager.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200173.html

I definitely don't want to see auxdata getting used for stuff like this.

In case of the ethernet driver, I suspect an SoC specific PHY driver would
be the right approach.
 
> Just wondering if that is right approach for the ethernet driver? If 
> not, then I think I may have
> to come up with a generic system manager driver so that it can be used 
> for other IPs.

The general way of handling this should be to see if there is a subsystem
available for handling a particular feature. In case of clk and phy, we
have those subsystems, so it's a matter of writing an appropriate driver
that communicates with the high-level drivers using that.

I don't know what other features are provided by the system manager that
might need a different solution, but if you can't come up with a nice
solution, you can either have an soc specific portion in the device driver
(as you suggested for sdmmc first), or you can have that platform specific
mfd driver exporting some functions.
If the functionality is actually something common but doesn't have a
subsystem in Linux yet, the "right" approach might also be to introduce
a new subsystem, which I realize can be a lot of work.

	Arnd
