From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 0/2] SD current limit setting fix
Date: Tue, 3 Jul 2012 14:16:10 +0800
Message-ID: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:21305
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753515Ab2GCGQo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 02:16:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

The following 2 patches fix setting of SD current limit

Aaron Lu (2):
  mmc: core: Simplify and fix for SD switch processing
  mmc: sd: Fix sd current limit setting

 drivers/mmc/core/sd.c    | 144 +++++++++++++++++++++++------------------------
 drivers/mmc/host/sdhci.c |  28 +++++++--
 include/linux/mmc/host.h |  16 ++++--
 3 files changed, 105 insertions(+), 83 deletions(-)

-- 
1.7.11.1.3.g4c8a9db


