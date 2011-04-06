From: Andrei Warkentin <andreiw@motorola.com>
Subject: Boot partition support patch set.
Date: Tue,  5 Apr 2011 20:09:49 -0500
Message-ID: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:39842 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1DFAaD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 20:30:03 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360SIQi015596
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:28:18 -0400 (EDT)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360SIiV015585
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:28:18 -0400 (EDT)
Received: by gxk27 with SMTP id 27so635567gxk.15
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 17:30:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org

This is the latest version of the MMC device partition support.
It relies on a few other changes that were discussed recently.

Thanks,
A

TOC:
 [PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
 [PATCH 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
 [PATCH 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
 [PATCH 4/4] MMC: MMC boot partitions support.
