From: Sachin Nikam <Snikam@nvidia.com>
Subject: RE: [Bug 35002] New: SDHC memory card causes divide error: 0000
 [#1] PREEMPT SMP
Date: Fri, 13 May 2011 10:37:07 +0530
Message-ID: <723849F6A4B5A3408299DF1FFE37CA776C09CFC1FA@BGMAIL02.nvidia.com>
References: <m339kkylx9.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:15611 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab1EMFHM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2011 01:07:12 -0400
In-Reply-To: <m339kkylx9.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "s.jansen@gmail.com" <s.jansen@gmail.com>

Hello Folks,
Sorry for interruption.
I wanted to know when and which version of mmc driver will have SD 4.0(UHS-II) support?

Regards,
Sachin Nikam.
NVIDIA.

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chris Ball
Sent: Thursday, May 12, 2011 9:02 PM
To: linux-mmc@vger.kernel.org; s.jansen@gmail.com
Subject: [Bug 35002] New: SDHC memory card causes divide error: 0000 [#1] PREEMPT SMP

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
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
