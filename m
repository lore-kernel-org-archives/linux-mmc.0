From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v4 1/1] block: Add test-iosched scheduler
Date: Tue, 12 Jun 2012 16:13:46 -0400
Message-ID: <x498vfsi8zp.fsf@segfault.boston.devel.redhat.com>
References: <1339491984-8462-1-git-send-email-merez@codeaurora.org>
	<1339491984-8462-2-git-send-email-merez@codeaurora.org>
	<x4962awk4fs.fsf@segfault.boston.devel.redhat.com>
	<f9b014a8098cce8e4bac8d333d7101c0.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab2FLUNt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Jun 2012 16:13:49 -0400
In-Reply-To: <f9b014a8098cce8e4bac8d333d7101c0.squirrel@www.codeaurora.org>
	(merez@codeaurora.org's message of "Tue, 12 Jun 2012 12:58:44 -0700
	(PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, DOCUMENTATION <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

merez@codeaurora.org writes:

> On Tue, June 12, 2012 7:09 am, Jeff Moyer wrote:
>> Maya Erez <merez@codeaurora.org> writes:
>>
>>> The test scheduler allows testing a block device by dispatching
>>> specific requests according to the test case and declare PASS/FAIL
>>> according to the requests completion error code
>>
>> What sort of tests have you written that make use of this
>> infrastructure?
>>
>>> @@ -1072,8 +1072,6 @@ struct request *blk_get_request(struct
>>> request_queue *q, int rw, gfp_t gfp_mask)
>>>  {
>>>  	struct request *rq;
>>>
>>> -	BUG_ON(rw != READ && rw != WRITE);
>>> -
>>
>> Please explain this.
> get_request and get_request_wait, called by blk_get_request, expects to
> get the REQ_SYNC flag in addition to the read/write flag. Moreover, it
> uses the REQ_SYNC flag in its algorithm decision making.
> However blk_get_request expects to get a Boolean to indicate only
> read/write flag and cannot handle the REQ_SYNC flag.

Right, so why is it okay to change this?  Right now, blk_get_request is
used for block special requests.  There is no sense of sync vs. async
for such requests (that's an fs request notion).  Perhaps you're calling
the wrong function?

Cheers,
Jeff
