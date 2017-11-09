From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V13 10/10] mmc: block: blk-mq: Stop using legacy recovery
Date: Thu, 9 Nov 2017 09:43:44 +0200
Message-ID: <3608285c-614a-36cc-5f7b-5fb5708c1a84@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-11-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZNcd7Nu2dAajqBcn44c05jY76BUNOM5vBPzfhVub_HhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZNcd7Nu2dAajqBcn44c05jY76BUNOM5vBPzfhVub_HhQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

On 08/11/17 11:38, Linus Walleij wrote:
> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> There are only a few things the recovery needs to do. Primarily, it just
>> needs to:
>>         Determine the number of bytes transferred
>>         Get the card back to transfer state
>>         Determine whether to retry
>>
>> There are also a couple of additional features:
>>         Reset the card before the last retry
>>         Read one sector at a time
>>
>> The legacy code spent much effort analyzing command errors, but commands
>> fail fast, so it is simpler just to give all command errors the same number
>> of retries.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> I have nothing against the patch as such. In fact something
> like this makes a lot of sense (to me).
> 
> But this just makes mmc_blk_rw_recovery() look really nice.
> 
> And leaves a very ugly mmc_blk_issue_rw_rq() with the legacy
> error handling in-tree.
> 
> The former function isn't even named with some *mq* infix
> making it clear that the new recovery path only happens
> in the MQ case.
> 
> If newcomers read this code in the MMC stack they will
> just tear their hair, scream and run away. Even faster than
> before.
> 
> How are they supposed to know which functions are used on
> which path? Run ftrace?

You're kidding me right?  You don't know how to find where a function used?

> This illustrates firmly why we need to refactor and/or kill off
> the old block layer interface *first* then add MQ on top.

No it doesn't!  You are playing games!  One function could be named
differently, so that is evidence the whole patch set should be ignored.

The old code is rubbish.  There is nothing worth keeping.  Churning it
around is a waste of everybody's time.  Review and test the new code.
Delete the old code.  Much much simpler!
