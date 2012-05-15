From: Philip Rakity <prakity@marvell.com>
Subject: regulator advise needed
Date: Tue, 15 May 2012 16:30:17 -0700
Message-ID: <A093AC61-96F8-4F76-B6C9-0C6B3C541B29@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:39164 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966190Ab2EOXaj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 May 2012 19:30:39 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


In sdhci_set_ios() we call sdhci_set_power()

this code assumes that the SDHCI_POWER_CONTROL register works in the SD controller.
In our controller it does not.  We need a regulator to do the right thing.

I hae added regulator support (patch coming)
BUT the code crashes because we are scheduling in atomic context  when sdhci_set_power() is called.

the current "hack" is

	spin_unlock_irqrestore(&host->lock, flags);
printk("%s/%d: ios->power_mode = %x\n", __func__, __LINE__, ios->power_mode);
	if (ios->power_mode == MMC_POWER_OFF)
		sdhci_set_power(host, -1);
	else
		sdhci_set_power(host, ios->vdd);
	spin_lock_irqsave(&host->lock, flags);


I could just disable the interrupt line on the controller while I do this change (like I proposed before)
but maybe someone knows another way to get there from here.

Philip
