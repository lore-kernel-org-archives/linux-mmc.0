From: Chris Ball <cjb@laptop.org>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Wed, 20 Apr 2011 21:13:44 -0400
Message-ID: <m31v0wcson.fsf@pullcord.laptop.org>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38603 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab1DUBJf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2011 21:09:35 -0400
In-Reply-To: <1302556424-21951-4-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Mon, 11 Apr 2011 16:13:44 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

Hi Andrei,

On Mon, Apr 11 2011, Andrei Warkentin wrote:
> Allows device MMC boot partitions to be accessed. MMC partitions
> are treated effectively as separate block devices on the same
> MMC card.

Booted this with a Sandisk SEM04G eMMC:

[    2.469921] mmcblk0boot0: mmc2:0001 SEM04G partition 1 1.00 MiB
[    2.475905] mmcblk0boot1: mmc2:0001 SEM04G partition 2 1.00 MiB
[    2.489403]  mmcblk0boot1: unknown partition table
[    2.495921]  mmcblk0boot0: unknown partition table

I haven't set up any boot partitions explicitly, so I guess the two 1MiB
boot partitions might be the factory-default setting.  Out of curiosity,
does that match your experience with Sandisk eMMCs? 

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
