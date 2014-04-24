From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 0/5] mmc: host: omap_hsmmc: a few improvements
Date: Thu, 24 Apr 2014 20:51:25 +0530
Message-ID: <53592BF5.6020104@ti.com>
References: <1395878690-9650-1-git-send-email-balbi@ti.com> <20140421173203.GH22794@saruman.home> <53568B04.4050703@ti.com> <20140422154858.GN5524@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140422154858.GN5524@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 22 April 2014 09:18 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Apr 22, 2014 at 09:00:12PM +0530, Balaji T K wrote:
>> On Monday 21 April 2014 11:02 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Wed, Mar 26, 2014 at 07:04:45PM -0500, Felipe Balbi wrote:
>>>> this series lets us access the newer registers introduced
>>>> back in OMAP4 which give us some valid information about
>>>> the OMAP HSMMC IP like max block size, support for ADMA,
>>>> support for Retention.
>>>>
>>>> Right now, only setting max_blk_size correctly as supporting
>>>> ADMA and Retention will take a lot of work.
>>>>
>>>> Tested on OMAP5 uEVM.
>>>>
>>>> Felipe Balbi (5):
>>>>    mmc: host: omap_hsmmc: pass host as an argument
>>>>    mmc: host: omap_hsmmc: add reg_offset field
>>>>    mmc: host: omap_hsmmc: introduce new accessor functions
>>>>    mmc: host: omap_hsmmc: switch over to new accessors
>>>>    mmc: host: omap_hsmmc: set max_blk_size correctly
>>
>> Got mislead by your reply to this series, about the alternative way of
>> reading memory size from CAPA register
>
> sure, we can do that if you prefer, I just felt I wouldn't touch
 > platforms I can't really test :-s

I think so, since those 3 newer registers are not documented for all platforms.
Not sure whether it is valid in those cases where it is not documented.

Since capa register has these info and can be
applied uniformly across all paltforms, I feel reading capa register is the
way to go. Do you still think there is a need for new api with no offset ?

>
>>> this has been here for almost a month, any comments ?
>>>
>>
>> Do you see any performance impact with this series ?
>
> in the normal case ? no... it helps only with large transfers
>

Do you have the numbers ?
Is it for read or write,
how large should the transfer size be ?

I couldn't get any performance improvements with this patch series,
Could you please share your test setup, may be I am missing something.
