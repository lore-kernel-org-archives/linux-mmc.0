From: Andrei Warkentin <andreiw@motorola.com>
Subject: MMC/eMMC partitioning support.
Date: Sat, 19 Mar 2011 06:18:10 -0500
Message-ID: <1300533491-2378-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:40481 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab1CSKgC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Mar 2011 06:36:02 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2JAaHkh022970
	for <linux-mmc@vger.kernel.org>; Sat, 19 Mar 2011 06:36:17 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2JAaGm8022967
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 19 Mar 2011 06:36:16 -0400 (EDT)
Received: by gyb11 with SMTP id 11so2790090gyb.15
        for <linux-mmc@vger.kernel.org>; Sat, 19 Mar 2011 03:35:58 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

MMC devices can have boot partitions, as well as a non-replayable
memory block and some general purpose partitions present. As of the moment,
these are not accessible from Linux. I'm sending a patch for comments and review to enable
the boot partitions.

The MMC partitions are effectively separate devices from the default-accessible user area
partition, hence, the extra partitions are exposed as separate block devices.

TOC:
[RFC] MMC: MMC boot partitions support.

Thanks,
A
