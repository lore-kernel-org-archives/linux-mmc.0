From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 0/4] mmc: sdhci-esdhc-imx: i.MX6 update
Date: Thu, 10 May 2012 11:33:15 +0200
Message-ID: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:51592 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab2EJJkZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 05:40:25 -0400
Received: from smtp2-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 43CFE2803F6
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:30:38 +0200 (CEST)
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta23.fe.bosch.de (Postfix) with ESMTP id E3EEF28C0200
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:29:51 +0200 (CEST)
Received: from localhost (vsgw3.fe.internet.bosch.com [10.4.98.16])
	by vsmta11.fe.internet.bosch.com (Postfix) with SMTP id AB7B743C0783
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:33:27 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Tony Lin <tony.lin@freescale.com>, RichardZhu <richard.zhu@linaro.org>, Philipp Ahmann <pahmann@de.adit-jv.com>, Eric Miao <eric.miao@linaro.org>

We need the following 4 patches to get SDHCI working on the i.MX6.

The first two patches add 8 bit and 1.8V support. Patches 3 + 4 are
workarounds for i.MX6 1.0 silicon hardware issues.

These patches are tested on the i.MX6 SabreLite board with kernel
3.4-rc6.

Please note that I'm not the author of these patches. And I'm no MMC
expert. So we will try to work on these patches, but might fail if
some deeper MMC knowledge might be necessary. Any help would be 
appreciated, then ;)

CC: Tony Lin <tony.lin@freescale.com>
CC: RichardZhu <richard.zhu@linaro.org>
CC: Philipp Ahmann <pahmann@de.adit-jv.com>
CC: Eric Miao <eric.miao@linaro.org>
