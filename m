From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: Block: Ensure hardware partitions don't mess with
 mmcblk device naming.
Date: Thu, 21 Apr 2011 22:50:08 -0500
Message-ID: <BANLkTi=R6NxTp=YaPAAQxOzDOpX9AwDkRA@mail.gmail.com>
References: <m3ipu76srt.fsf@pullcord.laptop.org>
	<1303443973-1608-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:40299 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1DVDuL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 23:50:11 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3M3oZSJ028377
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 23:50:35 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3M3oIIp028290
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 23:50:35 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so332151wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 20:50:08 -0700 (PDT)
In-Reply-To: <1303443973-1608-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

On Thu, Apr 21, 2011 at 10:46 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> With the hardware partitions support (which represent additional logical devices
> present on MMC), devidx does not correspond with index used to form
> /dev/mmcblkX names. So use an additional allocated index for device names.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

That should be good :-/. Sorry.

A
