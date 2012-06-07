From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Thu, 7 Jun 2012 20:31:35 +0900
Message-ID: <CAKYAXd_wZ3OO60VCB3W=4Q5RP98DDhQD1c3a4jsXZjOc9okwUg@mail.gmail.com>
References: <1339064218-31925-1-git-send-email-subhashj@codeaurora.org>
	<CAKYAXd8VmJEzGG8sd-GJvG9qKGDahmFSBwNxnH3LCocT_F+o2Q@mail.gmail.com>
	<4FD08671.9040402@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4FD08671.9040402@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2012/6/7, Subhash Jadavani <subhashj@codeaurora.org>:
> On 6/7/2012 4:05 PM, Namjae Jeon wrote:
>> This change is not meant for improving MMC throughput; it's basically
>> >  about becoming fair to other threads/interrupts in the system. By
>> > holding
>> >  spin lock and interrupts disabled for longer duration, we won't allow
>> >  other threads/interrupts to run at all.
> As i have mentioned in commit text,
>
> This change is not meant for improving MMC throughput; it's basically
> about becoming fair to other threads/interrupts in the system. By holding
> spin lock and interrupts disabled for longer duration, we won't allow
> other threads/interrupts to run at all.
Okay, this patch means latency will be improved on multi thread environment.
Looks reasonable to me.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
>
> Regards,
> Subhash
>
>
