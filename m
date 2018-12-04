From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/3] Tuning Fixes for sdhci-omap
Date: Tue, 4 Dec 2018 13:57:34 +0530
Message-ID: <492f4851-8068-d20b-68e8-ece0fa493b05@ti.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
 <3f64fb93-ecdd-d439-1001-be8117f63990@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f64fb93-ecdd-d439-1001-be8117f63990@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On 21/11/18 4:53 PM, Adrian Hunter wrote:
> On 21/11/18 12:33 PM, Faiz Abbas wrote:
>> The following patches fix tuning related errors in the
>> sdhci-omap driver.
>>
>> v2:
>> Added Fixes and stable tags for patch 1.
>> Re-enable DCRC in patch 1 only if it was enabled before
>> Squashed patches 2 & 3
>>
>> Faiz Abbas (3):
>>   mmc: sdhci-omap: Fix DCRC error handling during tuning
>>   mmc: sdhci-omap: Add platform specific reset callback
>>   mmc: sdhci-omap: Remove redundant structure assignments
>>
>>  drivers/mmc/host/sdhci-omap.c | 36 ++++++++++++++++++++++++++---------
>>  1 file changed, 27 insertions(+), 9 deletions(-)
>>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Gentle ping.

Thanks,
Faiz
