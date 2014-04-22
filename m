From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 0/5] mmc: host: omap_hsmmc: a few improvements
Date: Tue, 22 Apr 2014 21:00:12 +0530
Message-ID: <53568B04.4050703@ti.com>
References: <1395878690-9650-1-git-send-email-balbi@ti.com> <20140421173203.GH22794@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140421173203.GH22794@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 21 April 2014 11:02 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Mar 26, 2014 at 07:04:45PM -0500, Felipe Balbi wrote:
>> this series lets us access the newer registers introduced
>> back in OMAP4 which give us some valid information about
>> the OMAP HSMMC IP like max block size, support for ADMA,
>> support for Retention.
>>
>> Right now, only setting max_blk_size correctly as supporting
>> ADMA and Retention will take a lot of work.
>>
>> Tested on OMAP5 uEVM.
>>
>> Felipe Balbi (5):
>>    mmc: host: omap_hsmmc: pass host as an argument
>>    mmc: host: omap_hsmmc: add reg_offset field
>>    mmc: host: omap_hsmmc: introduce new accessor functions
>>    mmc: host: omap_hsmmc: switch over to new accessors
>>    mmc: host: omap_hsmmc: set max_blk_size correctly

Got mislead by your reply to this series, about the alternative way of
reading memory size from CAPA register

>
> this has been here for almost a month, any comments ?
>

Do you see any performance impact with this series ?
