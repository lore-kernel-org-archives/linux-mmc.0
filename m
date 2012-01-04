From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: sdhci max_blk_size
Date: Wed, 4 Jan 2012 16:01:07 +0100
Message-ID: <4F0469B3.9080400@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:59323 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab2ADPK5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Jan 2012 10:10:57 -0500
Received: from ONYX.xi-lite.lan (unknown [193.34.35.244])
	by co202.xi-lite.net (Postfix) with ESMTPS id C48612602B5
	for <linux-mmc@vger.kernel.org>; Wed,  4 Jan 2012 16:01:15 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

our controller set "Max Block Length" to 3 (4096 byte), but the linux driver
ignore this value [1].

Is there any reason to do that .
Or it is code that was written with an older sdhci spec, and we can ignore this
check today.



Matthieu

PS : please keep me in CC.

[1]
if (mmc->max_blk_size >= 3) {
            pr_warning("%s: Invalid maximum block size, "
                "assuming 512 bytes\n", mmc_hostname(mmc));
            mmc->max_blk_size = 0;
        }
