From: Randy Chiu <randyqiuxy@gmail.com>
Subject: sched: RT throttling activated with sdio interrupt
Date: Thu, 9 Jan 2014 16:59:52 +0800
Message-ID: <CAKUe6U5qJaLfTbCXuPb5yZbF8srWSxjbM83HHhGPcxFDKUrg6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f193.google.com ([209.85.128.193]:62485 "EHLO
	mail-ve0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbaAII7x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 03:59:53 -0500
Received: by mail-ve0-f193.google.com with SMTP id oy12so412926veb.4
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jan 2014 00:59:52 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,
I wrote some sdio driver with enabling sdio interrupt. But sched_rt.c
give the kernel_warning "sched: RT throttling activated" after one app
runs for a while.
I'm not clear about RT sheduling, and I don't understand what this
warning means.
My sdio driver and that app interactive like this:
1) driver write data to a kernel buffer;
2) app read data from the kernel buffer;
More phenomenon is: if I don't run the app from user space, then
kernel won't report this warning.
So I'd like to know
1) could app thread modify kernel's scheduling policy and report such a warning?
2) any means I can debug?
any suggestion will be appreciated

Thanks for your time.
Best regards,
Randy
