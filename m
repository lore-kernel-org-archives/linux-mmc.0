From: Andrei Warkentin <andreiw@motorola.com>
Subject: MMC partitions support (4th revision)
Date: Tue, 22 Mar 2011 16:11:39 -0500
Message-ID: <1300828300-8677-1-git-send-email-andreiw@motorola.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:49772 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab1CVU37 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 16:29:59 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2MKUF6v027192
	for <linux-mmc@vger.kernel.org>; Tue, 22 Mar 2011 16:30:15 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2MKRQq7025787
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 22 Mar 2011 16:30:15 -0400 (EDT)
Received: by mail-gy0-f170.google.com with SMTP id 11so3639331gyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 22 Mar 2011 13:29:56 -0700 (PDT)
In-Reply-To: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This is the 4th iteration of the MMC partitions support, which also adds
boot partition support and slight cleanup of probe/remove/issue_rq code.

I've rebased this on top of linux-next, but I haven't run tested because
linux-next doesn't have support for my platform yet. Tested on K36. Can anyone try :)?

