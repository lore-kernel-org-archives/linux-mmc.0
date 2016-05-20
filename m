From: Muni Sekhar <munisekharrms@gmail.com>
Subject: mmc: sdhci: 64 bit \ 32 bit aligned transfers
Date: Fri, 20 May 2016 21:09:55 +0530
Message-ID: <CAHhAz+gC=GRA6L_X6eKMVNksmJkiF7tV5s4CapB5NQVhQSM01Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36411 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbcETPj4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2016 11:39:56 -0400
Received: by mail-io0-f182.google.com with SMTP id f8so17734520ioe.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 May 2016 08:39:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hello,



I had a few doubts regarding 64 bit \ 32 bit \ 8 bit aligned transfers in SDHCI.



I am guessing that the alignment is determined by the DMA start
address being on 64 (or 32) bit boundary.



I am having a SDMA capable SD Host Controller,  to verify this I
triggered a single block 256 bytes CMD53 write to SDIO device. I read
the SDHCI_DMA_ADDRESS register value as 0xb8034a18 before triggering
the command and after end of the transfer.



What is the default alignment used for DMA transfers, is it 64-bit?
But the above mentioned value(0xb8034a18) is neither 64-bit nor
32-bit.



Does reading the SDHCI_DMA_ADDRESS register at the end of a transfer
indicates the address of the last byte transferred? If so why the
value is not changed before and end of the transfer?



Any clarifications are welcome. Thanks for your time.

-- 
Thanks,
Sekhar
