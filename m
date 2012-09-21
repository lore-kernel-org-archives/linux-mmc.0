From: Kevin Liu <keyuan.liu@gmail.com>
Subject: sdhci: sdio wakeup and free_irq
Date: Fri, 21 Sep 2012 17:20:56 +0800
Message-ID: <CADz5_gLLTY6ibBSZCHfYFfJ9Uz15zVu41hm19pQ_FCgBqhsmEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52183 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500Ab2IUJU5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Sep 2012 05:20:57 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so1834949wey.19
        for <linux-mmc@vger.kernel.org>; Fri, 21 Sep 2012 02:20:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi, all

Can latest code support sdio wakeup?
I see at last of sdhci_suspend_host, irq will be freed. But if the irq
is used for wakeup system like sdio wakeup irq? Then system can't be
woken up.
And we can't just skip the free_irq for sdio to resolve this issue
since the host has been suspended before.
Any idea?

Thanks
Kevin
