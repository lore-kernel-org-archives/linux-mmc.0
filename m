From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
Date: Wed, 27 Feb 2019 15:15:50 +0530
Message-ID: <34184f5e-429e-e02d-3fa1-17bb33028a91@ti.com>
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
 <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com>
 <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
 <CACVXFVP0h-xvJaW1HaMrhozwhR484x0owc6XX63JT-59N08Fag@mail.gmail.com>
 <236a3ac2-5988-9150-4a53-4a33a45d595e@ti.com>
 <CACVXFVNqtPnWHp+b0-ED70n1pcv9EkARKYWVKaWtFEEgh0N1XA@mail.gmail.com>
 <c6d72393-cf42-a4f6-06b3-589ca1f3de19@ti.com>
 <20190226130647.GA7150@ming.t460p>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226130647.GA7150@ming.t460p>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <ming.lei@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, nm@ti.com, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 26/02/19 6:36 PM, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 05:04:40PM +0530, Faiz Abbas wrote:
>> Hi,
>>
>> On 26/02/19 3:36 PM, Ming Lei wrote:
>>> On Tue, Feb 26, 2019 at 2:47 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>
>>>> Hi Ming Lei,
>>>>
>>>> On 26/02/19 7:11 AM, Ming Lei wrote:
>>>>> On Mon, Feb 25, 2019 at 9:14 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>>>
>>>>>> Hi Naresh,
>>>>>>
>>>>>> + Commit authors.
>>>>>>
>>>>>> On 19/02/19 6:38 PM, Faiz Abbas wrote:
>>>>>>> Hi Naresh,
>>>>>>>
...
>> It looks like it only happens for some requests. More verbose log with
>> dma descriptor entries:
>>
>> [   14.840865] mmc0: ADMA error
>> [   14.840869] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [   14.840874] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
>> [   14.840879] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
>> [   14.840884] mmc0: sdhci: Argument:  0x00000200 | Trn mode: 0x00000033
>> [   14.840889] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000012
>> [   14.840893] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [   14.840898] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>> [   14.840903] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
>> [   14.840908] mmc0: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
>> [   14.840912] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [   14.840917] mmc0: sdhci: Caps:      0x25e90080 | Caps_1:   0x00000f77
>> [   14.840922] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
>> [   14.840926] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x20050044
>> [   14.840931] mmc0: sdhci: Resp[2]:   0x53445531 | Resp[3]:  0x744a6055
>> [   14.840935] mmc0: sdhci: Host ctl2: 0x00000000
>> [   14.840939] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xae857300
>> [   14.840943] mmc0: sdhci: ============================================
>> [   14.840950] mmc0: sdhci: be2c9004: DMA 0xab1bd000, LEN 0x1000, Attr=0x21
>> [   14.840956] mmc0: sdhci: 92173e21: DMA 0xab1bc000, LEN 0x1000, Attr=0x21
>> [   14.840962] mmc0: sdhci: c8a0cde4: DMA 0xab1bb000, LEN 0x1000, Attr=0x21
>> [   14.840967] mmc0: sdhci: 4bb03017: DMA 0xab1ba000, LEN 0x1000, Attr=0x21
>> [   14.840972] mmc0: sdhci: 2fb0d59e: DMA 0xab1b9000, LEN 0x1000, Attr=0x21
>> [   14.840978] mmc0: sdhci: c3024ff2: DMA 0xab1b8000, LEN 0x1000, Attr=0x21
>> [   14.840983] mmc0: sdhci: 0738188d: DMA 0xab179000, LEN 0x1000, Attr=0x21
>> [   14.840989] mmc0: sdhci: 78ecca83: DMA 0xab178000, LEN 0x1000, Attr=0x21
>> [   14.840994] mmc0: sdhci: 1432e5a9: DMA 0xab0d7000, LEN 0x1000, Attr=0x21
>> [   14.840999] mmc0: sdhci: 8a36c77c: DMA 0xab0d6000, LEN 0x1000, Attr=0x21
>> [   14.841005] mmc0: sdhci: b7196410: DMA 0xab0d5000, LEN 0x1000, Attr=0x21
>> [   14.841010] mmc0: sdhci: dcb25259: DMA 0xab0d4000, LEN 0x1000, Attr=0x21
>> [   14.841015] mmc0: sdhci: ef1e5d32: DMA 0xab0d3000, LEN 0x1000, Attr=0x21
>> [   14.841020] mmc0: sdhci: 0319c66c: DMA 0xab0d2000, LEN 0x1000, Attr=0x21
>> [   14.841026] mmc0: sdhci: 2e6b85d9: DMA 0xab0d1000, LEN 0x1000, Attr=0x21
>> [   14.841031] mmc0: sdhci: d4dd19da: DMA 0xab0d0000, LEN 0x1000, Attr=0x21
>> [   14.841036] mmc0: sdhci: 55cdc0f6: DMA 0xab27f000, LEN 0x1000, Attr=0x21
>> [   14.841041] mmc0: sdhci: a172f4f3: DMA 0xab27e000, LEN 0x1000, Attr=0x21
>> [   14.841046] mmc0: sdhci: ed27e53e: DMA 0xab27d000, LEN 0x1000, Attr=0x21
>> [   14.841051] mmc0: sdhci: c04971ce: DMA 0xab27c000, LEN 0x1000, Attr=0x21
>> [   14.841057] mmc0: sdhci: f43985d3: DMA 0xab27b000, LEN 0x1000, Attr=0x21
>> [   14.841062] mmc0: sdhci: b977bd17: DMA 0xab27a000, LEN 0x1000, Attr=0x21
>> [   14.841067] mmc0: sdhci: 8b74ee6f: DMA 0xab279000, LEN 0x1000, Attr=0x21
>> [   14.841072] mmc0: sdhci: 12e52bc8: DMA 0xab30d000, LEN 0xffff, Attr=0x21
>> [   14.841077] mmc0: sdhci: b39efa31: DMA 0xae857000, LEN 0x0001, Attr=0x21
>> [   14.841082] mmc0: sdhci: bc4b71f0: DMA 0xab31d000, LEN 0x3000, Attr=0x21
>> [   14.841087] mmc0: sdhci: 4cb5aa08: DMA 0xab2a8000, LEN 0x2000, Attr=0x21
>> [   14.841092] mmc0: sdhci: 5e717781: DMA 0xab12a000, LEN 0x2000, Attr=0x21
>> [   14.841098] mmc0: sdhci: 125d82b5: DMA 0xab2b4000, LEN 0x4000, Attr=0x21
>> [   14.841103] mmc0: sdhci: b33874b9: DMA 0xab148000, LEN 0x4000, Attr=0x21
>> [   14.841108] mmc0: sdhci: 9b0e47a5: DMA 0xab218000, LEN 0x8000, Attr=0x21
>> [   14.841113] mmc0: sdhci: 47ce17da: DMA 0xab2a0000, LEN 0x2000, Attr=0x21
>> [   14.841118] mmc0: sdhci: 97ea0d9f: DMA 0x00000000, LEN 0x0000, Attr=0x03
>>
>> There is a big transfer of 0xffff length followed by a smaller transfer
>> of 0x1 (at address 0xae857000 above) and that is where it fails. This is
>> the same signature every time it happens.
> 
> Thanks for the investigation, and that is very helpful!
> 
> Then I guess it is caused by bad segment size, see sdhci_setup_host():
> 
>         if (host->flags & SDHCI_USE_ADMA) {
>                 if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
>                         mmc->max_seg_size = 65535;
>                 else
>                         mmc->max_seg_size = 65536;
>         } else {
>                 mmc->max_seg_size = mmc->max_req_size;
>         }
> 
> Could you confirm it by collecting the following log?
> 
> (cd  /sys/block/mmcblk0/queue && find . -type f -exec grep -aH . {} \;)

