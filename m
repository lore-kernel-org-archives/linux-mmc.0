From: Andrei Warkentin <andreiw@motorola.com>
Subject: CMD23 plumbing and support patchset.
Date: Sat, 16 Apr 2011 05:40:53 -0500
Message-ID: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:59300 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1DPKCf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 06:02:35 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3GA0hSY028811
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:00:43 -0400 (EDT)
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com [209.85.218.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3GA0gtv028808
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:00:43 -0400 (EDT)
Received: by yib12 with SMTP id 12so2355922yib.15
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 03:02:33 -0700 (PDT)
In-Reply-To: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arindam.nath@amd.com

Dear Group,

This is the third version of the CMD23 plumbing and host driver support
patch set.

Changes:
1) CMD23 support (used for features such as reliable writes) is decoupled
   from general multiblock trans through use of a quirk for affected cards.
2) Newer Sandisk MMC products are whitelisted along with some known good ones. All other
   MMC products do not use CMD23 for general transfers (seems like safest choice for now).
   SD products unaffected.
3) Small fix for interaction with Auto-CMD12 (and resulting cleanup of Auto-CMD12 SDHCI capability)
4) Completely experimental (and untested) Auto-CMD23 support, for Arindam to look over (Hi!).

Table of Contents:
[patchv3 1/5] MMC: Add/remove quirks conditional support.
[patchv3 2/5] MMC: Use CMD23 for multiblock transfers when we can.
[patchv3 3/5] MMC: Implement MMC_CAP_CMD23 for SDHCI.
[patchv3 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
[patchv3 5/5] MMC: SDHCI AutoCMD23 support.

Thanks,
A
