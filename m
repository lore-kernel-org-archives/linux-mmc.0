From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMDs
Date: Sat, 19 Mar 2011 12:09:04 -0400
Message-ID: <m3pqpnt7mn.fsf@pullcord.laptop.org>
References: <203F41F6E33F954E8E8B02559FDC906F743176BFD2@modex01>
	<201103172255.51442.arnd@arndb.de>
	<alpine.DEB.2.00.1103181706450.6084@peruna>
	<201103191042.30718.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53549 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab1CSQMJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 19 Mar 2011 12:12:09 -0400
In-Reply-To: <201103191042.30718.arnd@arndb.de> (Arnd Bergmann's message of
	"Sat, 19 Mar 2011 10:42:30 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

Hi,

On Sat, Mar 19 2011, Arnd Bergmann wrote:
> Chris, do you prefer to leave the new export as EXPORT_SYMBOL
> along wiht the others or to use EXPORT_SYMBOL_GPL?

Let's just use EXPORT_SYMBOL_GPL() for all new exports, and leave the
older ones as they are.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
