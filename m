From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v13 6/6] MAINTAINERS: Add entry for Cavium MMC driver
Date: Thu, 30 Mar 2017 17:31:28 +0200
Message-ID: <20170330153128.22842-7-jglauber@cavium.com>
References: <20170330153128.22842-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33320 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934346AbdC3PcC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 11:32:02 -0400
In-Reply-To: <20170330153128.22842-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c776906..25c3009 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3041,6 +3041,14 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-octeon*
 F:	drivers/i2c/busses/i2c-thunderx*
 
+CAVIUM MMC DRIVER
+M:	Jan Glauber <jglauber@cavium.com>
+M:	David Daney <david.daney@cavium.com>
+M:	Steven J. Hill <Steven.Hill@cavium.com>
+W:	http://www.cavium.com
+S:	Supported
+F:	drivers/mmc/host/cavium*
+
 CAVIUM LIQUIDIO NETWORK DRIVER
 M:     Derek Chickles <derek.chickles@caviumnetworks.com>
 M:     Satanand Burla <satananda.burla@caviumnetworks.com>
-- 
2.9.0.rc0.21.g7777322

