From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [Query] mmc: core "MMC_PM_KEEP_POWER"
Date: Tue, 22 Nov 2011 14:29:21 +0100
Message-ID: <4ECBA3B1.1010808@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:43800 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752755Ab1KVNaN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 08:30:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: eliad@wizery.com, nico@fluxnic.net

Hi,

In mmc_resume_host we clear the MMC_PM_KEEP_POWER flag from the pm_flags 
bitfield. This is done by a patch from Eliad Peller a while ago, "mmc: 
clear MMC_PM_KEEP_POWER flag on resume"

I would like to understand if there are any reason to why we want to 
clear this flag after we done a resume. I think it will add complexity 
to an sdio function driver since it must update this flag for after each 
suspend/resume sequence. Should it not just be enough to do this during 
the initialization of the sdio func driver.


Br
Ulf Hansson

