From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Support for UHS-I SD 3.0 modes
Date: Tue, 28 Sep 2010 19:14:12 +0530
Message-ID: <4CA1F12C.8050004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:56527 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab0I1NoQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 09:44:16 -0400
Received: from [10.44.76.44] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 94FA310004B1
	for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 06:44:11 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

  Hi,

Is there anyone working on for adding support of UHS-I  bus speed modes 
(newly defined in SD3.0 specs for SDHC and SDXC cards) in mmc layer?

for SDXC cards, exFAT file system support might be required but what 
about SDHC cards supporting UHS-I bus speed modes?

Regards,
Subhash
