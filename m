From: Chris Ball <cjb@laptop.org>
Subject: [Bug 35002] New: SDHC memory card causes divide error: 0000 [#1] PREEMPT SMP
Date: Thu, 12 May 2011 11:32:18 -0400
Message-ID: <m339kkylx9.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34235 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756164Ab1ELP34 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2011 11:29:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, s.jansen@gmail.com

Forwarding to linux-mmc@.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 35002] New: SDHC memory card causes divide error: 0000 [#1]
 PREEMPT SMP

https://bugzilla.kernel.org/show_bug.cgi?id=35002

           Summary: SDHC memory card causes divide error: 0000 [#1]
                    PREEMPT SMP
           Product: Drivers
           Version: 2.5
    Kernel Version: 2.6.38.6
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: MMC/SD
        AssignedTo: drivers_mmc-sd@kernel-bugs.osdl.org
        ReportedBy: s.jansen@gmail.com
        Regression: No


Created an attachment (id=57592)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=57592)
Full kernel log from boot

When inserting a sdhc memory card or when coming out of suspend kernel crashesh
with divide error: 0000 [#1] PREEMPT SMP.

Please see full log and trace for details

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
