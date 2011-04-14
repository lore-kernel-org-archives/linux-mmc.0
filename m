From: John Calixto <john.calixto@modsystems.com>
Subject: v6 changelog for mmc ioctl patch
Date: Wed, 13 Apr 2011 17:34:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104131713570.15392@peruna>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1023074918-1302741275=:15392"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net ([209.86.89.66]:50166
	"EHLO elasmtp-spurfowl.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757116Ab1DNAei (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 20:34:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1023074918-1302741275=:15392
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

The changes in this version are mostly to address Arnd's comments on v4.

Arnd, I added a flag to allow the caller to select between normal CMDs
and ACMDs.  This really makes it a generic passthrough.  However, I only
tested a few commands to see that passthrough was working.  I did not
try any advanced handshaking CMDs.  Hopefully this generic passthrough
is more useful to you than previous incarnations.

I chose not to create higher-level ioctl operations specifically for the
security functions because they don't really buy us anything.  At most,
I could make a function for each security opcode that would specify the
numeric opcode directly (instead of having it come from userspace).  On
the back end, all of these functions would have the same functionality
of packing the opcode and arguments into the appropriate structures,
then issuing the request - essentially the same behaviour as my current
mmc_blk_ioctl_cmd().  The "higher-level" then just becomes an opcode
filter, and that was already deemed to be undesirable by Andrei and
Micha=B3 in the v2 thread.  As I explained in the past, I can't implement
any more of the security functionality in the kernel than that.

Anyway, here's the full patch history:

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
---1463811328-1023074918-1302741275=:15392--
