From: Andrei Warkentin <andreiw@motorola.com>
Subject: CMD23 plumbing patchset.
Date: Tue, 26 Apr 2011 21:10:30 -0500
Message-ID: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:58950 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138Ab1D0CLE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 22:11:04 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3R2BTH6000109
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 22:11:29 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3R2AZaW029834
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 22:11:28 -0400 (EDT)
Received: by mail-gw0-f42.google.com with SMTP id 17so637045gwb.15
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 19:11:01 -0700 (PDT)
In-Reply-To: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This is the fourth version of the CMD23 plumbing and host driver support.

Changes:
1) Changes MMC white list to a black list.
2) Fixes two stupid bugs in tentative AutoCMD23 patch (sorry Arindam)

ToC:
[[v4] 1/5] MMC: Add/remove quirks conditional support.
[[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
[[v4] 3/5] MMC: Implement MMC_CAP_CMD23 for SDHCI.
[[v4] 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
[[v4] 5/5] MMC: SDHCI AutoCMD23 support.

A
