From: Ravikumar Kattekola <rk@ti.com>
Subject: Enabling MMC BKOPs in kernel based on host caps
Date: Mon, 3 Oct 2016 16:13:04 +0530
Message-ID: <1475491384-15818-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34027 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbcJCKmT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2016 06:42:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id u93AgILW029923
        for <linux-mmc@vger.kernel.org>; Mon, 3 Oct 2016 05:42:18 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id u93AgHBg031755
        for <linux-mmc@vger.kernel.org>; Mon, 3 Oct 2016 05:42:17 -0500
Received: from uda0131654.dhcp.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])      by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id
 u93AgFH2008320 for <linux-mmc@vger.kernel.org>; Mon, 3 Oct 2016 05:42:16
 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,
	I’ve seen an eMMC failure due to pending background operations on a certain OMAP device since bkops enable bit was not set.
Further investigation showed me that someone already posted patch to enable Background operations in kernel  based on a host capability check (Caps2 & BK_OPS_EN)
but was turned down quoting that it should be enabled from user space using mmc-utils.

Enabling this would add one additional check for exception event in the response R1 or R1B (only on hosts that explicitly set BK_OPS_EN in caps2).
But not enabling this could lead to a system failure especially when the Filesystem is on eMMC and the card stops responding due to pending critical bkops.

I would like to ask for expert opinion on ‘why is it a bad idea to enable bkops in kernel?’
It’s a one time programmable bit but if it helps in keeping system functional why not do it?
I haven’t measured the performance impact but I don’t see a reason for major drop because the frequency of critical bkops events would be less.

Regards,
RK 
