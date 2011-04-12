From: John Calixto <john.calixto@modsystems.com>
Subject: v5 changelog - mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 12 Apr 2011 15:52:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104121544380.8483@peruna>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-167213693-1302648734=:8483"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:47963 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317Ab1DLWxF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 18:53:05 -0400
Content-ID: <alpine.DEB.2.00.1104121552510.8483@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-167213693-1302648734=:8483
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1104121552511.8483@peruna>

A small fix for a compiler warning.  Thanks to Micha=B3 Miros=B3aw for
suggesting the solution!

Patch history below:

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
---1463811328-167213693-1302648734=:8483--
