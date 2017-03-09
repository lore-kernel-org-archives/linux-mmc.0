From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V1 00/18] mmc: Add Command Queue support
Date: Thu, 9 Mar 2017 10:52:52 +0200
Message-ID: <ccbc769c-438d-361a-12d5-2d08ade2a85e@intel.com>
References: <CGME20170306091701epcas4p30ef050e2e5bd1616457a6347de9b6717@epcas4p3.samsung.com>
 <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
 <60109e5e-b1de-dc47-f6ce-d921d2a459ca@samsung.com>
 <9d57e64f-2c58-dc2b-8e23-9ae69fba8300@intel.com>
 <9ca26b16-ffda-dc95-5a5c-958817e23f58@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58311 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753457AbdCIJXe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Mar 2017 04:23:34 -0500
In-Reply-To: <9ca26b16-ffda-dc95-5a5c-958817e23f58@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 08/03/17 15:27, Jaehoon Chung wrote:
> On 03/08/2017 05:08 PM, Adrian Hunter wrote:
>> On 08/03/17 07:18, Jaehoon Chung wrote:
>>> Hi Adrian,
>>>
>>> On 03/06/2017 06:10 PM, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Here are the hardware command queue patches without the software command
>>>> queue patches or sdhci patches.
>>>
>>> I don't see your patches fully yet, but after applied your patches, dwmmc host doesn't work.
>>> So I'm finding what happen in dwmmc controller.
>>> After finding problem, i will share it.
>>> Well,.. maybe i missed something...
>>
>> Thanks for trying these patches.
>>
>> With no host controller yet using CQE, there isn't much changing in this
>> patch set, but bisecting should reveal the first bad commit.
> 
> https://patchwork.kernel.org/patch/9605315/
> 
> It seems that this patch has a problem...Tomorrow i will check in more detail.
> Because I saw the different error logs..
> Sometime occurred the NULL pointer dereference or I/O error..
> 

It looks like that patch is dependent on one of the software command queue
patches that I dropped.

