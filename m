From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: bounce_sg and sg in mmc_queue
Date: Thu, 22 Sep 2011 09:35:04 -0700
Message-ID: <4E7B63B8.2000100@linux.intel.com>
References: <4E7A2C6E.70408@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63469 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab1IVQ3O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Sep 2011 12:29:14 -0400
Received: from [10.7.232.151] (poundcake.jf.intel.com [10.7.232.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id D90016A4087
	for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2011 09:29:09 -0700 (PDT)
In-Reply-To: <4E7A2C6E.70408@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 09/21/2011 11:26 AM, J Freyensee wrote:
> Hello:
>
> Could anyone tell me in struct mmc_queue, what is the difference between
> 'struct scatterlist *bounce_sg' and 'struct scatterlist *sg' is?
>
> I see 'bounce_sg' get used to copy data from/to the buffer upon a host
> read/write operation so I assume 'bounce_sg' points to the most recent
> data from a host controller read/write operation.
>

If someone actually knows this, I will send up a patch documenting this 
in the code.  I think some of the mmc code could use a little 
documentation??

> Thanks for the help.
>


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
