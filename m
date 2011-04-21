From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Thu, 21 Apr 2011 13:31:12 +0900
Message-ID: <4DAFB310.6030502@samsung.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
 <1302556424-21951-4-git-send-email-andreiw@motorola.com>
 <m31v0wcson.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9641 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab1DUEdZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 00:33:25 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJZ00C9XJBKIV80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 21 Apr 2011 13:33:23 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJZ00F5GJBNO3@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 21 Apr 2011 13:33:23 +0900 (KST)
In-reply-to: <m31v0wcson.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org, arnd@arndb.de

Hi Chris.

Chris Ball wrote:
> Hi Andrei,
> 
> On Mon, Apr 11 2011, Andrei Warkentin wrote:
>> Allows device MMC boot partitions to be accessed. MMC partitions
>> are treated effectively as separate block devices on the same
>> MMC card.
> 
> Booted this with a Sandisk SEM04G eMMC:
> 
> [    2.469921] mmcblk0boot0: mmc2:0001 SEM04G partition 1 1.00 MiB
> [    2.475905] mmcblk0boot1: mmc2:0001 SEM04G partition 2 1.00 MiB
> [    2.489403]  mmcblk0boot1: unknown partition table
> [    2.495921]  mmcblk0boot0: unknown partition table
> 
> I haven't set up any boot partitions explicitly, so I guess the two 1MiB
> boot partitions might be the factory-default setting.  Out of curiosity,
> does that match your experience with Sandisk eMMCs? 

in my experience, Sandisk set up boot partition with each 1MiB. (default setting)

Regards,
Jaehoon Chung

> 
> - Chris.

