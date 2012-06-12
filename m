From: merez@codeaurora.org
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Tue, 12 Jun 2012 13:08:10 -0700 (PDT)
Message-ID: <0bfe25272b45f6ebaa9fe74297d47d02.squirrel@www.codeaurora.org>
References: <1338576911-17089-1-git-send-email-merez@codeaurora.org>
    <1338576911-17089-2-git-send-email-merez@codeaurora.org>
    <CAFR8uefCD_WXDM6m+-XwG10+W0UXqOtK7_sxWD3uVckh3pnR-Q@mail.gmail.com>
    <CAFR8uee7hWLC-h_abZOCEuqeUeuhDuJp74x3R-3n+c61xyfaPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFR8uee7hWLC-h_abZOCEuqeUeuhDuJp74x3R-3n+c61xyfaPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muthu Kumar <muthu.lkml@gmail.com>
Cc: Maya Erez <merez@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, DOCUMENTATION <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On Mon, June 11, 2012 5:28 pm, Muthu Kumar wrote:
> On Mon, Jun 11, 2012 at 2:19 PM, Muthu Kumar <muthu.lkml@gmail.com> wrote:
>> On Fri, Jun 1, 2012 at 11:55 AM, Maya Erez <merez@codeaurora.org> wrote:
>>> The write packing control will ensure that read requests latency is
>>> not increased due to long write packed commands.
>>>
>>> The trigger for enabling the write packing is managing to pack several
>>> write requests. The number of potential packed requests that will
>>> trigger
>>> the packing can be configured via sysfs by writing the required value
>>> to:
>>> /sys/block/<block_dev_name>/num_wr_reqs_to_start_packing.
>>> The trigger for disabling the write packing is fetching a read request.
>>>
>>
>> If it is applicable only to MMC why do we have this sysfs attr for all
>> block devices?
>
> Just to be clear, please create a directory, say mmc, under
> /sys/block/<dev>/ and create the attr inside that.
>
> You can refer to dm (dm-sysfs.c) for sample implementation.
>
> Regards,
> Muthu
>

I will apply this change in the next patch.

Thanks,
Maya Erez

-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
