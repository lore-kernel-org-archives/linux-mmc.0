From: Chris Ball <cjb@laptop.org>
Subject: Re: Shutdown regression due to mmc workqueue/locking changes
Date: Wed, 30 Oct 2013 21:32:47 +0000
Message-ID: <86iowemolc.fsf@void.printf.net>
References: <5271749C.2000206@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46417 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab3J3Vcw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Oct 2013 17:32:52 -0400
In-Reply-To: <5271749C.2000206@wwwdotorg.org> (Stephen Warren's message of
	"Wed, 30 Oct 2013 15:05:32 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jeremie Samuel <jeremie.samuel.ext@parrot.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Wed, Oct 30 2013, Stephen Warren wrote:
> When I run "shutdown -h now" in next-20131030, I get a hung task.
>
> git bisect shows that the first problem that shows up is due to 35a8fca
> "mmc: sdhci: Turn tuning timeout timer into delayed work", which yields
> the following crash immediately that poweroff happens:

Thanks -- combined with Olof's report, this sounds like a good reason
to drop the patchset for this cycle and try again later.  I'll do that.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
