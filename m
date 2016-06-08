From: Oliver Neukum <oneukum@suse.de>
Subject: card detection incomplete with rtsx_pci in v4.7-rc1
Date: Wed, 08 Jun 2016 12:41:28 +0200
Message-ID: <1465382488.5421.8.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50527 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161079AbcFHKpR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Jun 2016 06:45:17 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 48EC2ABA5
	for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2016 10:45:16 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I am seeing a regression (unfortunately the latest working version
I tried it with is v3.17. I am seeing an event but it is not
reported up:

Jun 08 12:39:41 linux-dtbq.site kernel: rtsx_pci 0000:5d:00.0: --> rtsx_pci_card_detect
Jun 08 12:39:41 linux-dtbq.site kernel: rtsx_pci 0000:5d:00.0: irq_status: 0x00010000
Jun 08 12:39:41 linux-dtbq.site kernel: rtsx_pci 0000:5d:00.0: card_inserted: 0x10000, card_removed: 0x0

But that's it.

5d:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5249 PCI Express Card Reader [10ec:5249] (rev 01)
        Subsystem: Hewlett-Packard Company Device [103c:190a]
        Physical Slot: 7
        Flags: bus master, fast devsel, latency 0, IRQ 30
        Memory at cc800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-00-00-01-00-4c-e0-00
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
        Kernel driver in use: rtsx_pci
        Kernel modules: rtsx_pci

	Regards
		Oliver


