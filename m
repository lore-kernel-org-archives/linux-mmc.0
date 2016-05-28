From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: Fw:Re: [RFC PATCH 0/4] Command Queueing Support in eMMC
Date: Sat, 28 May 2016 20:54:38 +0800
Message-ID: <2745a917-c7d5-cf9b-8846-c49c945a0be4@rock-chips.com>
References: <593930816.1359719.1464439518694.JavaMail.xmail@wmthree-4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <593930816.1359719.1464439518694.JavaMail.xmail@wmthree-4>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Dong Aisheng <dongas86@gmail.com>, Doug Anderson <dianders@google.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

> On Tue, Dec 2, 2014 at 7:53 PM, Asutosh Das <asutoshd@codeaurora.org> wrote:
>> In this patch series, we propose a method to add support for
>> Command Queueing(CQ) feature added to eMMC-5.1 specification.

Is anyone still pushing it forward?
I have been trying to rebase it to 4.7 for testing but I think
it should be better to ping this thread firstly to see if you guys have
already done it. :)

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
>>   mmc: queue: initialization of command-queue support
>>   mmc: card: Add eMMC command queuing support in mmc block layer
>>   mmc: cmdq: support for command queue enabled host
>>   mmc: sdhci: add command queue support to sdhci
>>
>> Sujit Reddy Thumma (1):
>>   mmc: core: Add support to read command queue parameters
>>
>>  drivers/mmc/card/block.c   | 378
> ++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/mmc/card/queue.c   | 160 ++++++++++++++++++-
>>  drivers/mmc/card/queue.h   |   9 +-
>>  drivers/mmc/core/core.c    |  87 +++++++++++
>>  drivers/mmc/core/mmc.c     |  19 +++
>>  drivers/mmc/core/mmc_ops.c |  45 ++++--
>>  drivers/mmc/host/Kconfig   |  12 ++
>>  drivers/mmc/host/Makefile  |   1 +
>>  drivers/mmc/host/sdhci.c   |  89 +++++++++++
>>  drivers/mmc/host/sdhci.h   |   2 +
>>  include/linux/mmc/card.h   |  10 +-
>>  include/linux/mmc/core.h   |  14 ++
>>  include/linux/mmc/host.h   |  72 +++++++++
>>  include/linux/mmc/mmc.h    |   9 ++
>>  include/linux/mmc/sdhci.h  |   1 +
>>  15 files changed, 887 insertions(+), 21 deletions(-)
>>
>



-- 
Best Regards
Shawn Lin
