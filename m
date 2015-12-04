From: "Das, Asutosh (asd)" <asutoshd@codeaurora.org>
Subject: Re: [RFC PATCH 0/4] Command Queueing Support in eMMC
Date: Fri, 4 Dec 2015 10:10:36 +0530
Message-ID: <56611944.5000004@codeaurora.org>
References: <cover.1417519249.git.asutoshd@codeaurora.org>
 <CAA+hA=Ts4nF4qMmTbEQr40FYgpxHmzrJxwPu4gRZ2dCcs+zOWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAA+hA=Ts4nF4qMmTbEQr40FYgpxHmzrJxwPu4gRZ2dCcs+zOWA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

+ Kostya
Hi Aisheng,
Yes, a colleague of mine is working on upstreaming it. It should be done 
within a week or so.

On 12/3/2015 9:12 AM, Dong Aisheng wrote:
> Hi Asutosh,
>
> On Tue, Dec 2, 2014 at 7:53 PM, Asutosh Das <asutoshd@codeaurora.org> wrote:
>> In this patch series, we propose a method to add support for
>> Command Queueing(CQ) feature added to eMMC-5.1 specification.
>> This feature includes new commands for issuing tasks to the
>> device and orders the execution of tasks to the device. It
>> also has task management functions.
>>
>> The initialization of CQ is decided based on the underlying
>> driver capability and the capability advertised by the card
>> through ext_csd.
>>
>> We have selectively adopted the scsi design of pulling in
>> requests from kernel block layer.
>>
>> In order to support queueing of multiple requests, we have
>> added a new issue function to mmc-queue. This selectively
>> pulls the requests and prepares and issues it to the underlying
>> driver. We have used the inherent tagging mechanism of kernel
>> block layer to keep track and map tags to the slots of underlying
>> driver. The current design doesn't block for the request to
>> complete. We have separated the issuing and completion path
>> of the request and tracking is done using the tag assigned to
>> the request.
>>
>> We have introduced a number of APIs to mmc block layer to
>> facilitate servicing of requests.
>>
>> The completion of requests is handled in a softirq registered
>> with the kernel block layer during initialization. The error
>> handling however would be done using a workqueue and is under
>> development.
>>
>> We have separated the legacy eMMC code from CQ code, so as to
>> make it more manageable.
>>
>> A new layer has been introduced to serve the CQ compliant drivers.
>> This layer (cq_hci) has all the standard functionality implemented.
>> It also has necessary hooks for convenience of platform drivers.
>>
>> Asutosh Das (4):
>>    mmc: queue: initialization of command-queue support
>>    mmc: card: Add eMMC command queuing support in mmc block layer
>>    mmc: cmdq: support for command queue enabled host
>>    mmc: sdhci: add command queue support to sdhci
>>
>> Sujit Reddy Thumma (1):
>>    mmc: core: Add support to read command queue parameters
>>
>>   drivers/mmc/card/block.c   | 378 ++++++++++++++++++++++++++++++++++++++++++++-
>>   drivers/mmc/card/queue.c   | 160 ++++++++++++++++++-
>>   drivers/mmc/card/queue.h   |   9 +-
>>   drivers/mmc/core/core.c    |  87 +++++++++++
>>   drivers/mmc/core/mmc.c     |  19 +++
>>   drivers/mmc/core/mmc_ops.c |  45 ++++--
>>   drivers/mmc/host/Kconfig   |  12 ++
>>   drivers/mmc/host/Makefile  |   1 +
>>   drivers/mmc/host/sdhci.c   |  89 +++++++++++
>>   drivers/mmc/host/sdhci.h   |   2 +
>>   include/linux/mmc/card.h   |  10 +-
>>   include/linux/mmc/core.h   |  14 ++
>>   include/linux/mmc/host.h   |  72 +++++++++
>>   include/linux/mmc/mmc.h    |   9 ++
>>   include/linux/mmc/sdhci.h  |   1 +
>>   15 files changed, 887 insertions(+), 21 deletions(-)
>>
> Are you still working on this?
> Is there a updated version and any upstream plan?
> I'm going to verify it.
>
> Regards
> Dong Aisheng
>
>> --
>> 1.8.2.1
>>
>> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
