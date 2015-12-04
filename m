From: Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: set non-removable in ACPI table
Date: Fri, 04 Dec 2015 10:40:32 -0500
Message-ID: <5661B3F0.2010000@codeaurora.org>
References: <1449150480-1173-1-git-send-email-pelcan@codeaurora.org> <56604E57.9000201@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56604E57.9000201@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.org>, Mark Langsdorf <mlangsdo@redhat.com>
List-Id: linux-mmc@vger.kernel.org


On 12/03/2015 09:14 AM, Adrian Hunter wrote:
> On 03/12/15 15:48, Philip Elcan wrote:
>> This allows setting an SDHC controller as non-removable
>> by using the _RMV method in the ACPI table. It doesn't
> Is that _RMV on the host controller?  Shouldn't it be on the card i.e. child
> device node?

Yes, this is on the host controller. The ACPI table only describes the
host controller, not the child nodes.

>
>> mark it as non-removable if GPIO card detection is
>> already setup.
>>
>> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
>> ---
>>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
