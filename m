From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
Date: Thu, 14 Nov 2019 11:56:23 +0100
Message-ID: <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
References: <20191112134808.23546-1-erosca@de.adit-jv.com> <20191112204952.GA2976@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112204952.GA2976@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 12 Nov 2019 at 21:49, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Nov 12, 2019 at 02:48:08PM +0100, Eugeniu Rosca wrote:
> > From: Harish Jenny K N <harish_kandiga@mentor.com>
> >
> > Enable MMC_CAP_ERASE capability in the driver to allow
> > erase/discard/trim requests.
> >
> > Suggested-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> > Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> > [erosca: Forward-port and test on v5.4-rc7 using H3ULCB-KF:
> >          "blkdiscard /dev/mmcblk0" passes with this patch applied
> >          and complains otherwise:
> >        "BLKDISCARD ioctl failed: Operation not supported"]
> > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>
> Looks good to me. Just a generic question, probably more for Ulf:
>
> Why does this CAP_ERASE exist? As I understand, the driver only needs to
> set the flag and no further handling is required. Why would a driver not
> set this flag and not support erase/trim commands?

I am working on removing the cap, altogether. Step by step, this is
getting closer now.

The main problem has been about busy detect timeouts, as an erase
command may have a very long busy timeout. On the host side, they
typically need to respect the cmd->busy_timeout for the request, and
if it can't because of some HW limitation, it needs to set
mmc->max_busy_timeout.

Once that is fixed for all, we can drop CAP_ERASE.

Kind regards
Uffe
