From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: MMC boot partitions support.
Date: Mon, 4 Apr 2011 06:52:32 -0500
Message-ID: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
References: <AANLkTik8pdawawB-7X2DkAemkGec4qVKsrZ4W8M1_Syt@mail.gmail.com>
	<1301919720-8511-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:37262 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab1DDLwf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 07:52:35 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34BqtVp005629
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 07:52:55 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34BpfoB005421
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 07:52:54 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so6015336wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 04:52:32 -0700 (PDT)
In-Reply-To: <1301919720-8511-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, Apr 4, 2011 at 7:22 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> Allows device MMC boot partitions to be accessed. MMC partitions
> are treated effectively as separate block devices on the same
> MMC card.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

+Chris
+Arnd

This version is different from the previous one in the following ways:
- Rebased on top reliable writes support (because it's in to make
merging easier) + modified MMC: enable TRIM/ERASE caps for SDHCI host
patch that I sent out earlier today
  (because I need to be able to set timeout appropriately for CMD6 and
have it honored by SDHCI)
- Fixes compile error with block support built as module (mmc_switch
wasn't exported)
- Let's mmc_switch be supplied a timeout value. Default of 0 does a
max timeout which is the only valid thing to do for register
modifications where the timeout is not specified by the JEDEC spec or
EXT_CSD values.
- Switching partition timeout is now honored (byte 199 of EXT_CSD)
- Fixes compile error with getting built on architectures where
SZ_128K isn't defined (most of them)
- Fixes naming as discussed - boot partitions are called mmcblkXbootY
- Fixes device parent/child relationship - added disks for boot
partitions are children of main mmc block disk
- Adds "force_ro" block device attribute, which is set by default to
"1" for boot partitions/
- Adds documentation.

Thanks,
A
