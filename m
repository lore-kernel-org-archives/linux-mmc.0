From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v12 6/9] mmc: cavium: Add MMC PCI driver for ThunderX SOCs
Date: Thu, 23 Mar 2017 10:41:23 -0700
Message-ID: <3146b3ef-a3c2-902d-2157-11425e6fc138@caviumnetworks.com>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <20170310132507.32025-7-jglauber@cavium.com>
 <CAPDyKFp2-KOSYy41QCFcqdU_Rzfncea8Q4QvjHSmho+tAMYMKg@mail.gmail.com>
 <20170323085812.GA2250@hardcore>
 <CAPDyKFqzpu1GiRCO5cVQ8yOPg-6CVRUFJSWWW5bLmh99vn+38g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn3nam01on0086.outbound.protection.outlook.com ([104.47.33.86]:31881
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932967AbdCWRl3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Mar 2017 13:41:29 -0400
In-Reply-To: <CAPDyKFqzpu1GiRCO5cVQ8yOPg-6CVRUFJSWWW5bLmh99vn+38g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>

On 03/23/2017 02:28 AM, Ulf Hansson wrote:
> On 23 March 2017 at 09:58, Jan Glauber <jan.glauber@caviumnetworks.com> wrote:
>> On Fri, Mar 17, 2017 at 03:58:26PM +0100, Ulf Hansson wrote:
>>> On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
>>>> Add a platform driver for ThunderX ARM SOCs.
>>>>
>>>> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>>>> ---
>>>>  drivers/mmc/host/Kconfig               |  10 ++
>>>>  drivers/mmc/host/Makefile              |   2 +
>>>>  drivers/mmc/host/cavium-mmc.h          |  10 +-
>>>>  drivers/mmc/host/cavium-pci-thunderx.c | 198 +++++++++++++++++++++++++++++++++
>>>>  4 files changed, 218 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/mmc/host/cavium-pci-thunderx.c
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 68cc811..3983dee 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -632,6 +632,16 @@ config MMC_CAVIUM_OCTEON
>>>>
>>>>           If unsure, say N.
>>>>
>>>> +config MMC_CAVIUM_THUNDERX
>>>> +       tristate "Cavium ThunderX SD/MMC Card Interface support"
>>>> +       depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
>>>> +       select GPIO_THUNDERX
>>>
>>> Do you really need to select GPIO_THUNDERX? What is the relationship?
>>
>> I don't know much about gpio, but in the end despite all these layers
>> there must be a gpio set function called doing the writeq on our SOC
>> to enable/disable the power gpio, right?
>>
>> GPIO_THUNDERX implements this gpio set function for Cavium's SOC.
>
> Got it. However using "select" should be avoided.
>
> Please use "depends on GPIOLIB" instead. The select of "GPIO_THUNDERX"
> should be done part of the defconfig or via an SoC specifc Kconfig
> file.
>

Thanks, I think that is the cleanest approach.

We may want to add an MSI-X dependency as well, as legacy interrupts are 
not supported by the hardware.

David.

