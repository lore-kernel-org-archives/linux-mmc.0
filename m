From: Ming Lei <ming.lei@redhat.com>
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
Date: Tue, 26 Feb 2019 21:06:48 +0800
Message-ID: <20190226130647.GA7150@ming.t460p>
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
 <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com>
 <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
 <CACVXFVP0h-xvJaW1HaMrhozwhR484x0owc6XX63JT-59N08Fag@mail.gmail.com>
 <236a3ac2-5988-9150-4a53-4a33a45d595e@ti.com>
 <CACVXFVNqtPnWHp+b0-ED70n1pcv9EkARKYWVKaWtFEEgh0N1XA@mail.gmail.com>
 <c6d72393-cf42-a4f6-06b3-589ca1f3de19@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c6d72393-cf42-a4f6-06b3-589ca1f3de19@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, nm@ti.com, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 26, 2019 at 05:04:40PM +0530, Faiz Abbas wrote:
> Hi,
> 
> On 26/02/19 3:36 PM, Ming Lei wrote:
> > On Tue, Feb 26, 2019 at 2:47 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>
> >> Hi Ming Lei,
> >>
> >> On 26/02/19 7:11 AM, Ming Lei wrote:
> >>> On Mon, Feb 25, 2019 at 9:14 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>>>
> >>>> Hi Naresh,
> >>>>
> >>>> + Commit authors.
> >>>>
> >>>> On 19/02/19 6:38 PM, Faiz Abbas wrote:
> >>>>> Hi Naresh,
> >>>>>
> >>>>> On 18/02/19 6:57 PM, Naresh Kamboju wrote:
> >>>>>> Do you see this error on am57xx-evm running Linux next 20190218 ?
> >>>>>> I have tested on multiple devices and found this error.
> >>>>>> Please find the full boot log [1].
> >>>>>> Am i missing any pre required configs [2] ?
> >>>>>>
> >>>>>> [    5.620263] mmc1: ADMA error
> >>>>>> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> >>>>>> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> >>>>>> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
> >>>>>> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
> >>>>>> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
> >>>>>> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> >>>>>> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> >>>>>> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
> >>>>>> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> >>>>>> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >>>>>> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
> >>>>>> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> >>>>>> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
> >>>>>> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
> >>>>>> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
> >>>>>> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
> >>>>>>
> >>>>>
> >>>>> I see this as well on my setup. Trying to bisect now. Will keep you posted.
> >>>>
> >>>>
> >>>> Reverting the following commit fixes this.
> >>>> commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
> >>>> Author: Ming Lei <ming.lei@redhat.com>
> >>>> Date:   Fri Feb 15 19:13:20 2019 +0800
> >>>>
> >>>>     block: enable multipage bvecs
> >>>>
> >>>>     This patch pulls the trigger for multi-page bvecs.
> >>>>
> >>>>     Reviewed-by: Omar Sandoval <osandov@fb.com>
> >>>>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>
> >>> Hi,
> >>>
> >>> Thanks for your report & bisect.
> >>>
> >>> Could you test the following patch?
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.1/block&id=8f4e80da764ec1ca44c83f3e17dbc9bf0209bccc
> >>>
> >>> Or  simply run the latest -next?
> >>
> >> That didn't fix it for me. Still see ADMA error.
> >>
> >> [   13.126186] mmc0: ADMA error
> >> [   13.129084] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> >> [   13.135552] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> >> [   13.142019] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
> >> [   13.148485] mmc0: sdhci: Argument:  0x00000089 | Trn mode: 0x00000033
> >> [   13.154952] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000012
> >> [   13.161418] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> >> [   13.167885] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> >> [   13.174351] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
> >> [   13.180817] mmc0: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> >> [   13.187282] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >> [   13.193748] mmc0: sdhci: Caps:      0x25e90080 | Caps_1:   0x00000f77
> >> [   13.200215] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> >> [   13.206682] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x3b377f80
> >> [   13.213148] mmc0: sdhci: Resp[2]:   0x5b590000 | Resp[3]:  0x400e0032
> >> [   13.219613] mmc0: sdhci: Host ctl2: 0x00000000
> >> [   13.224073] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xae857288
> >> [   13.230538] mmc0: sdhci: ============================================
> > 
> > OK, I will write a debug patch to dump the sg data and see if it is
> > generated as wrong.
> > 
> > BTW, which kind of failure can you find from the mmc dma error log?
> > 
> 
> It looks like it only happens for some requests. More verbose log with
> dma descriptor entries:
> 
> [   14.840865] mmc0: ADMA error
> [   14.840869] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   14.840874] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> [   14.840879] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
> [   14.840884] mmc0: sdhci: Argument:  0x00000200 | Trn mode: 0x00000033
> [   14.840889] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000012
> [   14.840893] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [   14.840898] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> [   14.840903] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
> [   14.840908] mmc0: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> [   14.840912] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [   14.840917] mmc0: sdhci: Caps:      0x25e90080 | Caps_1:   0x00000f77
> [   14.840922] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> [   14.840926] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x20050044
> [   14.840931] mmc0: sdhci: Resp[2]:   0x53445531 | Resp[3]:  0x744a6055
> [   14.840935] mmc0: sdhci: Host ctl2: 0x00000000
> [   14.840939] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xae857300
> [   14.840943] mmc0: sdhci: ============================================
> [   14.840950] mmc0: sdhci: be2c9004: DMA 0xab1bd000, LEN 0x1000, Attr=0x21
> [   14.840956] mmc0: sdhci: 92173e21: DMA 0xab1bc000, LEN 0x1000, Attr=0x21
> [   14.840962] mmc0: sdhci: c8a0cde4: DMA 0xab1bb000, LEN 0x1000, Attr=0x21
> [   14.840967] mmc0: sdhci: 4bb03017: DMA 0xab1ba000, LEN 0x1000, Attr=0x21
> [   14.840972] mmc0: sdhci: 2fb0d59e: DMA 0xab1b9000, LEN 0x1000, Attr=0x21
> [   14.840978] mmc0: sdhci: c3024ff2: DMA 0xab1b8000, LEN 0x1000, Attr=0x21
> [   14.840983] mmc0: sdhci: 0738188d: DMA 0xab179000, LEN 0x1000, Attr=0x21
> [   14.840989] mmc0: sdhci: 78ecca83: DMA 0xab178000, LEN 0x1000, Attr=0x21
> [   14.840994] mmc0: sdhci: 1432e5a9: DMA 0xab0d7000, LEN 0x1000, Attr=0x21
> [   14.840999] mmc0: sdhci: 8a36c77c: DMA 0xab0d6000, LEN 0x1000, Attr=0x21
> [   14.841005] mmc0: sdhci: b7196410: DMA 0xab0d5000, LEN 0x1000, Attr=0x21
> [   14.841010] mmc0: sdhci: dcb25259: DMA 0xab0d4000, LEN 0x1000, Attr=0x21
> [   14.841015] mmc0: sdhci: ef1e5d32: DMA 0xab0d3000, LEN 0x1000, Attr=0x21
> [   14.841020] mmc0: sdhci: 0319c66c: DMA 0xab0d2000, LEN 0x1000, Attr=0x21
> [   14.841026] mmc0: sdhci: 2e6b85d9: DMA 0xab0d1000, LEN 0x1000, Attr=0x21
> [   14.841031] mmc0: sdhci: d4dd19da: DMA 0xab0d0000, LEN 0x1000, Attr=0x21
> [   14.841036] mmc0: sdhci: 55cdc0f6: DMA 0xab27f000, LEN 0x1000, Attr=0x21
> [   14.841041] mmc0: sdhci: a172f4f3: DMA 0xab27e000, LEN 0x1000, Attr=0x21
> [   14.841046] mmc0: sdhci: ed27e53e: DMA 0xab27d000, LEN 0x1000, Attr=0x21
> [   14.841051] mmc0: sdhci: c04971ce: DMA 0xab27c000, LEN 0x1000, Attr=0x21
> [   14.841057] mmc0: sdhci: f43985d3: DMA 0xab27b000, LEN 0x1000, Attr=0x21
> [   14.841062] mmc0: sdhci: b977bd17: DMA 0xab27a000, LEN 0x1000, Attr=0x21
> [   14.841067] mmc0: sdhci: 8b74ee6f: DMA 0xab279000, LEN 0x1000, Attr=0x21
> [   14.841072] mmc0: sdhci: 12e52bc8: DMA 0xab30d000, LEN 0xffff, Attr=0x21
> [   14.841077] mmc0: sdhci: b39efa31: DMA 0xae857000, LEN 0x0001, Attr=0x21
> [   14.841082] mmc0: sdhci: bc4b71f0: DMA 0xab31d000, LEN 0x3000, Attr=0x21
> [   14.841087] mmc0: sdhci: 4cb5aa08: DMA 0xab2a8000, LEN 0x2000, Attr=0x21
> [   14.841092] mmc0: sdhci: 5e717781: DMA 0xab12a000, LEN 0x2000, Attr=0x21
> [   14.841098] mmc0: sdhci: 125d82b5: DMA 0xab2b4000, LEN 0x4000, Attr=0x21
> [   14.841103] mmc0: sdhci: b33874b9: DMA 0xab148000, LEN 0x4000, Attr=0x21
> [   14.841108] mmc0: sdhci: 9b0e47a5: DMA 0xab218000, LEN 0x8000, Attr=0x21
> [   14.841113] mmc0: sdhci: 47ce17da: DMA 0xab2a0000, LEN 0x2000, Attr=0x21
> [   14.841118] mmc0: sdhci: 97ea0d9f: DMA 0x00000000, LEN 0x0000, Attr=0x03
> 
> There is a big transfer of 0xffff length followed by a smaller transfer
> of 0x1 (at address 0xae857000 above) and that is where it fails. This is
> the same signature every time it happens.

Thanks for the investigation, and that is very helpful!

Then I guess it is caused by bad segment size, see sdhci_setup_host():

        if (host->flags & SDHCI_USE_ADMA) {
                if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
                        mmc->max_seg_size = 65535;
                else
                        mmc->max_seg_size = 65536;
        } else {
                mmc->max_seg_size = mmc->max_req_size;
        }

Could you confirm it by collecting the following log?

(cd  /sys/block/mmcblk0/queue && find . -type f -exec grep -aH . {} \;)

If 'max_segment_size' is 65535, we may need the following patch:

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6375afaedcec..6fb7a312b4ea 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -309,7 +309,7 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 		       __func__, max_size);
 	}
 
-	q->limits.max_segment_size = max_size;
+	q->limits.max_segment_size = round_down(max_size, 512);
 }
 EXPORT_SYMBOL(blk_queue_max_segment_size);
 


Thanks,
Ming
