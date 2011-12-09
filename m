From: <r66093@freescale.com>
Subject: [PATCH 0/4] get_cd callback to detect the card
Date: Fri, 9 Dec 2011 10:53:35 +0800
Message-ID: <1323399215-28606-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:20761
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751592Ab1LIDib (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 22:38:31 -0500
Received: from mail152-va3 (localhost [127.0.0.1])	by
 mail152-va3-R.bigfish.com (Postfix) with ESMTP id 7FA5E2001C0	for
 <linux-mmc@vger.kernel.org>; Fri,  9 Dec 2011 03:38:30 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.252])	by
 mail152-va3.bigfish.com (Postfix) with ESMTP id 53988540049	for
 <linux-mmc@vger.kernel.org>; Fri,  9 Dec 2011 03:38:29 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

According to the comment/suggestion of the kindly guys from linux-mmc,
I added the get_cd in special platform code, and enable the controller clock
in the special platform, instead of the core code.
but I keep the codes to check the f_init, because it is called not only by
mmc_rescan_try_freq, but also by mmc_power_restore_host and mmc_resume_host.

Therefore, only 4 patches will be sent to list to review.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>

