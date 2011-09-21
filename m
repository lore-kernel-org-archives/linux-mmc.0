From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/5] mmc: add eMMC hardware reset support
Date: Wed, 21 Sep 2011 14:37:16 -0400
Message-ID: <m2fwjp3foj.fsf@bob.laptop.org>
References: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37844 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab1IUShT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:37:19 -0400
In-Reply-To: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 29 Aug 2011 16:42:10 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Mon, Aug 29 2011, Adrian Hunter wrote:
> Here are some patches to add eMMC hardware reset support.
>
> Adrian Hunter (5):
>       mmc: add eMMC hardware reset support
>       mmc: sdhci: add eMMC hardware reset support
>       mmc: sdhci-pci: add eMMC hardware reset support
>       mmc: mmc-test: add eMMC hardware reset test
>       mmc: block: add eMMC hardware reset support

Thanks, all pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
