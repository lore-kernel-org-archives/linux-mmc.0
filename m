From: Prashanth Bhat <prashanth.bhat@manipal.net>
Subject: Potential Bug in drivers/mmc/
Date: Sat, 09 Apr 2011 07:04:42 +0530
Message-ID: <4D9FB7B2.3080702@manipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from p3plsmtpa01-06.prod.phx3.secureserver.net ([72.167.82.86]:59953
	"HELO p3plsmtpa01-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757986Ab1DIBle (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 21:41:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: mirq-linux@rere.qmqm.pl, adrian.hunter@nokia.com, cjb@laptop.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

Hi,

I'm new to Linux kernel code, but I think I spot a bug in a commit made 
to drivers/mmc/core/bus.c in 2.6.36, back in Aug 2010.

Here's the GIT URL showing the changes in this commit:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7310ece86ad7da027f85a37a0638164118a5d12f

At line 239, the following code change was made:

+ case MMC_TYPE_SD_COMBO:
+               type = "SD-combo";
+               if (mmc_card_blockaddr(card))
+                       type = "SDHC-combo";


The bug : I would have expected to see a "break" at the end of the new 
case entry. I don't see this, even in a later version of the source 
(namely 2.6.38).

Please take a look, and also let me know what you decide.

Thanks,
Prashanth Bhat

=============================================================
Prashanth B. Bhat,  Ph. D.
Chief Technology Officer,
Manipal Dot Net Pvt. Ltd.
Manipal 576 104 INDIA

http://www.linkedin.com/in/prashanthbhat
http://www.manipal.net
prashanth.bhat@manipal.net
=============================================================
