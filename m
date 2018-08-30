From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
Date: Thu, 30 Aug 2018 08:59:55 +0300
Message-ID: <48e8ec2c-c3e3-ad08-2c1e-a0feb9ba0820@intel.com>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
 <1535526184-32718-8-git-send-email-zhang.chunyan@linaro.org>
 <a38f8d87-a373-5de4-c3b5-bba68f8ffeec@intel.com>
 <CAAfSe-s-W467D2dk-_7AWQz9ZaysROf5otoN-o-yu3Eu5ZVC4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAfSe-s-W467D2dk-_7AWQz9ZaysROf5otoN-o-yu3Eu5ZVC4g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>
List-Id: linux-mmc@vger.kernel.org

On 29/08/18 14:39, Chunyan Zhang wrote:
> On 29 August 2018 at 18:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 29/08/18 10:03, Chunyan Zhang wrote:
>>> When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
>>> register (05Fh-058h) instead of using register (000h-004h) to indicate
>>> its system address of data location. The register (000h-004h) is
>>> re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
>>> may use Auto CMD23.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 62d843ac90..ac92e0f 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3834,10 +3834,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>       if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>>>               host->flags |= SDHCI_AUTO_CMD12;
>>>
>>> -     /* Auto-CMD23 stuff only works in ADMA or PIO. */
>>> +     /*
>>> +      * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;
>>
>> ; -> .
>>
>>> +      * For v4 mode, SDMA may use Auto-CMD23 as well.
>>> +      */
>>>       if ((host->version >= SDHCI_SPEC_300) &&
>>>           ((host->flags & SDHCI_USE_ADMA) ||
>>> -          !(host->flags & SDHCI_USE_SDMA)) &&
>>> +          (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
>>> +          (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
>>>            !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>>
>> This is over complicated.  We can use auto-CMD23 if not using SDMA or if in
>> v4_mode i.e.
>>
>>         if (host->version >= SDHCI_SPEC_300 &&
>>             (!(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
>>             !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>>
> 
> So no matter whether SDHCI_USE_ADMA is selected, right?

Yes

> 
>>>               host->flags |= SDHCI_AUTO_CMD23;
>>>               DBG("Auto-CMD23 available\n");
>>>
>>
> 
