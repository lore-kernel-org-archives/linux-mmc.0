From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 1/7] mmc: sdhci: add sd host v4 mode
Date: Thu, 21 Jun 2018 16:15:16 +0300
Message-ID: <38c47bf5-d320-7767-59c1-958d1bbb6dc9@intel.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-2-git-send-email-zhang.chunyan@linaro.org>
 <1f3e7e87-be4e-37ab-af46-1c4e5dd79a1d@intel.com>
 <CAAfSe-ug+M7DO7S1KKQ43FcrRgfGqEpikvivgjBjih8yuTU0sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAfSe-ug+M7DO7S1KKQ43FcrRgfGqEpikvivgjBjih8yuTU0sg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>
List-Id: linux-mmc@vger.kernel.org

On 21/06/18 14:14, Chunyan Zhang wrote:
> On 21 June 2018 at 18:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 15/06/18 05:04, Chunyan Zhang wrote:
>>> For SD host controller version 4.00 or later ones, there're two
>>> modes of implementation - Version 3.00 compatible mode or
>>> Version 4 mode.  This patch introduces a flag to record this.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 6 ++++++
>>>  drivers/mmc/host/sdhci.h | 6 ++++++
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 2ededa7f..cf5695f 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3302,6 +3302,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>>>       v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>>>       host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
>>>
>>> +     if (host->version >= SDHCI_SPEC_400) {
>>> +             if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
>>> +                     SDHCI_CTRL_V4_MODE)
>>> +                     host->v4_mode = true;
>>> +     }
>>
>> At this point the host controller has just been reset which would mean it
>> must be in version 3 compatibility mode, which would mean this code doesn't
>> do anything.
> 
> Why is it version 3 mode at this point?

According to the specification, reset clears RW fields to zero.

> 
> I've tested this code on the sd host controller which was introduced
> in 6/7 in this patch-set, the result showed that it was v4_mode.
> Moreover without this patch, the Spreadtrum's sdhci driver in patch
> 6/7 couldn't work.
> 
> Am I missing something here?

It seems the Spreadtrum controller doesn't clear the "Host Version 4 Enable"
bit upon software reset for all.

Also this seems the wrong way around.  The driver should decide whether or
not to use V4 mode and then the "Host Version 4 Enable" bit should be set
accordingly.

V4 has been around so long that we can't just enable all supporting hardware
without risking the possibility it will break some platform.  So I suggest
adding a function sdhci_enable_v4_mode() which is called during probe.

> 
> Best,
> Chunyan
> 
>>
>>> +
>>>       if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
>>>               return;
>>>
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index c95b0a4..128b0ba 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -184,6 +184,7 @@
>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>> +#define  SDHCI_CTRL_V4_MODE          0x1000
>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>
>>>  #define SDHCI_CAPABILITIES   0x40
>>> @@ -270,6 +271,8 @@
>>>  #define   SDHCI_SPEC_100     0
>>>  #define   SDHCI_SPEC_200     1
>>>  #define   SDHCI_SPEC_300     2
>>> +#define   SDHCI_SPEC_400     3
>>> +#define   SDHCI_SPEC_410     4
>>>
>>>  /*
>>>   * End of controller registers.
>>> @@ -551,6 +554,9 @@ struct sdhci_host {
>>>       u32                     sdma_boundary;
>>>
>>>       unsigned long private[0] ____cacheline_aligned;
>>> +
>>> +     /* Host Version 4 Enable */
>>> +     bool                    v4_mode;
>>>  };
>>>
>>>  struct sdhci_ops {
>>>
>>
> 
