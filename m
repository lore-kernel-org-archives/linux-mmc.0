From: Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: set non-removable in ACPI table
Date: Thu, 10 Dec 2015 15:57:16 -0500
Message-ID: <5669E72C.4090701@codeaurora.org>
References: <1449150480-1173-1-git-send-email-pelcan@codeaurora.org> <56604E57.9000201@intel.com> <5661B3F0.2010000@codeaurora.org> <5665438B.10104@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <5665438B.10104@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.org>, Mark Langsdorf <mlangsdo@redhat.com>, harba@codeaurora.org
List-Id: linux-mmc@vger.kernel.org


On 12/07/2015 03:30 AM, Adrian Hunter wrote:
> On 04/12/15 17:40, Philip Elcan wrote:
>> On 12/03/2015 09:14 AM, Adrian Hunter wrote:
>>> On 03/12/15 15:48, Philip Elcan wrote:
>>>> This allows setting an SDHC controller as non-removable
>>>> by using the _RMV method in the ACPI table. It doesn't
>>> Is that _RMV on the host controller?  Shouldn't it be on the card i.e. child
>>> device node?
>> Yes, this is on the host controller. The ACPI table only describes the
>> host controller, not the child nodes.
>>
> If you look at Intel devices, the _RMV is on the child e.g.
>
>         Device (SDHA)
>         {
>             Name (_HID, "80860F14")  // _HID: Hardware ID
>             Name (_CID, "PNP0D40")  // _CID: Compatible ID
>             Name (_DDN, "Intel(R) eMMC Controller - 80860F14")  // _DDN: DOS Device Name
> 	    ...
>             Device (EMMD)
>             {
> 		...
>                 Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
>                 {
>                     Return (Zero)
>                 }
>             }
>         }
>
> I am not an ACPI expert but that seems like the correct place for it.
My understanding is that in ACPI you don't generally create child devices on buses that are discoverable.
>
>>>> mark it as non-removable if GPIO card detection is
>>>> already setup.
>>>>
>>>> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
>>>> ---
>>>>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
