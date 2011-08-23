From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 15:40:46 -0700
Message-ID: <4E542C6E.5080507@linux.intel.com>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com> <1314114363-6767-3-git-send-email-svenkatr@ti.com> <m27h643x8k.fsf@bob.laptop.org> <20110823165620.GA9132@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
In-Reply-To: <20110823165620.GA9132@merkur.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 08/23/2011 09:56 AM, Sam Ravnborg wrote:
> On Tue, Aug 23, 2011 at 12:31:55PM -0400, Chris Ball wrote:
>> Hi,
>>
>> [Adding linux-sparse@ to CC]
>>
>> On Tue, Aug 23 2011, Venkatraman S wrote:
>>> Fix the sparse warning output
>>> "warning: Using plain integer as NULL pointer"
>>>
>>> Signed-off-by: Venkatraman S<svenkatr@ti.com>
>>> ---
>>>   drivers/mmc/card/block.c    |    4 ++--
>>>   drivers/mmc/core/core.c     |    2 +-
>>>   drivers/mmc/core/mmc_ops.c  |    4 ++--
>>>   drivers/mmc/core/sdio_ops.c |    2 +-
>>>   4 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 1ff5486..e702c61 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -291,7 +291,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>>>   	struct mmc_card *card;
>>>   	struct mmc_command cmd = {0};
>>>   	struct mmc_data data = {0};
>>> -	struct mmc_request mrq = {0};
>>> +	struct mmc_request mrq = {NULL};
>>>   	struct scatterlist sg;
>>>   	int err;
>>> [...]
>>
>> The sparse warning is mistaken.  Or I'm mistaken.  But I suspect it's
>> the sparse warning.
>>

Okay, stupid question times:

 >>> -	struct mmc_request mrq = {0};

this is 'struct mmc_request mrq' and not 'struct mmc_request *mrq', right?

Then I think the sparse warning is correct.  From my experience, sparse 
is very clear: if any variable is defined as a pointer, you use NULL to 
reset the pointer instead of '0', and if any variable is a normal 
variable, you use '0' to reset the variable. I don't think sparse is 
smart enough to look at the underlying variables, which in this case, 
mrq contains members that are pointers to something.

in this case, the defined variable is not a pointer, rather a variable 
named mrq that is of type 'struct mmc_request'.  Therefore, 0 is correct 
to use and NULL is incorrect.

If you want it to be sparse-correct as well as human-readable correct, 
you probably should write the code that explicitly shows assigning each 
pointer member of mrq to NULL, ie:

struct mmc_request mrq;
mrq.sbc = NULL;
mrq.cmd = NULL;
mrq.data = NULL;
.
.
etc.



>> The {0} syntax is covered by:
>>
>>     [6.7.8.21] If there are fewer initializers in a brace-enclosed list
>>     than there are elements or members of an aggregate, or fewer
>>     characters in a string literal used to initialize an array of known
>>     size than there are elements in the array, the remainder of the
>>     aggregate shall be initialized implicitly the same as objects that
>>     have static storage duration.
>>
>> So we're not assigning 0 to a pointer, or whatever sparse thinks we're
>> doing -- we're initializing every member of the struct with 0, which is
>> a good and safe way to initialize it.
>>
>> Sparse folks, any comment?
>
> The struct looks like this:
> struct mmc_request {
>          struct mmc_command      *sbc;           /* SET_BLOCK_COUNT for multiblock */
>          struct mmc_command      *cmd;
>          struct mmc_data         *data;
>          struct mmc_command      *stop;
>
>          struct completion       completion;
>          void                    (*done)(struct mmc_request *);/* completion function */
> };
>
>
> So you assing '0' to sbc - which is a pointer.
> So sparse warning is correct.
>
> 	Sam
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
