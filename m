From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
Date: Tue, 26 Feb 2019 09:41:38 +0800
Message-ID: <CACVXFVP0h-xvJaW1HaMrhozwhR484x0owc6XX63JT-59N08Fag@mail.gmail.com>
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
 <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com> <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, nm@ti.com, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 25, 2019 at 9:14 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Naresh,
>
> + Commit authors.
>
> On 19/02/19 6:38 PM, Faiz Abbas wrote:
> > Hi Naresh,
> >
> > On 18/02/19 6:57 PM, Naresh Kamboju wrote:
> >> Do you see this error on am57xx-evm running Linux next 20190218 ?
> >> I have tested on multiple devices and found this error.
> >> Please find the full boot log [1].
> >> Am i missing any pre required configs [2] ?
> >>
> >> [    5.620263] mmc1: ADMA error
> >> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> >> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> >> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
> >> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
> >> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
> >> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> >> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> >> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
> >> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> >> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
> >> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> >> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
> >> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
> >> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
> >> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
> >>
> >
> > I see this as well on my setup. Trying to bisect now. Will keep you posted.
>
>
> Reverting the following commit fixes this.
> commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Feb 15 19:13:20 2019 +0800
>
>     block: enable multipage bvecs
>
>     This patch pulls the trigger for multi-page bvecs.
>
>     Reviewed-by: Omar Sandoval <osandov@fb.com>
>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Hi,

Thanks for your report & bisect.

Could you test the following patch?

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.1/block&id=8f4e80da764ec1ca44c83f3e17dbc9bf0209bccc

Or  simply run the latest -next?


Thanks,
Ming Lei
