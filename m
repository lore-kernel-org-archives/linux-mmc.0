From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] Minor MMC fixes
Date: Sat, 25 Jun 2011 18:54:56 -0400
Message-ID: <m2aad5frnj.fsf@bob.laptop.org>
References: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58190 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab1FYWzD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 25 Jun 2011 18:55:03 -0400
In-Reply-To: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Thu, 23 Jun 2011 13:40:25 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Thu, Jun 23 2011, Adrian Hunter wrote:
> Here are 4 minor fixes:
>
> Adrian Hunter (4):
>       mmc: block: switch card to User Data Area when removing the block driver
>       mmc: core: make erase timeout calculation allow for gated clock
>       mmc: queue: append partition subname to queue thread name
>       mmc: queue: bring discard_granularity/alignment into line with SCSI definitions

Thanks, will push these for 3.0.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
