From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Wed, 8 May 2019 09:04:20 +0300
Message-ID: <755f5c9f-922b-4f29-982a-cc411897b063@intel.com>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-3-faiz_abbas@ti.com>
 <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
 <db0b0790-4556-8a3b-2ae1-fcb4b1beb4b3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <db0b0790-4556-8a3b-2ae1-fcb4b1beb4b3@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <a0230074@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 7/05/19 7:27 PM, Faiz Abbas wrote:
> Hi Adrian,
> 
> On 26/04/19 11:30 AM, Adrian Hunter wrote:
>> On 25/04/19 6:57 PM, Faiz Abbas wrote:
>>> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
>>> fields are exchanged. Fix this.
>>
>> Could you also comment on whether this has any known effect on the driver.
>>
> 
> This call was basically a NOP but it was the correct way around in
> u-boot so it was just taking that value instead. No effect that was
> known to me. Found this out just by inspection.

Please put that in the commit message.
