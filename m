From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: pre-defined multiple block read/write vs. open ended multiple block
 read/write
Date: Wed, 6 Apr 2011 21:54:42 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473570B05A3@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58576 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874Ab1DFNzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 09:55:47 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Currently, the mmc driver uses open ended multiple block read/write (CMD18/25+CMD12) commands and not use pre-defined multiple block read/write (CMD23+CMD18/25) commands.

According to the feedback from some MMC/SD device vendors, they prefer the pre-defined multiple block read/write commands since it gives the device a chance to do some internal optimization.

Also I found on the latest eMMC 4.5 Spec, quite a few new features requires using of CMD23. That means, these new features can not be implemented with the open ended multiple block read/write commands.

So, the question is, why the current mmc driver does not use the pre-defined multiple block read/write commands? Any comments?

Thanks.

Regards,
Yunpeng
