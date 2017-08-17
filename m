From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 6/7] mmc: sdhci-omap: Add OMAP SDHCI driver
Date: Thu, 17 Aug 2017 11:23:34 +0300
Message-ID: <158e88c4-da08-6091-96ed-daa8467b6e69@intel.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-7-kishon@ti.com>
 <a45cf402-26c9-d9d0-1ca0-cbeeddad388c@intel.com>
 <46568bdf-c11f-e04b-edd4-25d5363ae504@ti.com>
 <0b109f07-f7f3-1a12-0c65-45d96eb23b13@intel.com>
 <7822a805-3379-1d08-5a01-f422ab23f863@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:60016 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbdHQIaE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Aug 2017 04:30:04 -0400
In-Reply-To: <7822a805-3379-1d08-5a01-f422ab23f863@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 17/08/17 10:59, Kishon Vijay Abraham I wrote:
> Hi Adrian,
> 
> On Thursday 17 August 2017 12:13 PM, Adrian Hunter wrote:
>> On 17/08/17 08:57, Kishon Vijay Abraham I wrote:
>>> Hi Adrian,
>>>
>>> On Tuesday 15 August 2017 01:52 PM, Adrian Hunter wrote:
>>>> On 07/08/17 19:01, Kishon Vijay Abraham I wrote:

<SNIP>

>>>>> +	pm_runtime_enable(dev);
>>>>> +	ret = pm_runtime_get_sync(dev);
>>>>
>>>> What are you trying to do with runtime pm?  There don't seem to be any pm
>>>> callbacks, so does this do anything?
>>>
>>> yeah, pm_runtime_get_sync enables the functional clock and also configures the
>>> SYSCONFIG regiters present in the controller. It gets the details for
>>> configuring those from arch/arm/mach-omap2/omap_hwmod_*
>>
>> You mean it will do those things when you add the callbacks?  I would prefer
>> you leave out runtime pm until you can add the callbacks as well.
> 
> No. Generally in callbacks, 'optional' functional clocks are enabled. But main
> functional clock and interface clocks are enabled in pm_runtime_get_sync.
> Without pm_runtime_get_sync, we won't be able to access controller registers.

So that is done by the pm domain?  Please add comments to the code to explain.
