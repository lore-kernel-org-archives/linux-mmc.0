From: John Calixto <john.calixto@modsystems.com>
Subject: v7 changelog for mmc ioctl patch
Date: Thu, 21 Apr 2011 17:41:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104211735290.3919@peruna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:33334 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753960Ab1DVAlu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 20:41:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

change history for this patch:

- v7
    - simplify 32-bit/64-bit buffer pointer portability
    - add pad member to struct mmc_ioc_cmd so its size is the same
      when built for either 32-bit or 64-bit.
    - register ``0xB3`` in Documentation/ioctl/ioctl-number.txt

- v6
    - refix 32+64 compat pointer for better portability
    - copy userspace pointer *before* using
    - apply upper limit to data buffer size
    - add flag to allow normal CMD opcodes as well as ACMD opcodes
    - remove unnecessary mutex grab

- v5
    - fix 32-bit compiler warning about the 32+64 compat pointer

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
