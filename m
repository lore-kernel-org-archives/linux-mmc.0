From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
Date: Fri, 15 Nov 2019 10:19:40 +0100
Message-ID: <CAPDyKFpbu0tCWyUHRjVySRF3QR6Hzd8MXA+RhNeCjED1nPtkYg@mail.gmail.com>
References: <20191112134808.23546-1-erosca@de.adit-jv.com> <20191112204952.GA2976@kunai>
 <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
 <20191114113743.GA19656@vmlxhi-102.adit-jv.com> <CAPDyKFp5iqrFDM1EWnYBwFmQAiAA5FADDLAyuVVBgMu4Sx=x5w@mail.gmail.com>
 <20191114201514.GA3058@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191114201514.GA3058@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 21:15, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> Hi Ulf,
>
> thanks again for the heads up.
>
> > Let's first take a step back, because I don't know how the HW busy
> > detection works for your controller.
> >
> > I have noticed there is TMIO_STAT_CMD_BUSY bit being set for some
> > variants, which seems to cause renesas_sdhi_wait_idle() to loop for a
> > pre-defined number of loops/timeout. This looks scary, but I can't
> > tell if it's really a problem.
>
> That should be okay. The datasheet mentions that some registers can only
> be accessed when either CBSY or SCLKDIVEN bits signal non-busyness.
> renesas_sdhi_wait_idle() is for that.
>
> > BTW, do you know what TMIO_STAT_CMD_BUSY actually is monitoring?
>
> 0: A command sequence has been completed.
> 1: A command sequence is being executed.

Alright, thanks for clarifying!

>
> > I have also noticed that MMC_CAP_WAIT_WHILE_BUSY isn't set for any of
> > the renesas/tmio variant hosts. Is that simply because the HW doesn't
> > support this? Or because implementation is missing?
>
> Good thing we use public development. I recalled we discussed this
> before but I needed a search engine to find it again:
>
> https://patchwork.kernel.org/patch/8114821/
>
> Summary: The HW (at least since Gen2) has HW support for busy timeout
> detection but I never came around to implement it (and even forgot about
> it :( ). So, we still use a workqueue for it.

I had a vague memory about this discussion as well, thanks for giving
the pointers to it.

I think using a workqueue for scheduling a reset work with a timeout
of 5 s, as in your case.

However, as a heads up, if/when implementing support for busy
detection and adding MMC_CAP_WAIT_WHILE_BUSY, needs to update that
timeout according to cmd->busy_timeout, which is provided by the core.

Kind regards
Uffe
