From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] Add support for JMicron chip with UHS-I function
Date: Thu, 04 Aug 2011 09:12:46 -0400
Message-ID: <m2d3gl5nht.fsf@bob.laptop.org>
References: <201108040731.p747Vp13002998@jmr105.jmicron.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49883 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206Ab1HDNN1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Aug 2011 09:13:27 -0400
In-Reply-To: <201108040731.p747Vp13002998@jmr105.jmicron.com> (Aries Lee's
	message of "Thu, 4 Aug 2011 15:31:48 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aries Lee <arieslee@jmicron.com>
Cc: linux-mmc@vger.kernel.org, 'Andrei Warkentin' <andreiw@motorola.com>, 'Adrian Hunter' <adrian.hunter@intel.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Ohad Ben-Cohen' <ohad@wizery.com>, 'Philip Rakity' <prakity@marvell.com>

Hi Aries,

On Thu, Aug 04 2011, Aries Lee wrote:
> 1. Force to assign some property at sdhci_add_host() function.
>
> 2. Jmicron doesn't support CMD19, install of tuning command, Jmicron run a
> procedure to tune the clock delay, command delay and data delay. Actually I
> want to define a quirks such like "SDHCI_QUIRK_NONSTANDARD_TUNE", but it run
> out the quirks definition. So I share SDHCI_QUIRK_UNSTABLE_RO_DETECT
> temporarily, looking for anyone provide any suggestion :-)
>
> The tuning procedure is very simple -- try to get card status and read data
> under totally 32 different clock delay setting, and record the result those
> Operations, then choose a proper delay setting from this result.
>
> 3. Jmicron using a nonstandard clock setting. this patch implement a
> function to set host clock by this nonstandard way.
>
> 4. The tuning procedure is put in host/sdhci.c temporarily, I am not sure it
> is a proper location or not, any suggestion?
>
> Signed-off-by: arieslee <arieslee@jmicron.com>

This patch is still corrupt.

Before sending it to us, you should send it to yourself, and check that
it can be applied with "git am" or "patch -p1".

Also, when sending a new version of a patch, please include a changelog
that explains what is different about the new version.  If it's just a
resent version of the old patch, you can write that.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
