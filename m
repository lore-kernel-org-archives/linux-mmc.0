From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: Will the mmc driver stack implement runtime PM support?
Date: Mon, 9 Aug 2010 18:56:13 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47328E2DD34@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27202 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152Ab0HIK4L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 06:56:11 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, 
I noticed that in latest Linux kernel, a run time PM management framework has been introduced. That is, bus/device drivers can dynamic manage their power by calling the runtime APIs pm_runtime_put(),pm_runtime_get() and so on. I think it's very useful for power-sensitive products, such as smart phone.

So, I just curious that is there any works/plan on supporting the runtime PM APIs for the mmc driver in community? Thanks

Regards,
Yunpeng

