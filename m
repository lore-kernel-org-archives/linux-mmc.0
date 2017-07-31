From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 00/11] mmc: Add Command Queue support
Date: Mon, 31 Jul 2017 09:54:03 +0300
Message-ID: <d4cd5e66-62c7-2618-0259-39728fd68af1@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <20fd5318-eeca-6c85-39fe-8b6a32321115@rock-chips.com>
 <cbe0361a-0a8f-efed-cef0-c8d0da691ff7@intel.com>
 <8746b642-4a5d-a03d-319c-a355afef4616@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44808 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbdGaHA1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Jul 2017 03:00:27 -0400
In-Reply-To: <8746b642-4a5d-a03d-319c-a355afef4616@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 25/07/17 03:34, Shawn Lin wrote:
> Hi
> 
> On 2017/7/24 18:09, Adrian Hunter wrote:
>> On 24/07/17 12:17, Shawn Lin wrote:
>>> Hi Adrian,
>>>
>>> On 2017/7/21 17:49, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Here is V4 of the hardware command queue patches without the software
>>>> command queue patches.
>>>>
>>>
>>> I see this log for the reboot test last weekend. One of my boards
>>> seems to easily trigger this WARN_ONCE.
>>>
>>> [   10.012778] mmc1: cqhci: spurious TCN for tag 31
>>
>> Tag 31 is DCMD.  DCMD can be problematic which is one of the reasons it is
>> optional.  In this case it looks like you are getting a TCN before the DCMD
>> is actually finished.  You should be able to see if that is the case by
> 
> yes, it is that case you refer to.
> 
>> dumping the registers when it happens, although you will need to stop
>> messages going to the console because that will be too slow.
> 
> okay, I will remove DCMD caps for the test and see what we could
> do to make DCMD more robust later.
> 

Are you going to do more review of CQ?

