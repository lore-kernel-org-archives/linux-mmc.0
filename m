From: "Kipper, Matthew" <Matthew.Kipper@gd-ms.ca>
Subject: Mixing eMMC "Discard" and "Sanitize"
Date: Thu, 1 Jun 2017 19:01:09 +0000
Message-ID: <5386C99C33554A469B5039A08D6430D0385FF00B@ottsvw202.gdcan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp4.gdcanada.com ([209.29.4.47]:18976 "EHLO
        OTTMGC001.GDCAN.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFATBP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2017 15:01:15 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I'm creating an application that relies on an eMMC device's Sanitize feature, and I have a small concern about the implementation of this feature in the kernel.  

When erasing data from an eMMC device, it seems like the MMC core chooses between three modes: Erase, TRIM and Discard. This can be seen in 'mmc_blk_issue_discard_rq'. Looking through the eMMC 5.1 standard (JESD84-B51), the section covering the Discard operation (6.6.12) says the following: 

"When Sanitize is executed, only the portion of the data that was unmapped by a Discard command shall be removed by the Sanitize command. The device cannot guarantee that discarded data is completely removed from the device when Sanitize is applied."

Reading that, it sounds like if data is removed with Discard, there's no guarantee that a subsequent Sanitize will completely wipe it from the device. This would mean that in the current implementation, calling Sanitize may not have the result that a user would expect.  Can anyone confirm that my interpretation is correct? 

Taking a quick look at the kernel source, one naïve workaround might be to add a flag (e.g. CONFIG_MMC_FULL_SANITIZE) that would force 'mmc_can_discard' to return false. As far as I can tell, this would force the core to always use Erase and TRIM commands, which allows Sanitize to provide a guarantee that it will fully wipe all erased data. 

Does this approach make sense? Would this drastically impact the performance/lifespan of eMMC devices? I don't know much about eMMC devices and even less about the kernel's MMC driver, so I was hoping to get some feedback before going too far with this.

Regards,
Matthew Kipper 
