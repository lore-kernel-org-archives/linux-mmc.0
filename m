From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHv2 06/10] mmc: core: move the cookie's enum values from
 sdhci.h to mmc.h
Date: Wed, 16 Nov 2016 11:04:03 +0200
Message-ID: <3e05ec88-af1d-9996-bbdb-c453f7e4bb07@intel.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <CGME20161115101332epcas2p2c10c90b955b427a510ed8f9631b3fdfe@epcas2p2.samsung.com>
 <20161115101232.3854-7-jh80.chung@samsung.com>
 <12405f58-695d-03d8-407f-d7471e93a6de@samsung.com>
 <ecb4b5d0-4cbf-bf44-3287-f1580b2e990a@intel.com>
 <89535076-4a77-64a5-68d9-ce15e03b8fb3@samsung.com>
 <d5321daf-b449-e556-ccf1-cd82d497ea85@intel.com>
 <4168313a-07bc-00a7-ecc8-1ca4978c4d8c@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51576 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932797AbcKPJJC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Nov 2016 04:09:02 -0500
In-Reply-To: <4168313a-07bc-00a7-ecc8-1ca4978c4d8c@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org

On 16/11/16 10:58, Jaehoon Chung wrote:
> On 11/16/2016 05:28 PM, Adrian Hunter wrote:
>> On 16/11/16 10:25, Jaehoon Chung wrote:
>>> On 11/16/2016 05:09 PM, Adrian Hunter wrote:
>>>> On 16/11/16 09:53, Jaehoon Chung wrote:
>>>>> Added Adrian for sdhci.h
>>>>>
>>>>> On 11/15/2016 07:12 PM, Jaehoon Chung wrote:
>>>>>> It's not for only sdhci controller.
>>>>>> So it can be moved from sdhci.h to mmc.h. And renamed from sdhci_cookie
>>>>>> to mmc_cookie.
>>>>
>>>> The cookie is currently host private data, so I don't understand the
>>>> motivation behind this.
>>>
>>> dwmmc controller can also use the data->host_cookie. because it's working with post/pre_req().
>>>
>>> So i think it can be used about both sdhci and dwmmc.
>>> Is there no reason that add the private dwmmc data?
>>>
>>> With these cookie value, update the dwmmc controller for post/pre_req().
>>>
>>> https://patchwork.kernel.org/patch/9429287/
>>
>> So why not define dwmmc cookies in dw_mmc.c ?
> 
> Because I understood that it's not sdhci specific cookies. It can be used generally, doesn't?
> 
> Role of post/pre_req() in host controller is the doing dma_map/unmap().
> And data's cookies only needs to notice whether dma is mapped or unmapped, etc.
> 
> Well, If it's really private value and should be added other cookies values in future, i will put cookies in dw_mmc.h.
> (it should be duplicated in sdhci and dwmmc.)

Probably all host controllers should do cookies the same way, but they don't
at the moment, so there is no reason to share definitions.

