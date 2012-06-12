From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v4 1/1] block: Add test-iosched scheduler
Date: Tue, 12 Jun 2012 10:09:11 -0400
Message-ID: <x4962awk4fs.fsf@segfault.boston.devel.redhat.com>
References: <1339491984-8462-1-git-send-email-merez@codeaurora.org>
	<1339491984-8462-2-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1339491984-8462-2-git-send-email-merez@codeaurora.org> (Maya
	Erez's message of "Tue, 12 Jun 2012 12:06:24 +0300")
Sender: linux-doc-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Maya Erez <merez@codeaurora.org> writes:

> The test scheduler allows testing a block device by dispatching
> specific requests according to the test case and declare PASS/FAIL
> according to the requests completion error code

What sort of tests have you written that make use of this
infrastructure?

> @@ -1072,8 +1072,6 @@ struct request *blk_get_request(struct request_queue *q, int rw, gfp_t gfp_mask)
>  {
>  	struct request *rq;
>  
> -	BUG_ON(rw != READ && rw != WRITE);
> -

Please explain this.

Cheers,
Jeff
