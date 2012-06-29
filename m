From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH v2 0/2] Fixes for tuning stuffs
Date: Fri, 29 Jun 2012 16:17:30 +0800
Message-ID: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [213.199.154.208] ([213.199.154.208]:25151 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752467Ab2F2ISj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 04:18:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

v2:
v1 mistakenly removed the line del_timer_sync(&host->timer) in
sdhci_remove_host, fix this by adding back the code.

v1:
The following 2 patches fixed a bug related the tuning stuffs and
refactored the code to make it simpler and easier to read and understand.

-- 
1.7.11.1.3.g4c8a9db


