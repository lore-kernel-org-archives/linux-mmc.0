From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 06/10] mmc: sdhci: Disable auto-CMD23 if stuff bits is
 set in CMD23 argument
Date: Mon, 27 Aug 2018 12:07:23 +0200
Message-ID: <CAPDyKFpL_o2N_yteF=rTH5gy4Mm-HrQU5bL5i8s2dWjpTK_Fng@mail.gmail.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org> <9de08b30-cb92-01c6-caf3-c4abc3591dcf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9de08b30-cb92-01c6-caf3-c4abc3591dcf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2018 at 14:50, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/08/18 10:54, Chunyan Zhang wrote:
>> For version 4.10 and aboves, SDHCI_ARGUMENT2 is also uses to indicate
>> 32-bit number of blocks, it doesn't support stuff bits in argument of
>> CMD23, but only block count for the following command (CMD18/25).
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 9 +++++++++
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index b3328ee..a72ad0d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1729,6 +1729,15 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>               }
>>       }
>>
>> +     /*
>> +      * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
>> +      * block count register which don't support stuff bits of CMD23 argument
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410 &&
>> +         mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
>> +         (host->flags & SDHCI_AUTO_CMD23))
>> +             host->flags &= ~SDHCI_AUTO_CMD23;
>
> I would prefer this be done in sdhci-sprd.c by hooking ->request().  Someone
> sent a patch recently to export sdhci_request().

Right. So I have picked up the patch you were referring to.
https://lkml.org/lkml/2018/8/20/140

Chunyan, you may now preferably base your next version on top of my
mmc tree's next branch.

[...]

Kind regards
Uffe
