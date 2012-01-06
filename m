From: <r66093@freescale.com>
Subject: [PATCH 0/1] new version workaround for FSL's eSDHC controller
Date: Fri, 6 Jan 2012 13:33:12 +0800
Message-ID: <1325827997-27490-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:3028
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751840Ab2AFGYE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jan 2012 01:24:04 -0500
Received: from mail144-ch1 (localhost [127.0.0.1])	by
 mail144-ch1-R.bigfish.com (Postfix) with ESMTP id 0E67F403B8	for
 <linux-mmc@vger.kernel.org>; Fri,  6 Jan 2012 06:24:03 +0000 (UTC)
Received: from CH1EHSMHS017.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail144-ch1.bigfish.com (Postfix) with ESMTP id
 E333A2A0042	for <linux-mmc@vger.kernel.org>; Fri,  6 Jan 2012 06:24:00 +0000
 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

The below patches are the workaround for FSL's eSDHC controller.
the patches (3/5, 4/5, 5/5) are modified based on Chris's hook patch,
the other patches (1/5, 2/5) have no any change.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>

