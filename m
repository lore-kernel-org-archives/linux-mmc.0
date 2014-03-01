From: Jon Ringle <jonringle@gmail.com>
Subject: wait_for_completion in mmc_wait_for_req_done never returns
Date: Sat, 1 Mar 2014 11:10:54 -0500
Message-ID: <8272F2D9-5168-421C-93F4-E4FE6FFA5E23@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:38225 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbaCAQLA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Mar 2014 11:11:00 -0500
Received: by mail-qc0-f175.google.com with SMTP id e16so2082551qcx.6
        for <linux-mmc@vger.kernel.org>; Sat, 01 Mar 2014 08:10:59 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>

I'm porting an arm board from linux-3.10 to linux-3.12 and found that I can no longer detect the SD card. I found that the wait_for_completion(&mrq->completion) in drivers/mmc/core/core.c:mmc_wait_for_req_done() is never returning.

I was able to bisect the problem to this commit:
  0244ad004a54e39308d495fee0a2e637f8b5c317 is the first bad commit
  commit 0244ad004a54e39308d495fee0a2e637f8b5c317
  Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
  Date:   Fri Aug 30 09:39:53 2013 +0200
  
  Remove GENERIC_HARDIRQ config option
  
  After the last architecture switched to generic hard irqs the config
  options HAVE_GENERIC_HARDIRQS & GENERIC_HARDIRQS and the related code
  for !CONFIG_GENERIC_HARDIRQS can be removed.
  
  Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

I'm not sure what I should do to fix the problem. Does anyone have any suggestions?

Thanks,
Jon Ringle