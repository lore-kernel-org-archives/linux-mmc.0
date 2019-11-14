From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
Date: Thu, 14 Nov 2019 12:37:43 +0100
Message-ID: <20191114113743.GA19656@vmlxhi-102.adit-jv.com>
References: <20191112134808.23546-1-erosca@de.adit-jv.com>
 <20191112204952.GA2976@kunai>
 <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Eugeniu Rosca <erosca@de.adit-jv.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
List-Id: linux-mmc@vger.kernel.org

Hi everyone,

On Thu, Nov 14, 2019 at 11:56:23AM +0100, Ulf Hansson wrote:
> On Tue, 12 Nov 2019 at 21:49, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Tue, Nov 12, 2019 at 02:48:08PM +0100, Eugeniu Rosca wrote:
> > > From: Harish Jenny K N <harish_kandiga@mentor.com>
> > >
> > > Enable MMC_CAP_ERASE capability in the driver to allow
> > > erase/discard/trim requests.
> > >
> > > Suggested-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> > > Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> > > [erosca: Forward-port and test on v5.4-rc7 using H3ULCB-KF:
> > >          "blkdiscard /dev/mmcblk0" passes with this patch applied
> > >          and complains otherwise:
> > >        "BLKDISCARD ioctl failed: Operation not supported"]
> > > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> >
> > Looks good to me. Just a generic question, probably more for Ulf:
> >
> > Why does this CAP_ERASE exist? As I understand, the driver only needs to
> > set the flag and no further handling is required. Why would a driver not
> > set this flag and not support erase/trim commands?
> 
> I am working on removing the cap, altogether. Step by step, this is
> getting closer now.
> 
> The main problem has been about busy detect timeouts, as an erase
> command may have a very long busy timeout. On the host side, they
> typically need to respect the cmd->busy_timeout for the request, and
> if it can't because of some HW limitation, it needs to set
> mmc->max_busy_timeout.

FWIW we've discussed such concerns internally, based on past commits
which either disable [1-2] busy timeouts or increase their value [3].

To get a feeling if this is relevant for R-Car3, I've run blkdiscard on
a 64 GiB eMMC without noticing any issues on v5.4-rc7. Hopefully this
is sufficient as testing?

> 
> Once that is fixed for all, we can drop CAP_ERASE.
> 
> Kind regards
> Uffe

[1] 93caf8e69eac76 ("omap_hsmmc: add erase capability")
[2] b13d1f0f9ad64b ("mmc: omap: Add erase capability")
[3] ec30f11e821f2d ("mmc: rtsx_usb: Use the provided busy timeout from the mmc core")

-- 
Best Regards,
Eugeniu
