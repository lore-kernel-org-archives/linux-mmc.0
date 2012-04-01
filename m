From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] atmel-mci device tree support
Date: Sat, 31 Mar 2012 23:49:19 -0400
Message-ID: <87iphkm7r4.fsf@laptop.org>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58718 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291Ab2DADtO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 31 Mar 2012 23:49:14 -0400
In-Reply-To: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
	(ludovic desroches's message of "Wed, 21 Mar 2012 19:03:10 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Arnd Bergmann <arnd@arndb.de>

Hi,

On Wed, Mar 21 2012, ludovic.desroches@atmel.com wrote:
> Hi,
>
> This patch-set adds device tree support for atmel-mci.

Please can you resend after syncing up with Arnd's suggestions in:
   http://thread.gmane.org/gmane.linux.kernel.samsung-soc/9216/focus=13659

(It looks like the main difference is just s/cd-invert;/cd-inverted;/.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
