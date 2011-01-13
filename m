From: Andrew Morton <akpm@linux-foundation.org>
Subject: drivers/mmc/host/sdhci-of-core.c on sparc64
Date: Thu, 13 Jan 2011 15:10:33 -0800
Message-ID: <20110113151033.dbfd7524.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44996 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752187Ab1AMXLZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jan 2011 18:11:25 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0DNAX1P026814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Thu, 13 Jan 2011 15:10:33 -0800
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id p0DNAX7S006213
	for <linux-mmc@vger.kernel.org>; Thu, 13 Jan 2011 15:10:33 -0800
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

drivers/mmc/host/sdhci-of-core.c:24:25: asm/machdep.h: No such file or directory
drivers/mmc/host/sdhci-of-core.c: In function `sdhci_of_wp_inverted':
drivers/mmc/host/sdhci-of-core.c:115: error: implicit declaration of function `machine_is'

That code's been there for a while.  Did someone change Kconfig?
