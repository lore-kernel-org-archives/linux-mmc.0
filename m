From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: expose RPMB partition only for CMD23 capable host
Date: Mon, 28 Jan 2013 17:28:45 -0500
Message-ID: <87vcah54de.fsf@laptop.org>
References: <1359113430-10951-1-git-send-email-balajitk@ti.com>
	<510277AD.20907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49896 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755155Ab3A1W3W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Jan 2013 17:29:22 -0500
In-Reply-To: <510277AD.20907@ti.com> (Peter Ujfalusi's message of "Fri, 25 Jan
	2013 13:16:45 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, loic.pallardy-ext@stericsson.com

Hi,

On Fri, Jan 25 2013, Peter Ujfalusi wrote:
> On 01/25/2013 12:30 PM, Balaji T K wrote:
>> SET_BLOCK_COUNT CMD23 is needed for all access to RPMB partition.
>> If block count is not set by CMD23, all subsequent read/write commands
>> fail as per eMMC specification. So, If the host does not support CMD23,
>> do not expose RPMB partition.
>> 
>> Accessing RPMB partition can cause hang / huge delay
>> for host which do not support CMD23.
>
> Can this patch make it's way to 3.8? Without this patch my OMAP4 board's eMMC
> is not accessible causing blkid (via udev) to time out and slowing down the
> boot process.
>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
