From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
Date: Fri, 15 Nov 2019 10:27:25 +0100
Message-ID: <CAPDyKFoXEFbK_7-Nmkhz2_Sifc=hiPEGmUHKsp4=Baye86TCOg@mail.gmail.com>
References: <20191112134808.23546-1-erosca@de.adit-jv.com> <20191112204952.GA2976@kunai>
 <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
 <20191114113743.GA19656@vmlxhi-102.adit-jv.com> <CAPDyKFp5iqrFDM1EWnYBwFmQAiAA5FADDLAyuVVBgMu4Sx=x5w@mail.gmail.com>
 <20191114220744.GA17678@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191114220744.GA17678@vmlxhi-102.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 23:07, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
>
> Hi Ulf,
>
> On Thu, Nov 14, 2019 at 01:48:41PM +0100, Ulf Hansson wrote:
>
> [..]
> >
> > Let's first take a step back, because I don't know how the HW busy
> > detection works for your controller.
> >
> > I have noticed there is TMIO_STAT_CMD_BUSY bit being set for some
> > variants, which seems to cause renesas_sdhi_wait_idle() to loop for a
> > pre-defined number of loops/timeout. This looks scary, but I can't
> > tell if it's really a problem.
> >
> > BTW, do you know what TMIO_STAT_CMD_BUSY actually is monitoring?
> >
> > I have also noticed that MMC_CAP_WAIT_WHILE_BUSY isn't set for any of
> > the renesas/tmio variant hosts. Is that simply because the HW doesn't
> > support this? Or because implementation is missing?
>
> Hopefully Wolfram just addressed that?
>
> > If you want to run a test that stretches the behaviour on the timeout
> > path, I would rather use an SD-card (the older the better). For eMMCs
> > the erase likely translates to a trim/discard, which is far more
> > quicker than a real erase - as is what happens on an old SD card.
>
> Running 'blkdiscard' with different SD cards on H3ULCB, I don't see any
> signs of misbehavior:
>
> root@rcar-gen3:~# blkdiscard -V
> blkdiscard from util-linux 2.32.1
>
> root@rcar-gen3:~# lsblk
> NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> mmcblk0      179:0    0 59.2G  0 disk
> mmcblk0boot0 179:8    0    4M  1 disk
> mmcblk0boot1 179:16   0    4M  1 disk
> mmcblk1      179:24   0   30G  0 disk
>
> # Erasing 32 GiB uSD Card
> root@rcar-gen3:~# time blkdiscard -v /dev/mmcblk1
> /dev/mmcblk1: Discarded 32227983360 bytes from the offset 0
>
> real    0m1.198s
> user    0m0.001s
> sys     0m0.122s
>
> # Erasing 64 GiB eMMC
> root@rcar-gen3:~# time blkdiscard -v /dev/mmcblk0
> /dev/mmcblk0: Discarded 63585648640 bytes from the offset 0
>
> real    0m8.703s
> user    0m0.002s
> sys     0m1.909s
>
> I guess that by decreasing below erase sizes, I could further increase
> the execution time, but these sysfs properties are read-only:
>
> cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:59b4/preferred_erase_size
> 4194304
> cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:59b4/erase_size
> 512
>

This test and due to the discussions with Wolfram and you in this
thread, I would actually suggest that you enable MMC_CAP_ERASE for all
tmio variants, rather than just for this particular one.

In other words, set the cap in tmio_mmc_host_probe() should be fine,
as it seems none of the tmio variants supports HW busy detection at
this point.

Kind regards
Uffe
