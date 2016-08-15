From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Fix secure erase
Date: Mon, 15 Aug 2016 20:17:54 +0200
Message-ID: <20160815181754.GA9918@lst.de>
References: <20160811140533.GA16543@lst.de> <1471270071-28921-1-git-send-email-adrian.hunter@intel.com> <20160815181328.GA9696@lst.de> <0da0904a-9d46-e043-edec-8d0d34cf0714@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0da0904a-9d46-e043-edec-8d0d34cf0714@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 15, 2016 at 12:16:30PM -0600, Jens Axboe wrote:
>> This really should be a:
>>
>> 	if (req_op(rq) != req_op(pos))
>>
>> I'l lleave it up to Jens if he wants that in this patch or not, otherwise
>> I'll send an incremental patch.
>
> Let's get a v2 with that fixed up, it makes a big readability
> difference.

It's not just readbility, it's also a potential correctness issue.
Not sure if we'd hit it for other request types at the moment, but
we'd surely hit if people add more..
