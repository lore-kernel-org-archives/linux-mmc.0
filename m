From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: mmc: sdhci-pci: MSI support breaks O2 Micro 8320
Date: Thu, 29 Mar 2012 09:27:36 +0200
Message-ID: <CAOLZvyHOPfAYYLRumJFoRuh8z4sKDjvE0ycVgrE7DG1R7fLBOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62027 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2C2H2Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Mar 2012 03:28:16 -0400
Received: by yhmm54 with SMTP id m54so1256710yhm.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Mar 2012 00:28:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Alexander Stein <alexander.stein@systec-electronic.com>

Hello,

Commit e6039832 (mmc: sdhci-pci: Add MSI support) breaks my
O2 8320 SD card reader:  No interrupts are actually processed,
irq counter for mmc0 stays at the initial count of 2 regardless of card events.

Thanks,
        Manuel Lauss
