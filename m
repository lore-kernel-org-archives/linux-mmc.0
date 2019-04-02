From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
Date: Tue, 2 Apr 2019 13:29:10 +0530
Message-ID: <987a3616-8530-7247-ce00-6513a6c2d4bc@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
 <CAPDyKFqN4s1CZa9z5C3YzCUO01V-=Xhtao5352Pmytd-Tusv9A@mail.gmail.com>
 <65f24027-005a-4372-8819-45e6a360bfce@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65f24027-005a-4372-8819-45e6a360bfce@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon <kishon@ti.com>, Chunyan Zhang <zhang.chunyan@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 26/03/19 1:03 PM, Adrian Hunter wrote:
> On 18/03/19 11:33 AM, Ulf Hansson wrote:
>> + Arnd, Grygorii
>>
>> On Fri, 15 Feb 2019 at 20:17, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>
>>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>>> card insert/remove operations and a tasklet for finishing mmc requests.
>>> With the addition of external dma support, dmaengine APIs need to
>>> terminate in non-atomic context before unmapping the dma buffers.
>>>
>>> To facilitate this, remove the finish_tasklet and move the call of
>>> sdhci_request_done() to the threaded_irq() callback. Also move the
>>> interrupt result variable to sdhci_host so it can be populated from
>>> anywhere inside the sdhci_irq handler.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>
>> Adrian, I think it makes sense to apply this patch, even if there is
>> very minor negative impact throughput wise.
>>
>> To me, it doesn't seems like MMC/SD/SDIO has good justification for
>> using tasklets, besides from the legacy point of view, of course.
>> Instead, I think we should try to move all mmc hosts into using
>> threaded IRQs.
>>
>> So, what do you think? Can you overlook the throughput drop and
>> instead we can try to recover this on top with other optimizations?
> 
> I tend to favour good results as expressed here:
> 
> 	https://lkml.org/lkml/2007/6/22/360
> 
> So I want to do optimization first.
> 
> But performance is not the only problem with the patch.  Give me a few
> days and I will see what I can come up with.
> 

Gentle ping on this.

Thanks,
Faiz
