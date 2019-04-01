From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under
 special conditions
Date: Mon, 1 Apr 2019 16:14:21 +0530
Message-ID: <51104203-068b-a25c-299b-ac9a2f720680@ti.com>
References: <20190329142202.15000-1-faiz_abbas@ti.com>
 <20190329142202.15000-2-faiz_abbas@ti.com>
 <f1417015-0e78-6df5-7917-a33e235fa1a9@intel.com>
 <350cd133-302f-4002-4b54-d95e7e5d3500@ti.com>
 <6d8f9b8c-dd5c-a091-7a82-10e5f6606b4e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6d8f9b8c-dd5c-a091-7a82-10e5f6606b4e@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 01/04/19 2:42 PM, Adrian Hunter wrote:
> On 1/04/19 12:01 PM, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 01/04/19 2:21 PM, Adrian Hunter wrote:
>>> On 29/03/19 4:22 PM, Faiz Abbas wrote:
>>>> Some controllers on TI devices requires the HISPD bit to be cleared
>>>> even in some high speed modes. Add a quirk that facilitates this
>>>> requirement.
>>>
>>> Could you use sdhci I/O accessors for this?
>>
>> Can you elaborate? Not sure how this would be solved with
>> CONFIG_MMC_SDHCI_IO_ACCESSORS.
> 
> In ->writeb()
> 
> if (reg == SDHCI_HOST_CONTROL) {
> 	if (host->mmc->ios->timing == whatever)
> 		val &= ~SDHCI_CTRL_HISPD;
> }
> 
> writeb(val, host->ioaddr + reg);

This is a really good idea. Will use it in v2. Thanks.

Regards,
Faiz
