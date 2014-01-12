From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 0/2] add support of O2Mirco/BayHubTech SD hosts
Date: Sun, 12 Jan 2014 16:28:24 +0000
Message-ID: <86wqi5dv13.fsf@void.printf.net>
References: <1387376619-8050-1-git-send-email-adam.lee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57924 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbaALQ2a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 12 Jan 2014 11:28:30 -0500
In-Reply-To: <1387376619-8050-1-git-send-email-adam.lee@canonical.com> (Adam
	Lee's message of "Wed, 18 Dec 2013 22:23:37 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adam Lee <adam.lee@canonical.com>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Guo <peter.guo@bayhubtech.com>

Hi, thanks for doing this,

On Wed, Dec 18 2013, Adam Lee wrote:
> BugLink: http://bugs.launchpad.net/bugs/1239938
>
> Card readers on Lenovo ThinkPad W540, Dell Latitude E5440 and Dell Latitude
> E6540 don't work without this patch.
>
> Thanks to Chris Ball's suggestion, I create new files but not add hundreds
> lines of code into the main source file.

Pushed to mmc-next for 3.14, thanks.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
