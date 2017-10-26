From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: core: activate pre-erased multiple write support
 for sd card
Date: Thu, 26 Oct 2017 14:32:00 +0300
Message-ID: <7f44a238-28f6-a020-cfda-9696a873b2ec@intel.com>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
 <699af9d0-c69b-e02b-54c1-7b0dd3f5369c@rock-chips.com>
 <CAPDyKFrdXPp4+Gu_2uE_Kdw0vLFC3uQ7ZBc9kYa+HKCgYc06Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26542 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbdJZLi4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Oct 2017 07:38:56 -0400
In-Reply-To: <CAPDyKFrdXPp4+Gu_2uE_Kdw0vLFC3uQ7ZBc9kYa+HKCgYc06Vg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 26/10/17 13:46, Ulf Hansson wrote:
> On 26 October 2017 at 03:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> Hi, Ulf
>>
>> On 2017/9/27 11:40, Shawn Lin wrote:
>>>
>>> Per SD specification version 4.10, section 4.3.4, it says "pre-erased
>>> (ACMD23) will make a following Multiple Block Write operation faster
>>> compared to the same operation without preceding ACMD23". ACMD23 is
>>> mandatory for all sd cards and the spec also says "Command STOP_TRAN
>>> (CMD12) shall be used to stop the transmission in Write Multiple Block
>>> whether or not the preerase (ACMD23) feature is used."
>>
>>
>> Ping... :)
> 
> Hi Shawn,
> 
> Actually I was waiting for confirmation from Jan about his tests.
> 
> However, overall the series looks reasonable to me.

Obviously the blk-mq patches do not have support for this.  Please apply the
blk-mq patches first.

What were the performance numbers?
