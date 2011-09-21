From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: bounce_sg and sg in mmc_queue
Date: Wed, 21 Sep 2011 11:26:54 -0700
Message-ID: <4E7A2C6E.70408@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8581 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729Ab1IUSVP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:21:15 -0400
Received: from [10.7.232.151] (poundcake.jf.intel.com [10.7.232.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 9B6B56A4082
	for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2011 11:21:11 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello:

Could anyone tell me in struct mmc_queue, what is the difference between 
'struct scatterlist *bounce_sg' and 'struct scatterlist *sg' is?

I see 'bounce_sg' get used to copy data from/to the buffer upon a host 
read/write operation so I assume 'bounce_sg' points to the most recent 
data from a host controller read/write operation.

Thanks for the help.

-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
