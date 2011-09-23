From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] mmc: block: support no access to boot partitions
Date: Fri, 23 Sep 2011 14:06:19 -0400
Message-ID: <m2ty83w2uc.fsf@bob.laptop.org>
References: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36087 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1IWSG2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Sep 2011 14:06:28 -0400
In-Reply-To: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Fri, 23 Sep 2011 12:48:19 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Fri, Sep 23 2011, Adrian Hunter wrote:
> Hi
>
> Here is a minor fix and a patch to support no access to boot partitions.
>
> Adrian Hunter (2):
>       mmc: block: fix boot partition switch error path
>       mmc: block: support no access to boot partitions

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
