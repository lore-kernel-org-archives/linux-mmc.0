From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Block: Ensure hardware partitions don't mess with mmcblk device naming.
Date: Fri, 22 Apr 2011 18:34:58 -0400
Message-ID: <m3ei4tykx9.fsf@pullcord.laptop.org>
References: <m3ipu76srt.fsf@pullcord.laptop.org>
	<1303443973-1608-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53259 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753659Ab1DVWa7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 18:30:59 -0400
In-Reply-To: <1303443973-1608-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Thu, 21 Apr 2011 22:46:13 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Andrei,

On Thu, Apr 21 2011, Andrei Warkentin wrote:
> With the hardware partitions support (which represent additional logical devices
> present on MMC), devidx does not correspond with index used to form
> /dev/mmcblkX names. So use an additional allocated index for device names.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Thanks, pushed to mmc-next for .40, looks good:

[  659.127819] mmc0: new high speed SDHC card at address d555
[  659.141704] mmcblk1: mmc0:d555 SD04G 3.79 GiB 
[  659.147453]  mmcblk1: p1

(I re-wrapped the commit message and comment to <80 chars.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
