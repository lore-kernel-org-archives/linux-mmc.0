From: Chris Ball <cjb@laptop.org>
Subject: Re: MMC maintainer
Date: Fri, 10 Sep 2010 21:14:19 +0100
Message-ID: <20100910201419.GA2623@void.printf.net>
References: <m3lj7avpk4.fsf@pullcord.laptop.org> <20100909114750.09214854.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55546 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938Ab0IJUOU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Sep 2010 16:14:20 -0400
Content-Disposition: inline
In-Reply-To: <20100909114750.09214854.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

Hi Andrew,

On Thu, Sep 09, 2010 at 11:47:50AM -0700, Andrew Morton wrote:
> These things can happen in parallel - get the tree set up, get it into
> linux-next, start putting patches in it.  If I see patches turn up in
> linux-next which I already have, I just drop them.  If I find I'm
> holding patches which should be in the mmc tree but which aren't, I
> send them to you.

Thanks -- have created the tree, added its mmc-next branch to -next, and
started pushing to it (location below).  Here's a MAINTAINERS update:

Subject: mmc: add MAINTAINERS entry

Add myself as maintainer.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 MAINTAINERS |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9800de5..42f86da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3906,8 +3906,10 @@ S:	Supported
 F:	drivers/mfd/
 
 MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
-S:	Orphan
+M:	Chris Ball <cjb@laptop.org>
 L:	linux-mmc@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
+S:	Maintained
 F:	drivers/mmc/
 F:	include/linux/mmc/
 
@@ -5078,8 +5080,10 @@ S:	Maintained
 F:	drivers/mmc/host/sdricoh_cs.c
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
-S:	Orphan
+M:	Chris Ball <cjb@laptop.org>
 L:	linux-mmc@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
+S:	Maintained
 F:	drivers/mmc/host/sdhci.*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE, OPEN FIRMWARE BINDINGS (SDHCI-OF)
-- 
1.7.0.1

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
