From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Fri, 01 Apr 2011 10:52:12 -0400
Message-ID: <m38vvut46b.fsf@pullcord.laptop.org>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<m3bp0rukeq.fsf@pullcord.laptop.org>
	<AANLkTinUyixNuOnEVdwWVKQ6sf=CdwEGTOGd9RQuGTX_@mail.gmail.com>
	<201104011123.14675.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53867 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932150Ab1DAOq2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Apr 2011 10:46:28 -0400
In-Reply-To: <201104011123.14675.arnd@arndb.de> (Arnd Bergmann's message of
	"Fri, 1 Apr 2011 11:23:14 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org

Hi,

On Fri, Apr 01 2011, Arnd Bergmann wrote:
> I don't think it's even needed, but it sounds much more useful than
> a Kconfig option, so no objections from me.

Cool, thanks.  By the way, I'm pretty neutral on whether there need
to be any Kconfig entries for any of this at all after the module
parameter goes in, so feel free to take them out of the patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
