From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Resubmission
Date: Mon, 14 Mar 2011 23:01:46 -0400
Message-ID: <m37hc1rsrp.fsf@pullcord.laptop.org>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
	<20101116150022.GA27726@void.printf.net>
	<27884BED0E3C489C8849EE12A803F536@AN00536>
	<m3oc9pnt6g.fsf@pullcord.laptop.org>
	<4CE41BE3.1060806@elandigitalsystems.com>
	<m3oc9n241c.fsf@pullcord.laptop.org>
	<4CEA86D4.9050109@elandigitalsystems.com>
	<1295607004.1816.6.camel@apple-mac>
	<1299773604.1682.21.camel@apple-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46296 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab1CODE2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2011 23:04:28 -0400
In-Reply-To: <1299773604.1682.21.camel@apple-mac> (Tony Olech's message of
	"Thu, 10 Mar 2011 16:13:24 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 10 2011, Tony Olech wrote:
> Add a driver for Elan Digital System's VUB300 chip
> which is a USB connected SDIO/SDmem/MMC host controller.
> A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> computer to use SDIO/SD/MMC cards without the need for
> a directly connected, for example via PCI, SDIO host
> controller.
>
> Signed-off-by: Anthony F Olech <tony.olech@elandigitalsystems.com>

linux-mmc@ folks, any strong opinions on this driver?  My impression is
that it looks reasonable, but has some areas of being pretty far from
standard CodingStyle.  I'm leaning towards merging it as-is and then
working on incremental fixes; please yell if that sounds like a bad idea.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
