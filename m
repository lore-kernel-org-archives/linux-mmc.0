From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Mon, 24 Sep 2012 14:38:34 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708090865@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
	<201209211233.54545.arnd@arndb.de>	<50607A5A.3060103@freescale.com>
	<201209241317.32425.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:39208
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752410Ab2IXOim convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Sep 2012 10:38:42 -0400
In-Reply-To: <201209241317.32425.arnd@arndb.de>
Content-Language: en-US
Content-ID: <4BB0BE090B52BE40AA8F66E5A81F6763@mgd.freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, Gala Kumar-B11780 <B11780@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>Lan Chunhe-B25806 <B25806@freescale.com>

On Mon, Sep 24, 2012 at 8:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> static inline void mmc_delay(unsigned int ms)
>> {
>>           msleep(ms);
>> }
>
> That would be my preferred choice, unless someone has specific issues with this.

If we're going to do that, then just get rid of mmc_delay and replace
all calls to it with msleep().  Why bother with the inline function?
There's nothing really MMC-specific about it.

-- 
Timur Tabi
Linux kernel developer at Freescale
