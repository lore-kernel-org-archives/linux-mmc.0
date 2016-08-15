From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] block: Fix secure erase
Date: Mon, 15 Aug 2016 12:16:30 -0600
Message-ID: <0da0904a-9d46-e043-edec-8d0d34cf0714@fb.com>
References: <20160811140533.GA16543@lst.de>
 <1471270071-28921-1-git-send-email-adrian.hunter@intel.com>
 <20160815181328.GA9696@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20160815181328.GA9696@lst.de>
Sender: linux-block-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 08/15/2016 12:13 PM, Christoph Hellwig wrote:
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -366,7 +366,10 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
>>  	list_for_each_prev(entry, &q->queue_head) {
>>  		struct request *pos = list_entry_rq(entry);
>>
>> -		if ((req_op(rq) == REQ_OP_DISCARD) != (req_op(pos) == REQ_OP_DISCARD))
>> +		if ((req_op(rq) == REQ_OP_DISCARD ||
>> +		     req_op(rq) == REQ_OP_SECURE_ERASE) !=
>> +		    (req_op(pos) == REQ_OP_DISCARD ||
>> +		     req_op(pos) == REQ_OP_SECURE_ERASE))
>>  			break;
>
> This really should be a:
>
> 	if (req_op(rq) != req_op(pos))
>
> I'l lleave it up to Jens if he wants that in this patch or not, otherwise
> I'll send an incremental patch.

Let's get a v2 with that fixed up, it makes a big readability
difference.

-- 
Jens Axboe
