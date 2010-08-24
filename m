From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: sdhci-stm performance issues
Date: Tue, 24 Aug 2010 17:11:28 +0200
Message-ID: <107012446AC13D4C90B85672EAF5FB0E9E0FB3CE8E@SAFEX1MAIL3.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:38124 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751507Ab0HXPL5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Aug 2010 11:11:57 -0400
Received: from zeta.dmz-us.st.com (zeta.dmz-us.st.com [167.4.80.115])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id C53D9E8
	for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2010 15:08:42 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas3.st.com [10.75.90.18])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 156F929B
	for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2010 15:11:52 +0000 (GMT)
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello,
testing the sdhci-stm.c driver, I sent some weeks ago to the mailing list,
I'm facing some performance issues.
For example, when copy a file (e.g. ~10MiB) to the card, I've noticed that,
in the sdhci_prepare_data, the maximum value for data->blocks is 248.

The sdhci-stm driver uses the ADMA and:
  max_seg_size = 65536, 
  max_hw_segs = 128,
  max_phys_segs = 128,
  max_req_size = 524288, 
  max_blk_size = 2048,
  max_blk_count = 65535.

Using my arasan.c code, I've also sent to this mailing list in July,
I could see that the data->blocks was bigger than 248 and the performances were better.
Note that this driver used the same mmc_host parameters (max_blk_size etc.) reported
above for the sdhci-stm.

What am I missing?

Welcome advice.

Best Regards,
Giuseppe
