From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: sdhci: Allow for long command timeouts
Date: Mon, 20 Jan 2014 15:36:09 +0000
Message-ID: <86iote4qdy.fsf@void.printf.net>
References: <1384416980-15850-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58249 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbaATPgN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jan 2014 10:36:13 -0500
In-Reply-To: <1384416980-15850-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Thu, 14 Nov 2013 10:16:20 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

Hi Adrian,

On Thu, Nov 14 2013, Adrian Hunter wrote:
> The driver has a timer with a 10 second
> timeout to catch devices that stop responding.
> However it is possible for commands to take
> even longer than that.  Change the timer
> timeout to reflect the command timeout.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, pushed to mmc-next for 3.14, sorry for the delay.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
