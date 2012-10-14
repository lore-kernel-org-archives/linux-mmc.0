From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH] mmc: fix async request mechanism for sequential read
     scenarios
Date: Sun, 14 Oct 2012 18:17:29 +0200 (IST)
Message-ID: <0861696a510e833409520496cfe84d3c.squirrel@www.codeaurora.org>
References: <1349192378-1676-1-git-send-email-kdorfman@codeaurora.org>
    <1349192378-1676-2-git-send-email-kdorfman@codeaurora.org>
    <CAFEEs1=zU88dwY1K0+Q9PxdqyOpsNMtj6mZ3YkwebPugofyEEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAFEEs1=zU88dwY1K0+Q9PxdqyOpsNMtj6mZ3YkwebPugofyEEw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Konstantin Dorfman <kdorfman@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, per.forlin@stericsson.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 11 Oct 2012 17:19:01 +0200, Per Forlin <per.lkml@gmail.com>
wrote:
Hello Per,

>I would like to start with some basic comments.
>
>1. Is this read sequential issue specific to MMC?
>2. Or is it common with all other block-drivers that gets data from
>the block layer (SCSI/SATA etc) ?
>If (#2) can the issue be addressed inside the block layer instead?
>
>BR
>Per
This issue specific to MMC, others block drivers probably not using
MMC mechanism for async request (or have more kernel threads for
processing incoming blk requests).
I think, since MMC actively fetches requests from block layer queue,
the solution has nothing to do with block layer context.

>
>On Tue, Oct 2, 2012 at 5:39 PM, Konstantin Dorfman
><kdorfman@codeaurora.org> wrote:
>> The main assumption of the async request design is that the file
>> system adds block requests to the block device queue asynchronously
>> without waiting for completion (see the Rationale section of
>> https://wiki.linaro.org/WorkingGroups/Kernel/Specs
>> /StoragePerfMMC-async-req).
>>
>> We found out that in case of sequential read operations this is not
>> the case, due to the read ahead mechanism.
>Would it be possible to improve this mechanism to achieve the same result?
>Allow an outstanding read ahead request on top of the current ongoing one.
>

I need to look on this mechanism,  but from first glance such
behaviour may be result of libc/vfs/fs decisions and too complex
comparing to the patch we are talking about.


-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
