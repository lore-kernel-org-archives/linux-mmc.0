From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
Date: Tue, 20 Jun 2017 12:04:44 +0300
Message-ID: <453a9fbc-c827-367e-f953-fbc9d6457375@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFp=rrQbSAGMx=UF2abcLmzWjO4syq7eLAmChT_EQNvDgg@mail.gmail.com>
 <faa2a3d8-e045-8bd1-06c9-e5cf64713035@intel.com>
 <CACRpkdYBB1ZMnvCKet706bm12B3DWnie=0uDri835R_f81gMUw@mail.gmail.com>
 <AM4PR0401MB23244CD809159EF1CD897160901F0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <8009319e-356e-0b69-a30a-31b536f3643a@intel.com>
 <AM4PR0401MB2324C8B330EB320BFB35443590C00@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <AM4PR0401MB232449B222AA0A9FA7603A9B90C50@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44148 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdFTJK4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Jun 2017 05:10:56 -0400
In-Reply-To: <AM4PR0401MB232449B222AA0A9FA7603A9B90C50@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 20/06/17 11:01, Bough Chen wrote:
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Bough Chen
>> Sent: Thursday, June 15, 2017 7:50 PM
>> To: Adrian Hunter <adrian.hunter@intel.com>; Linus Walleij
>> <linus.walleij@linaro.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>; Mateusz
>> Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
>> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
>> Dorfman Konstantin <kdorfman@codeaurora.org>; David Griego
>> <david.griego@linaro.org>; Sahitya Tummala <stummala@codeaurora.org>;
>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>> <vbyravarasu@nvidia.com>; Shawn Lin <shawn.lin@rock-chips.com>
>> Subject: RE: [PATCH V2 00/22] mmc: Add Command Queue support
>>
>>> -----Original Message-----
>>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>>> Sent: Thursday, June 15, 2017 7:38 PM
>>> To: Bough Chen <haibo.chen@nxp.com>; Linus Walleij
>>> <linus.walleij@linaro.org>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>;
>> Mateusz
>>> Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>>> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
>>> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
>>> Dorfman Konstantin <kdorfman@codeaurora.org>; David Griego
>>> <david.griego@linaro.org>; Sahitya Tummala <stummala@codeaurora.org>;
>>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>>> <vbyravarasu@nvidia.com>; Shawn Lin <shawn.lin@rock-chips.com>
>>> Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
>>>
>>> On 24/04/17 12:14, Bough Chen wrote:
>>>>> -----Original Message-----
>>>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>>>> owner@vger.kernel.org] On Behalf Of Linus Walleij
>>>>> Sent: Monday, April 24, 2017 4:13 PM
>>>>> To: Adrian Hunter <adrian.hunter@intel.com>
>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>>>>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>;
>>>>> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>>>>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>>>>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>>>>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>>>>> <kdorfman@codeaurora.org>; David Griego <david.griego@linaro.org>;
>>>>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>>>>> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
>>>>> Shawn Lin <shawn.lin@rock-chips.com>
>>>>> Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
>>>>>
>>>>> On Sat, Apr 22, 2017 at 9:45 AM, Adrian Hunter
>>>>> <adrian.hunter@intel.com>
>>>>> wrote:
>>>>>
>>>>>> Ulf and Linus have been doing a great job of keeping this moving,
>>>>>> but it would be nice to see some others taking more interest.  The
>>>>>> first command queue patches were posted in February 2014, over 3
>>>>>> years
>>> ago!
>>>>>
>>>>> I agree.
>>>>>
>>>>> I think both me & Ulf would also be doing more work if we had
>>>>> easily accessible hardware with upstream host controller support
>>>>> for native
>>> command queueing.
>>>>> (Hm, was just reading in libata about NCQ ...
>>>>> déja vu ... https://en.wikipedia.org/wiki/Native_Command_Queuing)
>>>>>
>>>>> Do we have some hardware with host-backed command queueing out
>>> there
>>>>> that is easily obtained and has upstream support for the basic system?
>>>>>
>>>>
>>>> The coming i.MX8 support hardware CMDQ, I will have a try when I get
>>>> one
>>> on May or June.
>>>
>>> I have sent updated patches.  Will you have a chance to test hardware CMDQ?
>>
>> Yes, I will try to apply these patches on our local 4.9 branch.  Will give you the
>> test result.
>>
> 
> Hi Adrian,
> 
> i.MX8 still not upstream, and just work on our local 4.9 branch, to test your branch, I need to cherry pick
> some mmc patches and block layer patches, I'm doing this now, but need some time.

Thanks for the update.  I realize backporting anything related to mmc block
is now a big task.

> 
> 
>> Best Regards,
>> Haibo Chen
>>   칻 & ~ &   +-  ݶ  w  ˛   m b  f ȧ   ܨ}   Ơz &j:+v        zZ+  +zf   h   ~    i   z  w   ?
>> & )ߢf