The max_segment_size is 65535.

root@dra7xx-evm:~# (cd  /sys/block/mmcblk0/queue && find . -type f -exec
grep -aH . {} \;)
./hw_sector_size:512
./max_discard_segments:1
./max_segment_size:65535
./physical_block_size:512
./discard_max_bytes:4194304
./rotational:0
./iosched/fifo_batch:16
./iosched/read_expire:500
./iosched/writes_starved:2
./iosched/write_expire:5000
./iosched/front_merges:1
./write_same_max_bytes:0
./zoned:none
./max_sectors_kb:512
./discard_zeroes_data:0
./read_ahead_kb:128
./discard_max_hw_bytes:4194304
./nomerges:0
./max_segments:128
./rq_affinity:1
./iostats:1
./dax:0
./minimum_io_size:512
./chunk_sectors:0
./io_poll:0
./write_zeroes_max_bytes:0
./max_hw_sectors_kb:512
./add_random:0
./optimal_io_size:0
./nr_requests:128
./scheduler:[mq-deadline] kyber none
./io_timeout:60000
./discard_granularity:4194304
./logical_block_size:512
./nr_zones:0
./fua:1
./io_poll_delay:-1
./max_integrity_segments:0
./write_cache:write back
root@dra7xx-evm:~#

> 
> If 'max_segment_size' is 65535, we may need the following patch:
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 6375afaedcec..6fb7a312b4ea 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -309,7 +309,7 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
>  		       __func__, max_size);
>  	}
>  
> -	q->limits.max_segment_size = max_size;
> +	q->limits.max_segment_size = round_down(max_size, 512);
>  }
>  EXPORT_SYMBOL(blk_queue_max_segment_size);
>  

This patch fixes it for me. Thanks!

Regards,
Faiz
