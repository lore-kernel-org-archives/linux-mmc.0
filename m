From: Chris Ball <cjb@laptop.org>
Subject: Re: MMC insert remove issue
Date: Tue, 18 May 2010 11:09:18 -0400
Message-ID: <m3632lb61t.fsf@pullcord.laptop.org>
References: <AANLkTimg_VbK2uPZNCn3Il8klv22JhF7iEe-MTCA5NYe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43941 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757294Ab0ERPrq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 May 2010 11:47:46 -0400
In-Reply-To: <AANLkTimg_VbK2uPZNCn3Il8klv22JhF7iEe-MTCA5NYe@mail.gmail.com>
	(Madhav Chauhan's message of "Tue, 18 May 2010 20:02:32 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhav Chauhan <madhav.imsec@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

   > In one ARM based boards I am facing soft lock up issue while
   > inserting/removing MMC/SD card continuously having 2K files.  Can
   > someone point me where should i look whether host controller
   > driver or MMC block layer/Kernel block layer??

Could be any of the above, but perhaps most likely your host
controller driver -- which one are you using?  Can you perform
alt-sysrq-t when the lockup happens, or get a kgdb backtrace?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
