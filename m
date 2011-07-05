From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: OMAP HS-MMC: convert to dev_pm_ops broke hibernation
Date: Tue, 5 Jul 2011 17:02:59 +0200
Message-ID: <4E1327A3.4070900@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:51880 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab1GEPDi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jul 2011 11:03:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, madhu.cr@ti.com

Hi,

commit a791daa15305e7e549a418ef0ae6bc4b4580066e converted PM operations to use
dev_pm_ops. But this broke hibernation/suspend to disk :
- now there no state argument
- but there is one call back per state :
-- suspend/resume for s2ram
-- freeze/thaw poweroff/restore for s2disk

look like most of the mmc driver using dev_pm_ops got the same problem (only
jz4740_mmc define poweroff/restore)


Matthieu
