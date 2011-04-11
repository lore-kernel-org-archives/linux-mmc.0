From: John Calixto <john.calixto@modsystems.com>
Subject: mmc: Add ioctl to let userspace apps send ACMDs
Date: Mon, 11 Apr 2011 14:47:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104111424140.32082@peruna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:35058 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756007Ab1DKVrZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:47:25 -0400
Received: from [24.41.60.94] (helo=peruna)
	by elasmtp-galgo.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <john.calixto@modsystems.com>)
	id 1Q9Ox0-0005gW-3u
	for linux-mmc@vger.kernel.org; Mon, 11 Apr 2011 17:47:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Since this patch has gone through multiple revisions now, I thought I'd
list the changes in each revision:

- v4
    - replace postsleep udelay() with usleep_range()
    - add cmd_timeout_ms field for R1B commands

- v3
    - copy data from userspace before claiming host
    - break out copy from userspace into its own function
    - verify that caller has CAP_SYS_RAWIO
    - rename ``struct sd_ioc_cmd`` to ``struct mmc_ioc_cmd`` because it
      applies generally, not just to SD
    - make struct mmc_ioc_cmd the same between 32-bit and 64-bit to
      simplify compat_ioctl()
    - export include/linux/mmc/ioctl.h when you ``make headers_install``

- v2
    - make initialization of struct declarations match kernel style
    - only allow ioctl() on whole block device, not partition
    - remove extraneous printks
    - implement compat_ioctl()
    - remove version field from ``struct sd_ioc_cmd``

John
