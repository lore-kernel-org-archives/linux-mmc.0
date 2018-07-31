From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
Date: Tue, 31 Jul 2018 21:12:18 +0900
Message-ID: <CAK7LNAScJFUPK=mMmNWYw-yJ9iaxaibituYRDU2x5kGpbsEd5A@mail.gmail.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
 <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com> <CAPDyKFpK=UnwdNtb3XcgcRBJZeE0X5osM-tk8E85TCs3CeDq7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpK=UnwdNtb3XcgcRBJZeE0X5osM-tk8E85TCs3CeDq7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, DTML <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2018-07-31 0:07 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 26 July 2018 at 05:28, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
>> MFD glue") said, these MMC controllers use the IP from Panasonic.
>>
>> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
>> The common driver code was split and expanded as 'tmio-mmc-core', then
>> it become historical misnomer since 'tmio' is not the name of this IP.
>>
>> I pointed out this [1], and suggested to re-organize the names in the
>> form of:
>>
>>   <IP-name>.c            (common code for this IP)
>>   <IP-name>_tmio.c       (Toshiba Mobile IO)
>>   <IP-name>_sdhi.c       (Renesas SDHI)
>>   <IP-name>_uniphier.c   (Socionext UniPhier)
>>
>> The <IP-name> in my mind was 'mnsd' because names of Panasonic chips
>> are prefixed with 'MN'.
>>
>> This is the naming scheme as we see in dw_mmc* and sdhci-*.
>>
>> In the discussion with Wolfram Sang, my suggestion was rejected
>> because it implied drastic function renaming, which is too invasive.
>>
>> Ulf Hansson was still happy with file renaming to clarify the
>> relationship between variants.  So, the accepted solution was:
>>
>>  - Make 'tmio_mmc' the _right_ core name
>>  - Align all variant files with the same prefix.
>>  - Do not rename functions
>>
>> This commit renames files as follows:
>>
>>   tmio_mmc_core.c              -> tmio_mmc.c
>>   tmio_mmc.c                   -> tmio_mmc_original.c
>>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
>>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
>>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
>>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
>>
>> Also rename CONFIG options to match to the file names:
>>
>>   MMC_TMIO_CORE          -> MMC_TMIO
>>   MMC_TMIO               -> MMC_TMIO_ORIGINAL
>>   MMC_SDHI               -> MMC_TMIO_SDHI
>>   MMC_SDHI_SYS_DMAC      -> MMC_TMIO_SDHI_SYS_DMAC
>>   MMC_SDHI_INTERNAL_DMAC -> MMC_TMIO_SDHI_INTERNAL_DMAC
>>
>> I touched eseries_pxa_defconfig and pxa_defconfig in this commit
>> because they are inactive, but renaming of CONFIG options generally
>> takes some development cycles.  Old names will be kept until the
>> migration is completed, like Renesas folks did when they renamed
>> ARCH_SHMOBILE_MULTI to ARCH_RENESAS.
>>
>> [1] https://www.spinics.net/lists/linux-mmc/msg46952.html
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I am awaiting some feedback from Wolfram before applying.



If this is not welcome, please feel free to throw away.
(then, I will name my driver 'uniphier-sd.c')

I am neutral about this renaming because it
is trying to make the wrong thing correct.


It will also produce a different inconsistency.
Even if we rename renesas_sdhi_core.c to tmio_mmc_sdhi.c ,
functions in it will be kept renesas_sdhi_*
I understand they want to keep the file name and function names consistent.


Thanks.




>> ---
>>
>>  MAINTAINERS                                        |    1 -
>>  arch/arm/configs/eseries_pxa_defconfig             |    2 +-
>>  arch/arm/configs/pxa_defconfig                     |    2 +-
>>  drivers/mmc/host/Kconfig                           |   25 +-
>>  drivers/mmc/host/Makefile                          |    8 +-
>>  drivers/mmc/host/tmio_mmc.c                        | 1415 ++++++++++++++++++--
>>  drivers/mmc/host/tmio_mmc_core.c                   | 1394 -------------------
>>  drivers/mmc/host/tmio_mmc_original.c               |  167 +++
>
> I think there should be another way to format the patch to get better diffstat.
>
> I guess it depends a bit on what version of git you are using, but
> trying the -M option may help.
>
>
>>  .../host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c}  |    2 +-
>>  .../mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h}   |    0
>>  ...ternal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} |    2 +-
>>  ...as_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} |    2 +-
>>  12 files changed, 1518 insertions(+), 1502 deletions(-)
>>  delete mode 100644 drivers/mmc/host/tmio_mmc_core.c
>>  create mode 100644 drivers/mmc/host/tmio_mmc_original.c
>>  rename drivers/mmc/host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c} (99%)
>>  rename drivers/mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h} (100%)
>>  rename drivers/mmc/host/{renesas_sdhi_internal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} (99%)
>>  rename drivers/mmc/host/{renesas_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} (99%)
>>
>
> [...]
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
