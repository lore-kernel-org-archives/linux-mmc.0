From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/5] mmc: add eMMC hardware reset support
Date: Wed, 21 Sep 2011 15:16:55 -0400
Message-ID: <m2ipol1za0.fsf@bob.laptop.org>
References: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
	<1314625335-11638-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59191 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab1IUTQ7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 15:16:59 -0400
In-Reply-To: <1314625335-11638-2-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 29 Aug 2011 16:42:11 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Mon, Aug 29 2011, Adrian Hunter wrote:
> +	host->ios.ddr = MMC_SDR_MODE;

This doesn't build, because the ddr field no longer exists in the ios
struct, as of 4c4cb171 and 7fd781e8f -- we're using ios.timing instead
now.  I'll modify your patch to remove this line completely, let me know
if you disagree.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
