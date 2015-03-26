From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 0/4] mmc: sdhci: Support maximum DMA latency request
 via PM QoS
Date: Thu, 26 Mar 2015 10:51:17 +0100
Message-ID: <20150326095117.GA637@amd>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
 <20150325194259.GB381@amd>
 <5513C352.2080208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47739 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbCZJvU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2015 05:51:20 -0400
Content-Disposition: inline
In-Reply-To: <5513C352.2080208@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 2015-03-26 10:29:06, Adrian Hunter wrote:
> On 25/03/15 21:43, Pavel Machek wrote:
> > Hi!
> > 
> >> Here are some patches to address an issue with SDHCI
> >> in Intel Baytrail. Intel Baytrail has been observed
> >> sometimes to hang if host controllers are using DMA
> >> while deep C-states are used. Workaround that by
> > 
> > I wonder if there is more information on this one? I see your address
> > is "@intel". For example which C states are affected, and if there's
> 
> The problem starts at C6 - I will add that to the commit message.

Better find a place for a comment in code, too...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
