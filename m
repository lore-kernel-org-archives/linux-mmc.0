Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB6C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 16:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C710F2192A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 16:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTJngMCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHQ7x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHQ7w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 12:59:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8341FC061A0C
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 09:59:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so1793371ejx.5
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zD5Y8RJguj590eRDzoHfOtNNSbrBtLZKVnp3FNhJtJk=;
        b=bTJngMCRFR0fjhz2uj2stmdDiXaxzCLvhVl2zd6GDo/+RZi5Xq8Gc+cy8wpp8UyMOz
         dCQoqyBlyZvOAZMkd1t2sRYkTVPRfItSZ7fi7zSIQ+/xHVL5q1nXX9kEqXlOBBtVSF3A
         SNu8yBLEXtuR3gTnpIIb9bCUYfKxLKngV1vtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zD5Y8RJguj590eRDzoHfOtNNSbrBtLZKVnp3FNhJtJk=;
        b=aVZPqc7VS+mmpzfwU4C+k25Rd1agE4GaAYKV4Vjx2gGo3ouZMsAgEuv/sJQ6thQSHT
         YTHzV01ESwivlWQh72lfETm5yqjTGzueRZXOdrWivO6vEZbCe98pID1WNuzVvNA+cBih
         1TFkRJu4s8cmz1i93lXLp5w7pKf4qZsEKg3JhkVPY+I0q2AnVMDFfLOgGLxBWAwWexkS
         V61KgGrZ1QKvobkbysR2yyfyu5EAhvTIsBrm23QceTJ5kjlZDZBGXGL1jtvzw0EsOZ/G
         FAhdQFBYZ+NAJKg+U0ex4+AHD0TgulXNSJoYOhQb47FA5rsYuhtoJPozR2sN2l9Y2vxO
         UCGw==
X-Gm-Message-State: AGi0PuYDkRpMWKSMKWeO4YwWXN39KfMrnik9cbFQT4DXmqUzaV4XXJqx
        ijOTatVEEtHKaTGFv9NEyHrSgu6BqOM=
X-Google-Smtp-Source: APiQypLxjcWsoskw5Sepr45ZcIBsNLChSMnL5LnzvdFINIEYxujX1Lz12X08rxkdS7LEsqC93NgU6A==
X-Received: by 2002:a17:906:18e9:: with SMTP id e9mr2645513ejf.140.1588957190555;
        Fri, 08 May 2020 09:59:50 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id y21sm248176ejc.11.2020.05.08.09.59.49
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 09:59:49 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id b20so1768707ejg.11
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 09:59:49 -0700 (PDT)
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr2715261ejq.141.1588957188762;
 Fri, 08 May 2020 09:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
 <20200508152236.GQ8135@suse.de> <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
In-Reply-To: <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 8 May 2020 10:59:37 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com>
Message-ID: <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com>
Subject: Re: Problems using AMD eMMC with AMD IOMMU
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-mmc@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        Douglas Anderson <dianders@chromium.org>, evgreen@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It looks like the ACPI matching logic was changed.

With ToT we get:
```
[   13.099631] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
Checking ACPI HID Map.
[   13.108542] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
p->hid: AMDI0040, p->uid: .
[   13.117936] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id: No match!
```

