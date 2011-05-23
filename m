From: Andrei Warkentin <andreiw@motorola.com>
Subject: CMD23 plumbing patchset.
Date: Mon, 23 May 2011 15:06:34 -0500
Message-ID: <1306181199-13915-1-git-send-email-andreiw@motorola.com>
References: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:58327 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab1EWTdT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 15:33:19 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJXnHI024134
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:33:49 -0400 (EDT)
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com [74.125.83.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJXDQc023889
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:33:49 -0400 (EDT)
Received: by mail-pv0-f170.google.com with SMTP id 16so3429427pvg.15
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 12:33:17 -0700 (PDT)
In-Reply-To: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

This is the 6th version of the patchset. Made sure that Auto-CMD(12|23)
is called *_AUTO_CMD* instead of *_ACMD*.

Also removed an unnecessary check for v3 spec, since one is already in place
after Arindam's patches.

ToC:
[v6 1/5] MMC: Add/remove quirks conditional support.
[v6 2/5] MMC: Use CMD23 for multiblock transfers when we can.
[v6 3/5] MMC: Implement MMC_CAP_CMD23 for SDHCI.
[v6 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
[v6 5/5] MMC: SDHCI AutoCMD23 support.

A
