From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
Date: Mon, 25 Feb 2019 18:46:05 +0530
Message-ID: <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
 <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: t-kristo@ti.com, nm@ti.com, Mark Rutland <mark.rutland@arm.com>, robh+dt@kernel.org, osandov@fb.com, ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-mmc@vger.kernel.org

Hi Naresh,

+ Commit authors.

On 19/02/19 6:38 PM, Faiz Abbas wrote:
> Hi Naresh,
> 
> On 18/02/19 6:57 PM, Naresh Kamboju wrote:
>> Do you see this error on am57xx-evm running Linux next 20190218 ?
>> I have tested on multiple devices and found this error.
>> Please find the full boot log [1].
>> Am i missing any pre required configs [2] ?
>>
>> [    5.620263] mmc1: ADMA error
>> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
>> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
>> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
>> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
>> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
>> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
>> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
>> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
>> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
>> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
>> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
>> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
>>
> 
> I see this as well on my setup. Trying to bisect now. Will keep you posted.


Reverting the following commit fixes this.
commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Feb 15 19:13:20 2019 +0800

    block: enable multipage bvecs

    This patch pulls the trigger for multi-page bvecs.

    Reviewed-by: Omar Sandoval <osandov@fb.com>
    Signed-off-by: Ming Lei <ming.lei@redhat.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>



>> <>
>> [   42.425587] print_req_error: I/O error, dev mmcblk1, sector 4542872 flags 1
>> [   42.429013] mmc1: ADMA error
>> [   42.432606] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
>> I/O error 10 writing to inode 35321 (offset 0 size 4096 starting block
>> 567860)
>> [   42.435475] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [   42.448543] Buffer I/O error on device mmcblk1p9, logical block 226675
>> [   42.454944] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
>> [   42.461528] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
>> I/O error 10 writing to inode 35322 (offset 0 size 4096 starting block
>> 567861)
>> [   42.467960] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
>> [   42.480982] Buffer I/O error on device mmcblk1p9, logical block 226676
>> [   42.487427] mmc1: sdhci: Argument:  0x002cae20 | Trn mode: 0x00000033
>> [   42.494007] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
>> I/O error 10 writing to inode 315 (offset 0 size 4096 starting block
>> 567862)
>>
>> Full boot log,
>> [1] https://lkft.validation.linaro.org/scheduler/job/610989#L4354
>> config,
>> [2] http://snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-next/467/config
>>
>> Best regards
>> Naresh Kamboju
>>
