From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Tue, 28 May 2019 14:02:12 +0530
Message-ID: <68fd3e6e-666e-2ebf-04c9-8cb310f1404a@ti.com>
References: <20190510034228.32211-1-faiz_abbas@ti.com>
 <20190510034228.32211-4-faiz_abbas@ti.com>
 <0662a705-1991-e854-21a4-4ff6b5533f13@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0662a705-1991-e854-21a4-4ff6b5533f13@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 10/05/19 11:28 AM, Adrian Hunter wrote:
> On 10/05/19 6:42 AM, Faiz Abbas wrote:
>> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
>> fields are exchanged. Fix this. This didn't have any affect on the
>> driver because this was a NOP and it was taking the correct value from
>> the bootloader.
>>
>> Cc: stable <stable@vger.kernel.org>
> 
> Except that it doesn't apply to stable because of patch 1.  Maybe make this
> the first patch.
> 

Ok. Sending v3 with this as first patch.

Thanks,
Faiz
