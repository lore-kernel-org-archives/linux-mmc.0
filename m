From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for v4
 mode
Date: Tue, 14 Aug 2018 14:40:00 +0300
Message-ID: <b23b9836-66f0-9fa5-b5ff-2629b1e3ac06@intel.com>
References: <1532340508-8749-5-git-send-email-zhang.chunyan@linaro.org>
 <1532400671-23429-1-git-send-email-zhang.chunyan@linaro.org>
 <3e586922-c5e8-fb3c-233e-06836f4dad48@intel.com>
 <CAAfSe-vT0+9seTJwioY8Um0ch85Q_pDfbWC=uCyF2Ch+LEby-g@mail.gmail.com>
 <598422fd0106427c85945baf1e1f1548@SHMBX02.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <598422fd0106427c85945baf1e1f1548@SHMBX02.spreadtrum.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?SmFzb24gV3UgKOWQtOmcgeeIvSk=?= <Jason.Wu@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, =?UTF-8?B?QmlsbG93cyBXdSAo5q2m5rSq5rabKQ==?= <Billows.Wu@unisoc.com>
List-Id: linux-mmc@vger.kernel.org

On 07/08/18 04:58, Jason Wu (吴霁爽) wrote:
>  
> 
> According the information of following picture, in this case I think, we
> just have 2 choice in sdio v4.1:
> 
> 1 do not define SDHCI_AUTO_CMD23: argument of cmd23 will define in register
> 0x8(Argument register)

That would only need to be done for requests that use the upper bits. i.e.
Perhaps hook host->mmc_host_ops->request() and check if sbc argument is ok.
Then toggle SDHCI_AUTO_CMD23 accordingly.

> 
> 2 or define SDHCI_USE_ADMA: block count of cmd18/28 will be get in “Command
> Descriptor for SD Mod”of ADMA. And block cnt register will be used as
> parameter of auto cmd23.
> 
> -----Original Message-----
> From: Chunyan Zhang [mailto:zhang.lyra@gmail.com]
> Sent: Monday, August 06, 2018 7:29 PM
> To: Adrian Hunter
> Cc: Chunyan Zhang; Ulf Hansson; linux-mmc@vger.kernel.org; Linux Kernel
> Mailing List; Orson Zhai; Baolin Wang; Billows Wu (武洪涛); Jason Wu (吴霁爽)
> Subject: Re: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for
> v4 mode
> 
>  
> 
> Hi Adrian,
> 
>  
> 
> On 30 July 2018 at 21:05, Adrian Hunter <adrian.hunter@intel.com
> <mailto:adrian.hunter@intel.com>> wrote:
> 
>> On 24/07/18 05:51, Chunyan Zhang wrote:
> 
>>> Host Controller Version 4.10 re-defines SDMA System Address register
> 
>>> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System Address
> 
>>> register (05Fh-058h) instead if v4 mode is enabled. Also when using
> 
>>> 32-bit block count, 16-bit block count register need to be set to
> 
>>> zero.
> 
>>> 
> 
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org <mailto:zhang.chunyan@linaro.org>>
> 
>>> ---
> 
>>>  drivers/mmc/host/sdhci.c | 14 +++++++++++++- 
> 
>>> drivers/mmc/host/sdhci.h |  1 +
> 
>>>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
>>> 
> 
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> 
>>> index 920d8ec..c272a2b 100644
> 
>>> --- a/drivers/mmc/host/sdhci.c
> 
>>> +++ b/drivers/mmc/host/sdhci.c
> 
>>> @@ -1070,7 +1070,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> 
>>>       /* Set the DMA boundary value and block size */
> 
>>>       sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
> 
>>>                    SDHCI_BLOCK_SIZE);
> 
>>> -     sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> 
>>> +
> 
>>> +     /*
> 
>>> +      * For Version 4.10 onwards, if v4 mode is enabled, 16-bit Block Count
> 
>>> +      * register need to be set to zero, 32-bit Block Count register would
> 
>>> +      * be selected.
> 
>>> +      */
> 
>>> +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
> 
>>> +             if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> 
>>> +                     sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> 
>>> +             sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
> 
>> 
> 
>> So this is also SDHCI_ARGUMENT2 which is why there is a conflict with
> 
>> auto-CMD23.  We need to write SDHCI_32BIT_BLK_CNT only once, but also
> 
>> cater for eMMC which uses the CMD23 argument for more than just block count.
> 
>> 
> 
>  
> 
> What you would suggest on how should we change here?
> 
>  
> 
> I've double checked with the hardware fellow within the company, the sd host
> controller v4 (on our platform at least) would  use this register as block
> count only, that's saying that it would not deal with the flags (i.e.
> reliable write and data tag) of CMD23.
> 
>  
> 
> Thanks,
> 
> Chunyan
> 
>  
> 
>>> +     } else {
> 
>>> +             sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> 
>>> +     }
> 
>>>  }
> 
>>> 
> 
>>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host, diff
> 
>>> --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
> 
>>> 23318ff..81aae07 100644
> 
>>> --- a/drivers/mmc/host/sdhci.h
> 
>>> +++ b/drivers/mmc/host/sdhci.h
> 
>>> @@ -28,6 +28,7 @@
> 
>>> 
> 
>>>  #define SDHCI_DMA_ADDRESS    0x00
> 
>>>  #define SDHCI_ARGUMENT2              SDHCI_DMA_ADDRESS
> 
>>> +#define SDHCI_32BIT_BLK_CNT  SDHCI_DMA_ADDRESS
> 
>>> 
> 
>>>  #define SDHCI_BLOCK_SIZE     0x04
> 
>>>  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz
> 
>>> & 0xFFF))
> 
>>> 
> 
>> 
> 
