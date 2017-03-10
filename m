From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v12 9/9] MAINTAINERS: Add entry for Cavium MMC driver
Date: Fri, 10 Mar 2017 14:25:07 +0100
Message-ID: <20170310132507.32025-10-jglauber@cavium.com>
References: <20170310132507.32025-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310132507.32025-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c265a5f..ead1e89 100644
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
+F:	drivers/mmc/host/cavium-*
+
 CAVIUM LIQUIDIO NETWORK DRIVER
 M:     Derek Chickles <derek.chickles@caviumnetworks.com>
 M:     Satanand Burla <satananda.burla@caviumnetworks.com>
-- 
2.9.0.rc0.21.g7777322
