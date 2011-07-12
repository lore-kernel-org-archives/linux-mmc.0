From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: question on mmc_queue_bounce_pre()/post() in block.c
Date: Mon, 11 Jul 2011 17:36:14 -0700
Message-ID: <4E1B96FE.8000402@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39349 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054Ab1GLAgL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jul 2011 20:36:11 -0400
Received: from [10.7.232.72] (poundcake.jf.intel.com [10.7.232.72])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id DFF9F6A4007
	for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2011 17:35:53 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have a question concerning the following block of code in 
~/drivers/mmc/card/block.c:

		mmc_queue_bounce_pre(mq);

		/*
		 * Before issuing a user req, host driver should
		 * wait for the BKOPS is done or just use HPI to
		 * interrupt it.
		 */
		if (mmc_wait_for_bkops(card))
			goto cmd_err;
		mmc_wait_for_req(card->host, &brq.mrq);
		mmc_queue_bounce_post(mq);

What is the purpose of mmc_queue_bounce_pre() and 
mmc_queue_bounce_post()?  At first when I looked at the code, I thought 
it was implementing some type of sw cache- mmc_queue_bounce_pre(mq) 
would be stored in a buffer, available for reads even before the data 
gets eventually written to the SSD from the mmc_wait_for_req() call. 
But the way the code is written, a read from the buffer won't happen 
until AFTER the mmc_wait_for_req(), which kind-of defeats the purpose of 
cache.  This is independent of the work Per Forlin and co. are doing to 
make mmc_wait_for_req() non-blocking. So with the way that the code is 
written today, I am not really sure what benefit 
mmc_queue_bounce_pre()/*_post() is providing.

I'm still ramping up in this area of the linux kernel, like I don't yet 
understand the purpose of a scatterlist.  But I'm looking to contribute 
to this area of Linux in some regard.

Thanks for the help,
Jay
