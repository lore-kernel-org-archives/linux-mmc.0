From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: mainline 4.14-rc4: renesas_sdhi_internal_dmac ee100000.sd:
 swiotlb buffer is full?
Date: Mon, 16 Oct 2017 11:02:03 +0200
Message-ID: <CAMuHMdV=3_9af-aTGnWBLemg3Hrh-D4im1Vxk0mTXstiz0vVUA@mail.gmail.com>
References: <50d1a9ac-fe5f-d0a1-62bc-ff3e252e99da@de.bosch.com>
 <CAMuHMdXPYyi_pXcdtNJkT737dSXnwG88vqETN0Kbe-3AAJ0zOg@mail.gmail.com>
 <f7596566-2f98-d4a1-612c-77caa51b892e@de.bosch.com> <CAMuHMdXEXwwdNPmoFa+peivR_8Bv06r39bg1pAsL7498xrod6A@mail.gmail.com>
 <5ccf4c75-6dd5-0818-54de-2a99a786a5c4@de.bosch.com> <aecf1ec0-7172-ec41-1759-be261f3e0dd2@de.bosch.com>
 <TY1PR06MB0992FAD2C2CD90FFF71E1807D84F0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:46985 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdJPJCF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Oct 2017 05:02:05 -0400
In-Reply-To: <TY1PR06MB0992FAD2C2CD90FFF71E1807D84F0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>

CC LinusW, Ulf, linux-mmc

On Mon, Oct 16, 2017 at 10:36 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> From: Dirk Behme, Sent: Thursday, October 12, 2017 6:13 PM
>> On 12.10.2017 10:20, Dirk Behme wrote:
>> > On 11.10.2017 15:20, Geert Uytterhoeven wrote:
>> >> On Wed, Oct 11, 2017 at 2:57 PM, Dirk Behme <dirk.behme@de.bosch.com>
>> >> wrote:
>> >>> On 11.10.2017 14:42, Geert Uytterhoeven wrote:
>> >>>> On Wed, Oct 11, 2017 at 2:23 PM, Dirk Behme <dirk.behme@de.bosch.com>
>> >>>> wrote:
>> >>>>> trying to boot recent mainline v4.14-rc4 on a custom H3 ES2.0 board
>> >>>>> with
>> >>>>> rootfs on SD card I'm getting [1].
>> >>>>>
>> >>>>> Last time I think I used v4.13 in the same environment and I think it
>> >>>>> worked
>> >>>>> fine, most probably because renesas_sdhi_internal_dmac wasn't
>> >>>>> there, yet
>> >>>>> ;)
>> >>>>>
>> >>>>> I checked renesas-drivers-2017-10-03-v4.14-rc3 if there is anything
>> >>>>> newer
>> >>>>> regarding drivers/mmc/host/renesas_sdhi_internal_dmac.c but doesn't
>> >>>>> look
>> >>>>> so.
>> >>>>>
>> >>>>> Any idea what I missed?
>> >>>>>
>> >>>> How much swiotlb memory do you have? The default is 64 MiB:
>> >>>>
>> >>>>       software IO TLB [mem 0x77fff000-0x7bfff000] (64MB) mapped at
>> >>>> [ffffffc037fff000-ffffffc03bffefff]
>> >>>
>> >>> Same here:
>> >>
>> >> OK.
>> >>
>> >>>> Then, who else is consuming lots of swiotlb memory?
>> >>
>> >> Or, not freeing allocated memory.
>> >>
>> >>> Hmm, any idea how to find that?
>> >>>
>> >>> The dmesg doesn't seem to have more infos about that (?)
>> >>
>> >> I'm afraid you have to add some prints to swiotlb_tbl_map_single()
>> >> (and swiotlb_tbl_unmap_single())...
>> >
>> >
>> > With [1] I'm getting [2]. What doesn't look that bad, at least quite
>> > symmetric. Having a quick look I can't find any obvious not freed mem.
>> > Hmm ...
>>
>>
>> Ok, it seems to be somehow easy ;) It seems that the 524288 bytes them
>> self are the issue, independent on the usage of the swiotlb memory.
>>
>> Doing a hack like [3], i.e. trying to map 524288 bytes at the first
>> access, already, crashes, too [4].
>>
>> So seems we have two issues?
>>
>> a) swiotlb_tbl_map_single() can't handle 524288 bytes
>>
>> and
>>
>> b) failing swiotlb_tbl_map_single() results in a kernel crash
>>
>>
>> Now, I'm not sure whom to address both to? Is it an issue of
>> renesas_sdhi_internal_dmac() which shouldn't call swiotlb with 524288
>> bytes? Or is this an error of swiotlb? Same for the kernel crash.
>
> Our team also reproduced this issue if we did the following command on H3.
>  # dd if=/dev/mmcblk0 of=/dev/null bs=512k count=200
>
> I investigate the issue and then if I modified the value of IO_TLB_SEGSIZE to 256,
> the issue disappeared. However, other issue happens if I dropped "count=200"...
> So, I will investigate the issues more...
>
> IIUC,
> - Since the MMC_BOUNCE disappeared in v4.14-rc1, the MMC core will request a command with 64kbyte+ size.
>  - So, swiotlb will got request 64kbyte+ size. This is different with previous version.
>
> Best regards,
> Yoshihiro Shimoda
>
>>
>> Best regards
>>
>> Dirk
>>
>> [3]
>>
>> --- a/lib/swiotlb.c
>> +++ b/lib/swiotlb.c
>> @@ -510,6 +510,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device
>> *hwdev,
>>          if (sme_active())
>>                  pr_warn_once("SME is active and system is using DMA
>> bounce buffers\n");
>>
>> +       dev_warn(hwdev, "swiotlb_tbl_map_single: trying to map %zd
>> bytes\n", size);
>> +       size = (size_t)524288;
>> +       dev_warn(hwdev, "swiotlb_tbl_map_single: test: size modified to
>> %zd bytes\n", size);
>> +
>>          mask = dma_get_seg_boundary(hwdev);
>>
>>          tbl_dma_addr &= mask;
>>
>> [4]
>>
>> renesas_sdhi_internal_dmac ee100000.sd: swiotlb_tbl_map_single: trying
>> to map 8 bytes
>> renesas_sdhi_internal_dmac ee100000.sd: swiotlb_tbl_map_single: test:
>> size modified to 524288 bytes
>> renesas_sdhi_internal_dmac ee100000.sd: swiotlb buffer is full (sz:
>> 524288 bytes)
>> renesas_sdhi_internal_dmac ee100000.sd: DMA: Out of SW-IOMMU space for 8
>> bytes
>> Unable to handle kernel paging request at virtual address ffffffffc0000000

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
