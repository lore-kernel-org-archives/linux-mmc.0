From: Andrei Warkentin <andreiw@motorola.com>
Subject: CMD23 plumbing patchset
Date: Thu, 19 May 2011 16:46:25 -0500
Message-ID: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:46141 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1ESVMq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 17:12:46 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4JLAII2001022
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:10:19 -0400 (EDT)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4JL712i029350
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:10:18 -0400 (EDT)
Received: by mail-gx0-f170.google.com with SMTP id 27so1476185gxk.15
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 14:12:38 -0700 (PDT)
In-Reply-To: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

This is the fifth version of the CMD23 plumbing and host driver support.

Changes:
- rebased on top of latest mmc-next
- have a tested-by by Arindam

ToC:
[v5 1/5] MMC: Add/remove quirks conditional support.
[v5 2/5] MMC: Use CMD23 for multiblock transfers when we can.
[v5 3/5] MMC: Implement MMC_CAP_CMD23 for SDHCI.
[v5 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
[v5 5/5] MMC: SDHCI AutoCMD23 support.

Thanks,
A