If I revert [iommu/amd: Switch to use
acpi_dev_hid_uid_match()](https://github.com/torvalds/linux/commit/ae5e6c6439c3d0ac8e9c71523790ba1ff6887894)
the matching works.

```
[   13.275305] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
Checking ACPI HID Map.
[   13.284216] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
p->hid: AMDI0040, p->uid: .
[   13.293610] platform AMDI0040:00: AMD-Vi: match_hid_uid: dev->hid:
AMDI0040, dev->uid: 0.
[   13.302715] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id: Found match!
```

We can see the device is now associated with a group:

```
# find /sys/ -iname iommu
/sys/devices/platform/AMDI0040:00/iommu
```

```
# cat /sys/devices/platform/AMDI0040\:00/iommu_group/reserved_regions
0x00000000fee00000 0x00000000feefffff msi
0x000000fd00000000 0x000000ffffffffff reserved
```

It looks like we now correctly call `iommu_dma_alloc`: https://0paste.com/66855

Unfortunately I still get the DMA errors:
```
[   16.051621] mmc1: ADMA error: 0x02000000
[   16.055632] mmc1: error -5 whilst initialising MMC card
```

```
sdhci_data_irq() {
  sdhci_adma_show_error() {
    sdhci_dumpregs() {
      /* mmc1: sdhci: ============ SDHCI REGISTER DUMP =========== */
      /* mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002 */
      /* mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001 */
      /* mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013 */
      /* mmc1: sdhci: Present:   0xf1ff0000 | Host ctl: 0x00000019 */
      /* mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000 */
      /* mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07 */
      /* mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000 */
      /* mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b */
      /* mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000 */
      /* mmc1: sdhci: Caps:      0x71fec8b2 | Caps_1:   0x00000577 */
      /* mmc1: sdhci: Cmd:       0x0000083a | Max curr: 0x00c80064 */
      /* mmc1: sdhci: Resp[0]:   0x00000700 | Resp[1]:  0xffffffff */
      /* mmc1: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d00f00 */
      /* mmc1: sdhci: Host ctl2: 0x00000000 */
      /* mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xfffffffffffff200 */
      /* mmc1: sdhci: ============================================ */
    }
    /* mmc1: sdhci: fffffffffffff200: DMA 0xffffffffffffee00, LEN
0x0200, Attr=0x21 */
    /* mmc1: sdhci: fffffffffffff20c: DMA 0x0000000000000000, LEN
0x0000, Attr=0x03 */
  }
```

ADMA Err 0x1 = Error Fetching descriptor.

The 0xfffffffffffff200 page is only mapped once, so I don't think it's
a race condition. It's also not complaining about the data transfer,
so don't think it's SG related. Any other tips?

Thanks,
Raul

On Fri, May 8, 2020 at 9:46 AM Raul Rangel <rrangel@chromium.org> wrote:
>
> Thanks for the suggestions. I will try them out. I did some more
> digging yesterday and it looks like the device isn't getting
> associated with the IOMMU. I added some extra logging.
>
> [   11.670073] AMD-Vi: Using IVHD type 0x40
> [   11.674766] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b0 info 0000
> [   11.682232] AMD-Vi:        mmio-addr: 00000000fd200000
> [   11.687952] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
> [   11.695219] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.6
> [   11.701267] AMD-Vi:   DEV_ALIAS_RANGE                 devid:
> ff:00.0 flags: 00 devid_to: 00:14.4
> [   11.709699] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.7
> [   11.715224] AMD-Vi:   DEV_SPECIAL(HPET[0])           devid: 00:14.0
> [   11.721327] AMD-Vi:   DEV_SPECIAL(IOAPIC[33])                devid: 00:14.0
> [   11.727720] AMD-Vi:   DEV_ACPI_HID(AMDI0040[])               devid:
> 00:13.1 <- You can see the ACPI ID in the IVRS table.
> [   11.734211] AMD-Vi: ivrs, add hid:AMDI0040, uid:, rdevid:152
> [   11.913253] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [   11.920969] pci 0000:00:01.0: AMD-Vi: Init IOMMU for device
> [   11.927224] pci 0000:00:01.0: Adding to iommu group 0
> [   11.932910] pci 0000:00:01.0: AMD-Vi: IOMMU set to DMA
> [   11.938635] pci 0000:00:01.2: AMD-Vi: Init IOMMU for device
> [   11.944858] pci 0000:00:01.2: Adding to iommu group 1
> [   11.950527] pci 0000:00:01.2: AMD-Vi: IOMMU set to DMA
> [   11.956257] pci 0000:00:01.3: AMD-Vi: Init IOMMU for device
> ... More PCI
> [   12.244008] pci 0000:02:00.0: Adding to iommu group 10
> [   12.249784] pci 0000:02:00.0: AMD-Vi: IOMMU set to DMA
> [   12.255514] pci 0000:03:00.0: AMD-Vi: Init IOMMU for device
> [   12.261736] pci 0000:03:00.0: Adding to iommu group 11
> [   12.267519] pci 0000:03:00.0: AMD-Vi: IOMMU set to DMA
> [   12.273261] pci 0000:04:00.0: AMD-Vi: Init IOMMU for device
> [   12.279568] pci 0000:04:00.0: Adding to iommu group 12
> [   12.285427] pci 0000:04:00.0: Using iommu direct mapping
> [   12.291336] pci 0000:04:00.0: AMD-Vi: IOMMU set to passthrough
> [   12.297833] pci 0000:04:00.1: AMD-Vi: Init IOMMU for device
> [   12.304087] pci 0000:04:00.1: Adding to iommu group 13
> [   12.309852] pci 0000:04:00.1: AMD-Vi: IOMMU set to DMA
> [   12.315576] pci 0000:04:00.2: AMD-Vi: Init IOMMU for device
> ... Even More PCI
> [   12.415860] pci 0000:04:00.7: AMD-Vi: IOMMU set to DMA
> [   12.421586] pci 0000:05:00.0: AMD-Vi: Init IOMMU for device
> [   12.427815] pci 0000:05:00.0: Adding to iommu group 14
> [   12.433589] pci 0000:05:00.0: AMD-Vi: IOMMU set to DMA
> [   12.439583] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [   12.445687] pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
> [   12.453433]  PPR NX GT IA GA PC GA_vAPIC
> [   12.457898] AMD-Vi: Lazy IO/TLB flushing enabled
> [   12.464067] amd_uncore: AMD NB counters detected
> [   12.469208] amd_uncore: AMD LLC counters detected
> [   12.474453] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
>
> Never saw the ACPI device listed.
>
> Listing sysfs I don't see iommu either:
>
> $ find /sys/ -iname iommu
> /sys/kernel/debug/tracing/events/iommu
> /sys/kernel/debug/iommu
> /sys/class/iommu
> /sys/devices/pci0000:00/0000:00:08.0/iommu
> /sys/devices/pci0000:00/0000:00:18.3/iommu
> /sys/devices/pci0000:00/0000:00:01.2/0000:01:00.0/iommu
> /sys/devices/pci0000:00/0000:00:01.2/iommu
> /sys/devices/pci0000:00/0000:00:18.1/iommu
> /sys/devices/pci0000:00/0000:00:01.0/iommu
> /sys/devices/pci0000:00/0000:00:14.3/iommu
> /sys/devices/pci0000:00/0000:00:01.7/0000:03:00.0/iommu
> /sys/devices/pci0000:00/0000:00:01.7/iommu
> /sys/devices/pci0000:00/0000:00:00.2/iommu
> /sys/devices/pci0000:00/0000:00:18.6/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.7/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.5/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.3/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.1/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.6/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.4/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.2/iommu
> /sys/devices/pci0000:00/0000:00:08.1/iommu
> /sys/devices/pci0000:00/0000:00:08.1/0000:04:00.0/iommu
> /sys/devices/pci0000:00/0000:00:18.4/iommu
> /sys/devices/pci0000:00/0000:00:01.3/0000:02:00.0/iommu
> /sys/devices/pci0000:00/0000:00:01.3/iommu
> /sys/devices/pci0000:00/0000:00:18.2/iommu
> /sys/devices/pci0000:00/0000:00:18.0/iommu
> /sys/devices/pci0000:00/0000:00:18.7/iommu
> /sys/devices/pci0000:00/0000:00:14.0/iommu
> /sys/devices/pci0000:00/0000:00:08.2/0000:05:00.0/iommu
> /sys/devices/pci0000:00/0000:00:08.2/iommu
> /sys/devices/pci0000:00/0000:00:18.5/iommu
>
> I'm going to do a bit more tracing.
>
> I'll post back with what I find and I'll also test the patches you provided.
>
> Thanks
>
> On Fri, May 8, 2020 at 9:22 AM Joerg Roedel <jroedel@suse.de> wrote:
> >
> > On Wed, May 06, 2020 at 03:00:21PM -0600, Raul Rangel wrote:
> > > Any suggestions would be appreciated.
> >
> > Two possibilities:
> >
> >         1) Please try the 5 patches from this branch:
> >            https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=iommu/fixes
> >
> >            The fix some race-condition issues, I think it is unlikely
> >            you hit them, but it is worth a test.
> >
> >         2) Dma-iommu code does sg-merging, which the previous DMA-API
> >            implementation did not. Can you try attached diff from Robin
> >            Murphy to disable sg-merging? It that helps it is an issue in
> >            the eMMC driver.
> >
> > Regards,
> >
> >         Joerg
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index a2e96a5fd9a7..a6b71bad518e 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -779,7 +779,7 @@ static int __finalise_sg(struct device *dev, struct
> > scatterlist *sg, int nents,
> >                  * - but doesn't fall at a segment boundary
> >                  * - and wouldn't make the resulting output segment too long
> >                  */
> > -               if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> > +               if (0 && cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> >                     (max_len - cur_len >= s_length)) {
> >                         /* ...then concatenate it with the previous one */
> >                         cur_len += s_length;
> > @@ -799,6 +799,7 @@ static int __finalise_sg(struct device *dev, struct
> > scatterlist *sg, int nents,
> >                 if (s_length + s_iova_off < s_iova_len)
> >                         cur_len = 0;
> >         }
> > +       WARN_ON(count < nents);
> >         return count;
> >   }
