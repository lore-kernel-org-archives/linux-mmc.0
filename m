From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add Support for Command Queuing
 Engine to J721E
Date: Wed, 20 Nov 2019 21:41:14 +0530
Message-ID: <1cdaf572-02ee-d3d8-beb3-c90e1cfd89fa@ti.com>
References: <20191118073609.22921-1-faiz_abbas@ti.com>
 <ea458eb9-f9a8-ab39-2df9-6284fef02105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ea458eb9-f9a8-ab39-2df9-6284fef02105@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Adrian,

On 20/11/19 1:29 PM, Adrian Hunter wrote:
> On 18/11/19 9:36 AM, Faiz Abbas wrote:
>> Add Support for CQHCI (Command Queuing Host Controller Interface)
>> for each of the host controllers present in TI's J721E devices.
>> Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> That "Reported-by" should not be there.
> 

The robot asked me to add the tag in its reply to v1. Not sure where
they wanted me to add it.

Thanks,
Faiz
