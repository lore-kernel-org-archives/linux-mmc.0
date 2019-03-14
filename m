From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
Date: Thu, 14 Mar 2019 17:11:21 +0530
Message-ID: <b8d12a8a-2eed-bee9-2421-d8560b99703b@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
 <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
 <8d72ff93-e07f-52b9-da85-acd54f046694@ti.com>
 <63b6631d-86e7-b8ef-ffaf-40e7d4e96cfb@intel.com>
 <842caafd-1547-1ea6-faf0-27a85a912622@ti.com>
 <2a74ed21-2e6f-1ba3-3d49-6826a5ab3e66@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a74ed21-2e6f-1ba3-3d49-6826a5ab3e66@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 14/03/19 4:45 PM, Grygorii Strashko wrote:
> 
> 
> On 12.03.19 19:30, Rizvi, Mohammad Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 3/8/2019 7:06 PM, Adrian Hunter wrote:
>>> On 6/03/19 12:00 PM, Faiz Abbas wrote:
>>>> Adrian,
>>>>
>>>> On 25/02/19 1:47 PM, Adrian Hunter wrote:
>>>>> On 15/02/19 9:20 PM, Faiz Abbas wrote:
>>>>>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>>>>>> card insert/remove operations and a tasklet for finishing mmc requests.
>>>>>> With the addition of external dma support, dmaengine APIs need to
>>>>>> terminate in non-atomic context before unmapping the dma buffers.
>>>>>>
>>>>>> To facilitate this, remove the finish_tasklet and move the call of
>>>>>> sdhci_request_done() to the threaded_irq() callback.
>>>>>
>>>>> The irq thread has a higher latency than the tasklet.  The performance drop
>>>>> is measurable on the system I tried:
>>>>>
>>>>> Before:
>>>>>
>>>>> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
>>>>> 1+0 records in
>>>>> 1+0 records out
>>>>> 1073741824 bytes (1.1 GB) copied, 4.44502 s, 242 MB/s
>>>>>
>>>>> After:
>>>>>
>>>>> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
>>>>> 1+0 records in
>>>>> 1+0 records out
>>>>> 1073741824 bytes (1.1 GB) copied, 4.50898 s, 238 MB/s
>>>>>
>>>>> So we only want to resort to the thread for the error case.
>>>>>
>>>>
>>>> Sorry for the late response here, but this is about 1.6% decrease. I
>>>> tried out the same commands on a dra7xx board here (with about 5
>>>> consecutive dd of 1GB) and the average decrease was 0.3%. I believe you
>>>> will also find a lesser percentage change if you average over multiple
>>>> dd commands.
>>>>
>>>> Is this really so significant that we have to maintain two different
>>>> bottom halves and keep having difficulty with adding APIs that can sleep?
>>>
>>> It is a performance drop that can be avoided, so it might as well be.
>>> Splitting the success path from the failure path is common for I/O drivers
>>> for similar reasons as here: the success path can be optimized whereas the
>>> failure path potentially needs to sleep.
>>
>> Understood. You wanna keep the success path as fast as possible.
> 
> Sry, I've not completely followed this series, but I'd like to add 5c
> 
> It's good thing to get rid of tasklets hence RT Linux kernel is actively moving towards to LKML
> and there everything handled in threads (even networking trying to get rid of softirqs).
> 
> Performance is pretty relative thing here - just try to run network traffic in parallel, and
> there are no control over it comparing to threads. Now way to assign priority or pin to CPU.

There is a 2007 LWN article(https://lwn.net/Articles/239633/) which
talks about removing tasklets altogether. I wonder what happened after that.

Thanks,
Faiz
