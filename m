From: "Schollmeyer, David A" <david.a.schollmeyer@intel.com>
Subject: BKOPS Support
Date: Sat, 2 Aug 2014 00:06:40 +0000
Message-ID: <0B57664BEFBB104C94244254B90DDDD23E3187B7@FMSMSX119.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62434 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaHBAHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Aug 2014 20:07:02 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I have a card with BKOPS_SUPPORT set in its ext_csd and I see the
following Message during boot:

    mmc0: BKOPS_EN bit is not set.

>From the eMMC spec, it looks to me that the host should set this bit
if the card reports BKOPS_SUPPORT:

    7.4.60  BKOPS_EN [163] 
    This field allows the host to indicate to the device if it is
    expected to periodically manually start background operations by
    writing to the BKOPS_START field.

Am I reading this correctly? Shouldn't the mmc driver write the
register after reading the ext_csd if it wishes to perform background
operations and the card supports it?

I'm running 3.12.17 but it appears to be handled the same in the latest
kernel source.

Thanks,
David
