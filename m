From: Andrew Morton <akpm@linux-foundation.org>
Subject: stalled mmc patches
Date: Tue, 29 Sep 2009 13:15:40 -0700
Message-ID: <20090929131540.27d72d52.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35421 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751826AbZI2UQm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 16:16:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <damm@opensource.se>, Paul Mundt <lethal@linux-sh.org>, Albert Herranz <albert_herranz@yahoo.es>


Guys, I'm still sitting on four patches which varius people have (or
had) objections to.  

Could we please revisit these and provide advice on how to proceed? 
Thanks.

http://userweb.kernel.org/~akpm/mmotm/broken-out/mmc-make-the-configuration-memory-resource-optional.patch
http://userweb.kernel.org/~akpm/mmotm/broken-out/tmio_mmc-optionally-support-using-platform-clock.patch
http://userweb.kernel.org/~akpm/mmotm/broken-out/sh-switch-migo-r-to-use-the-tmio-mmc-driver-instead-of-spi.patch

and

http://userweb.kernel.org/~akpm/mmotm/broken-out/sdio-recognize-io-card-without-powercycle.patch
