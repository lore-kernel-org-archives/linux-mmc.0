From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 10/11] mmc: cqhci: support for command queue enabled
 host
Date: Mon, 31 Jul 2017 10:43:06 +0300
Message-ID: <7dde61a4-6b4a-39cf-f34f-27666280492a@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-11-git-send-email-adrian.hunter@intel.com>
 <AM4PR0401MB2324C6913207B78E8A71C24190BB0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <56c06a10-db37-d3e1-e9d6-5bdd214c7efd@intel.com>
 <36c36b83-08ff-df50-41af-d73ea6e57fdb@intel.com>
 <AM4PR0401MB2324CD0F80CECD1E3208B44290B20@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <c55921b3-48ed-e57b-0ac9-737a1c39931d@intel.com>
 <AM4PR0401MB2324363A89645B23D4D2D8D990B20@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56795 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbdGaHw7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Jul 2017 03:52:59 -0400
In-Reply-To: <AM4PR0401MB2324363A89645B23D4D2D8D990B20@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 31/07/17 10:18, Bough Chen wrote:
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: Monday, July 31, 2017 3:04 PM
>> To: Bough Chen <haibo.chen@nxp.com>; Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Alex Lemberg
>> <alex.lemberg@sandisk.com>; Mateusz Nowak <mateusz.nowak@intel.com>;
>> Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>> <kdorfman@codeaurora.org>; Sahitya Tummala <stummala@codeaurora.org>;
>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>> <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>; Shawn Lin
>> <shawn.lin@rock-chips.com>
>> Subject: Re: [PATCH V4 10/11] mmc: cqhci: support for command queue
>> enabled host
>>
>> On 31/07/17 10:03, Bough Chen wrote:
>>>> -----Original Message-----
>>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>>>> Sent: Monday, July 31, 2017 2:41 PM
>>>> To: Bough Chen <haibo.chen@nxp.com>; Ulf Hansson
>>>> <ulf.hansson@linaro.org>
>>>> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Alex Lemberg
>>>> <alex.lemberg@sandisk.com>; Mateusz Nowak
>> <mateusz.nowak@intel.com>;
>>>> Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>>>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>>>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>>>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>>>> <kdorfman@codeaurora.org>; Sahitya Tummala
>> <stummala@codeaurora.org>;
>>>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>>>> <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>;
>>>> Shawn Lin <shawn.lin@rock-chips.com>
>>>> Subject: Re: [PATCH V4 10/11] mmc: cqhci: support for command queue
>>>> enabled host
>>>>
>>>>
>>>> How is it going?
>>>
>>> Yes, the ->enable() callback is a good place to set the i.mx special
>>> config, now CMDQ can works well On our i.MX8.
>>
>> So your tested-by still applies, also to V4?
> 
> Yes, sure.
> 

Thank you!
