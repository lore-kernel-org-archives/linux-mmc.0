From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] maximum discard size
Date: Fri, 15 Jul 2011 21:59:19 +0300
Message-ID: <4E208E07.2050704@intel.com>
References: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16420 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab1GOS7Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Jul 2011 14:59:24 -0400
In-Reply-To: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>

On 28/06/2011 5:16 p.m., Adrian Hunter wrote:
> Hi
>
> Here is a patch that sets a maximum discard size for host controllers
> that cannot manage large timeouts.  And another patch putting it into
> use for shdci.

Can this be applied?

> Adrian Hunter (2):
>        mmc: queue: let host controllers specify maximum discard timeout
>        mmc: sdhci: specify maximum discard timeout
>
>   drivers/mmc/card/queue.c |   33 ++++++++++++++------
>   drivers/mmc/core/core.c  |   76 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/mmc/host/sdhci.c |    5 +++
>   include/linux/mmc/core.h |    1 +
>   include/linux/mmc/host.h |    1 +
>   5 files changed, 106 insertions(+), 10 deletions(-)
>
> Regards
> Adrian Hunter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

