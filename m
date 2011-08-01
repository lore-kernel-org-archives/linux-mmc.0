From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: question regarding blk_rq_pos() calls in block.c
Date: Mon, 01 Aug 2011 13:44:16 -0700
Message-ID: <4E371020.4050100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46928 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449Ab1HAUoE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Aug 2011 16:44:04 -0400
Received: from [10.7.232.72] (poundcake.jf.intel.com [10.7.232.72])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id C7F3C6A4087
	for <linux-mmc@vger.kernel.org>; Mon,  1 Aug 2011 13:44:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

In the driver block.c there is this line:

	do {
		struct mmc_command cmd;
		u32 readcmd, writecmd, status = 0;

		memset(&brq, 0, sizeof(struct mmc_blk_request));
		brq.mrq.cmd = &brq.cmd;
		brq.mrq.data = &brq.data;

		// THIS LINE
		brq.cmd.arg = blk_rq_pos(req);

I saw the sector number is a 64 bit number, so can the sector be 
considered a 'unique number', kind of like a unique address?

I don't see block.c actually using an address to set up a queue request 
read/write; rather, just sector, block size, command, and # of sectors. 
  That is why I was wondering.

Thanks for the help and insight.

-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
