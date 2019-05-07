From: Faiz Abbas <a0230074@ti.com>
Subject: Re: [PATCH 1/2] mmc: sdhci_am654: Fix minor phy configurations
Date: Tue, 7 May 2019 21:59:06 +0530
Message-ID: <2c867970-1255-b11f-9edf-ff002b7cea58@ti.com>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-2-faiz_abbas@ti.com>
 <8317e8a0-1b1f-4b0d-8a9b-2a6fdd0ab4e5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8317e8a0-1b1f-4b0d-8a9b-2a6fdd0ab4e5@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 26/04/19 11:20 AM, Adrian Hunter wrote:
> On 25/04/19 6:57 PM, Faiz Abbas wrote:
>> Fix the following minor things:
>>
>> 1. Line wrapping with the regmap_*() functions is way more conservative
>> than required by the 80 character rule. Expand the function calls out to
>> use less number of lines.
>>
>> 2. Add an error message if the DLL fails to lock.
> 
> Please make the white space changes a separate patch.
> 
> Also I would prefer not to use "fix" in the subject unless the patch fixes
> driver behaviour.
> 

Ok. Two different patches. No "fix" in the subject. Sending v2.

Thanks,
Faiz
