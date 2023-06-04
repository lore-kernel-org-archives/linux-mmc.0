Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2BCC7EE29
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Jun 2023 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFDQac (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Jun 2023 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDQab (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Jun 2023 12:30:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C9B3
        for <linux-mmc@vger.kernel.org>; Sun,  4 Jun 2023 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685896229; x=1717432229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0AH7+o1zGzs1QtV/5gTrxKMMAoUDh6lG7GrH2XlguB8=;
  b=Q3MIKF7AeLcmrSVi3Td1HXNlj1+MjiYdZq/LCq6MVqiAVhdXO2pZvJMf
   QWwHM6exk8KnTDduBXSP2yRcmYX9iKWcrKvY8tvXFOeh/oeFduZ7Jhm0Y
   v3hWc8VjjU0BaAuCaoa93nR8DfFi23sSlsTziWKKZM0BeVin6rNVucfPM
   oUBwpErVnYqXP1g7t6dGmTp721QR0hEld4MnZda1AzM7PJ/TllASITwTG
   4cBh4GZSJO69Qnp7U5BpEiga2mt0CrqaIztWmPRA0CEYrNYqSffDW/9Hk
   tc78eZbECJnBI6EoK4UcdfVRL6lIoFeWCK72ZFO9DYM2HcFR6U6zcqodi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384499058"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384499058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 09:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038516665"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038516665"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.209.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 09:30:25 -0700
Message-ID: <75ab27e9-9203-f59b-c720-99bfa992bb9b@intel.com>
Date:   Sun, 4 Jun 2023 19:30:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230531002740.1235620-1-marex@denx.de>
 <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
 <a69823e8-4e87-9eaa-1cb8-7d1457df1492@denx.de>
 <f41e1546-f6d3-7f4d-7662-3b7eca291178@intel.com>
 <29a5f24d-2b8c-8387-8c11-601af8e13940@denx.de>
 <4c8d84ae-c8d0-fa12-81c6-a47382684d73@intel.com>
 <3bd65a30-756d-e7ee-ce77-e5ebfe6b6e30@denx.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3bd65a30-756d-e7ee-ce77-e5ebfe6b6e30@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/06/23 00:46, Marek Vasut wrote:
> On 6/1/23 08:20, Adrian Hunter wrote:
>> On 1/06/23 00:31, Marek Vasut wrote:
>>> On 5/31/23 15:13, Adrian Hunter wrote:
>>>> On 31/05/23 14:34, Marek Vasut wrote:
>>>>> On 5/31/23 07:46, Adrian Hunter wrote:
>>>>>> On 31/05/23 03:27, Marek Vasut wrote:
>>>>>>> This reverts commit 08ebf903af57cda6d773f3dd1671b64f73b432b8.
>>>>>>>
>>>>>>> On STM32MP153C DHCOR DRC Compact with microSD card
>>>>>>> Kingston Canvas Go! Plus MicroSDXC I 64 GiB U3/V30/A2 SDCG3/64GB
>>>>>>> it is no longer possible to mount ext4 filesystem.
>>>>>>>
>>>>>>> Git bisect points to this commit which is being reverted here. A bit of
>>>>>>> investigation shows that for non-working microSD cards
>>>>>>>      cache_enabled=TRUE fua_enabled=false
>>>>>>> For working microSD card (Kingston Canvas React Plus, MicroSDXC II
>>>>>>> 64 GiB U3/V90/A1 SDCR2/64GB)
>>>>>>>      cache_enabled=FALSE fua_enabled=false
>>>>>>>
>>>>>>> It seems enabling the cache for SD cards causes the issue. Before the
>>>>>>> reverted commit, the cache was not reported enabled for SD cards. I am
>>>>>>> not sure whether such blunt revert is the correct solution however, any
>>>>>>> ideas ?
>>>>>>
>>>>>> This does not disable the cache, it disables the block layer from issuing
>>>>>> cache flushes (by telling it there is no cache being used).
>>>>>>
>>>>>> It would be good to know what commands are failing, which should be visible
>>>>>> in the kernel messages if dynamic debug is enabled:
>>>>>>
>>>>>> Dynamic debug for mmc
>>>>>> ---------------------
>>>>>>
>>>>>>        Kernel must be configured:
>>>>>>
>>>>>>            CONFIG_DYNAMIC_DEBUG=y
>>>>>>
>>>>>>        To enable mmc debug via sysfs:
>>>>>>
>>>>>>            echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
>>>>>>            echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control
>>>>>>
>>>>>>        To enable mmc debug via kernel command line:
>>>>>>
>>>>>>            dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
>>>>>>
>>>>>>        To disable mmc debug:
>>>>>>
>>>>>>            echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
>>>>>>            echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control
>>>>>>
>>>>>>        More general information in kernel documentation in kernel tree:
>>>>>>
>>>>>>            Documentation/admin-guide/dynamic-debug-howto.rst
>>>>>
>>>>> Log is below, I added newlines around the mount failure.
>>>>> Do you see anything problematic there ?
>>>>>
>>>>> $ echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control ; echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control ; echo 8 > /proc/sys/kernel/printk ; mount /dev/mmcblk1p4 /mnt
>>>>> [   61.061029] <mmc1: starting CMD23 arg 00000002 flags 00000015>
>>>>> [   61.065637] mmc1: starting CMD18 arg 00002002 flags 000000b5
>>>>> [   61.071144] mmc1:     blksz 512 blocks 2 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.078096] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.083302] mmci-pl18x 58005000.mmc: blksz 0200 blks 0002 flags 00000200
>>>>> [   61.090012] mmci-pl18x 58005000.mmc: op 17 arg 00000002 flags 00000015
>>>>> [   61.096531] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.102332] mmci-pl18x 58005000.mmc: op 12 arg 00002002 flags 000000b5
>>>>> [   61.108836] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.114575] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.120371] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.127178] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.134084] mmc1:     1024 bytes transferred: 0
>>>>> [   61.138658] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.145533] <mmc1: starting CMD23 arg 00000008 flags 00000015>
>>>>> [   61.150946] mmc1: starting CMD18 arg 00002000 flags 000000b5
>>>>> [   61.156609] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.163426] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.168759] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
>>>>> [   61.175368] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
>>>>> [   61.181985] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.187682] mmci-pl18x 58005000.mmc: op 12 arg 00002000 flags 000000b5
>>>>> [   61.194185] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.199979] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.205769] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.212574] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.219478] mmc1:     4096 bytes transferred: 0
>>>>> [   61.224050] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.231166] <mmc1: starting CMD23 arg 00000002 flags 00000015>
>>>>> [   61.236378] mmc1: starting CMD18 arg 00002002 flags 000000b5
>>>>> [   61.241983] mmc1:     blksz 512 blocks 2 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.248940] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.254169] mmci-pl18x 58005000.mmc: blksz 0200 blks 0002 flags 00000200
>>>>> [   61.260779] mmci-pl18x 58005000.mmc: op 17 arg 00000002 flags 00000015
>>>>> [   61.267405] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.273101] mmci-pl18x 58005000.mmc: op 12 arg 00002002 flags 000000b5
>>>>> [   61.279603] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.285431] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.291125] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.298032] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.304937] mmc1:     1024 bytes transferred: 0
>>>>> [   61.309409] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.316256] <mmc1: starting CMD23 arg 00000008 flags 00000015>
>>>>> [   61.321768] mmc1: starting CMD18 arg 00002000 flags 000000b5
>>>>> [   61.327459] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.334360] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.339459] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
>>>>> [   61.346167] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
>>>>> [   61.352782] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.358478] mmci-pl18x 58005000.mmc: op 12 arg 00002000 flags 000000b5
>>>>> [   61.365082] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.370776] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.376565] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.383371] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.390275] mmc1:     4096 bytes transferred: 0
>>>>> [   61.394848] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.401885] <mmc1: starting CMD23 arg 00000002 flags 00000015>
>>>>> [   61.407193] mmc1: starting CMD18 arg 00002002 flags 000000b5
>>>>> [   61.412794] mmc1:     blksz 512 blocks 2 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.419748] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.424973] mmci-pl18x 58005000.mmc: blksz 0200 blks 0002 flags 00000200
>>>>> [   61.431582] mmci-pl18x 58005000.mmc: op 17 arg 00000002 flags 00000015
>>>>> [   61.438204] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.443901] mmci-pl18x 58005000.mmc: op 12 arg 00002002 flags 000000b5
>>>>> [   61.450404] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.456232] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.461927] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.468834] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.475739] mmc1:     1024 bytes transferred: 0
>>>>> [   61.480210] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.487054] <mmc1: starting CMD23 arg 00000008 flags 00000015>
>>>>> [   61.492462] mmc1: starting CMD18 arg 00002000 flags 000000b5
>>>>> [   61.498251] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.505160] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.510260] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
>>>>> [   61.516969] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
>>>>> [   61.523592] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.529288] mmci-pl18x 58005000.mmc: op 12 arg 00002000 flags 000000b5
>>>>> [   61.535789] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.541583] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.547271] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.554177] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.561082] mmc1:     4096 bytes transferred: 0
>>>>> [   61.565654] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.572440] <mmc1: starting CMD23 arg 00000008 flags 00000015>
>>>>> [   61.578017] mmc1: starting CMD18 arg 00002008 flags 000000b5
>>>>> [   61.583653] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.590465] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.595686] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
>>>>> [   61.602396] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
>>>>> [   61.608915] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.614712] mmci-pl18x 58005000.mmc: op 12 arg 00002008 flags 000000b5
>>>>> [   61.621215] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.627034] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.632727] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.639633] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.646437] mmc1:     4096 bytes transferred: 0
>>>>> [   61.651010] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.658908] <mmc1: starting CMD23 arg 00000108 flags 00000015>
>>>>> [   61.663421] mmc1: starting CMD18 arg 00003be8 flags 000000b5
>>>>> [   61.669102] mmc1:     blksz 512 blocks 264 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.676155] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.681355] mmci-pl18x 58005000.mmc: blksz 0200 blks 0108 flags 00000200
>>>>> [   61.688064] mmci-pl18x 58005000.mmc: op 17 arg 00000108 flags 00000015
>>>>> [   61.694589] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.700284] mmci-pl18x 58005000.mmc: op 12 arg 00003be8 flags 000000b5
>>>>> [   61.706887] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.712581] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.718372] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
>>>>> [   61.724060] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.730965] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.737870] mmc1:     135168 bytes transferred: 0
>>>>> [   61.742544] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.749064] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.755336] <mmc1: starting CMD23 arg 00000008 flags 00000015>
>>>>> [   61.760649] mmc1: starting CMD18 arg 00442000 flags 000000b5
>>>>> [   61.766327] mmc1:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
>>>>> [   61.773144] mmc1:     CMD12 arg 00000000 flags 00000095
>>>>> [   61.778489] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000200
>>>>> [   61.785100] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
>>>>> [   61.791616] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.797414] mmci-pl18x 58005000.mmc: op 12 arg 00442000 flags 000000b5
>>>>> [   61.803916] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.809710] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.815399] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.822306] mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.829211] mmc1:     4096 bytes transferred: 0
>>>>> [   61.833683] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.833952] mmc0: starting CMD7 arg fffd0000 flags 00000015
>>>>> [   61.840205] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.845820] mmci-pl18x 48004000.mmc: op 07 arg fffd0000 flags 00000015
>>>>> [   61.853036] <mmc1: starting CMD23 arg 00000008 flags 00000015>
>>>>> [   61.858074] mmci-pl18x 48004000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.858098] mmc0: req done (CMD7): 0: 00001ed7 00000000 00000000 00000000
>>>>> [   61.876506] mmc1: starting CMD25 arg 00002000 flags 000000b5
>>>>> [   61.882106] mmc1:     blksz 512 blocks 8 flags 00000100 tsac 3000 ms nsac 0
>>>>> [   61.889107] mmc1:     CMD12 arg 00000000 flags 0000049d
>>>>> [   61.894346] mmci-pl18x 58005000.mmc: blksz 0200 blks 0008 flags 00000100
>>>>> [   61.900957] mmci-pl18x 58005000.mmc: op 17 arg 00000008 flags 00000015
>>>>> [   61.907588] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.913283] mmci-pl18x 58005000.mmc: op 19 arg 00002000 flags 000000b5
>>>>> [   61.919786] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.925612] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000140
>>>>> [   61.931309] mmc1: req done <CMD23>: 0: 00000900 00000000 00000000 00000000
>>>>> [   61.938219] mmc1: req done (CMD25): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.945125] mmc1:     4096 bytes transferred: 0
>>>>> [   61.949598] mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
>>>>> [   61.956107] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.961888] mmc1: starting CMD13 arg 50480000 flags 00000195
>>>>> [   61.967581] mmci-pl18x 58005000.mmc: op 0d arg 50480000 flags 00000195
>>>>> [   61.974026] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   61.979718] mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
>>>>> [   61.986630] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   61.992588] mmc1: starting CMD49 arg 10020a00 flags 00000035
>>>>> [   61.998152] mmc1:     blksz 512 blocks 1 flags 00000100 tsac 3000 ms nsac 0
>>>>> [   62.005158] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000100
>>>>> [   62.011778] mmci-pl18x 58005000.mmc: op 31 arg 10020a00 flags 00000035
>>>>> [   62.018317] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   62.024011] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
>>>>> [   62.029801] mmc1: req done (CMD49): 0: 00000900 00000000 00000000 00000000
>>>>> [   62.036708] mmc1:     512 bytes transferred: 0
>>>>> [   62.041083] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>> [   62.046988] mmc1: starting CMD48 arg 10020a00 flags 000000b5
>>>>> [   62.052487] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
>>>>> [   62.059443] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000200
>>>>> [   62.066154] mmci-pl18x 58005000.mmc: op 30 arg 10020a00 flags 000000b5
>>>>> [   62.072688] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
>>>>> [   62.078382] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
>>>>> [   62.084173] mmc1: req done (CMD48): 0: 00000900 00000000 00000000 00000000
>>>>> [   62.091081] mmc1:     512 bytes transferred: 0
>>>>> [   62.095455] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
>>>>
>>>> CMD48 was successful but it still became an error, which must have
>>>> been because it indicated the flush had not completed.  We do not
>>>> allow for mmc_poll_for_busy() being too quick i.e. card has not
>>>> had a chance to indicate busy yet.
>>>>
>>>> Please try this:
>>>>
>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>> index 72b664ed90cf..9c3123867a99 100644
>>>> --- a/drivers/mmc/core/sd.c
>>>> +++ b/drivers/mmc/core/sd.c
>>>> @@ -1313,6 +1313,8 @@ static int sd_flush_cache(struct mmc_host *host)
>>>>    {
>>>>        struct mmc_card *card = host->card;
>>>>        u8 *reg_buf, fno, page;
>>>> +    unsigned long timeout;
>>>> +    bool expired;
>>>>        u16 offset;
>>>>        int err;
>>>>    @@ -1338,11 +1340,15 @@ static int sd_flush_cache(struct mmc_host *host)
>>>>            goto out;
>>>>        }
>>>>    +    timeout = jiffies + msecs_to_jiffies(SD_WRITE_EXTR_SINGLE_TIMEOUT_MS) + 1;
>>>> +again:
>>>>        err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
>>>>                    MMC_BUSY_EXTR_SINGLE);
>>>>        if (err)
>>>>            goto out;
>>>>    +    expired = time_after(jiffies, timeout);
>>>> +
>>>>        /*
>>>>         * Read the Flush Cache bit. The card shall reset it, to confirm that
>>>>         * it's has completed the flushing of the cache.
>>>> @@ -1354,8 +1360,12 @@ static int sd_flush_cache(struct mmc_host *host)
>>>>            goto out;
>>>>        }
>>>>    -    if (reg_buf[0] & BIT(0))
>>>> -        err = -ETIMEDOUT;
>>>> +    if (reg_buf[0] & BIT(0)) {
>>>
>>> I am getting here, multiple times, with expired=0 .
>>
>> So either the host controller's busy detection does not work, or the
>> card is not indicating busy by pulling down DAT0.
>>
>> Can you try to figure out which it is?
> 
> The byte 261 bit 0 is never cleared, I had this looping for an hour and the 'Flush Cache' bit just never got cleared. The SD spec 6.00 and 9.00 both indicate the bit should be cleared by the card once cache flush is completed.
> 
> I tried three different controllers now -- STM32MP15xx ARM MMCI, i.MX6Q uSDHC, laptop rtsx_pci_sdmmc , they all fail.
> 
> I tried to find another card which also has cache, I cannot find any other card, all the rest report no cache. The kingston card SSR (see the 2ff in 6th field, the last f bit 2 is cache supported indication, SSR bit 330):
> 
> 00000000:08000000:04009000:011b391e:00080000:0002ff00:03000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
> 
> So either this card is weird, or the cards with cache are so rare that nobody noticed the problem yet.

The patch set cover letter says it was tested with 64GB Sandisk Extreme PRO UHS-I A2 card

	https://lore.kernel.org/linux-mmc/20210506145829.198823-1-ulf.hansson@linaro.org/

I ordered a Kingston Canvas Go Plus card as you described but it won't arrive for a week.

Currently I am thinking we could do a cache flush after enabling the cache, just
to see if it works.  If not, then disable the cache.

It would also be interesting to read back the extended register to see if the
enable bit has actually been set.

> 
>>> After that, once, I get here with expired=1 and then the ext4 mount failure occurs.
>>>
>>>> +        if (expired)
>>>> +            err = -ETIMEDOUT;
>>>> +        else
>>>> +            goto again;
>>>> +    }
>>>>    out:
>>>>        kfree(reg_buf);
>>>>        return err;
>>>
>>> Also, I made another observation -- if I reduce the SD bus clock frequency to 10 MHz (current is 50 MHz), then I don't observe this problem.
>>
>> The lower frequency might just be making the commands take a bit longer
>> so the flush just completes before the timeout.
>>
>> It can also be that the card has less time to work on flushing if it is
>> being hammered by commands.
>>
>> I imagine you can hack some debugging prints as well as I can,
>> but here is an example (untested) to try to find out how long
>> the flush takes and decrease the rate at which commands are sent.
> 
> Discard this information about the 10 MHz, this must've been a fluke. I can reproduce the error even at 10 MHz now.
> 
> [...]

