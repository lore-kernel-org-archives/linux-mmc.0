From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
Date: Fri, 15 Nov 2019 11:38:12 +0100
Message-ID: <CAPDyKFps4GbHYA7LkVXhhXyG_wUxH9U-2giap2Y1Qdk2ssfmWg@mail.gmail.com>
References: <20191112134808.23546-1-erosca@de.adit-jv.com> <20191112204952.GA2976@kunai>
 <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
 <20191114113743.GA19656@vmlxhi-102.adit-jv.com> <CAPDyKFp5iqrFDM1EWnYBwFmQAiAA5FADDLAyuVVBgMu4Sx=x5w@mail.gmail.com>
 <20191114201514.GA3058@kunai> <CAPDyKFpbu0tCWyUHRjVySRF3QR6Hzd8MXA+RhNeCjED1nPtkYg@mail.gmail.com>
 <20191115101205.GB2227@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191115101205.GB2227@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 15 Nov 2019 at 11:12, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > I think using a workqueue for scheduling a reset work with a timeout
> > of 5 s, as in your case.
>
> Sorry, I didn't get it. You think what exactly? Is it good / bad / ok
> for now / ok in general?

Sorry.

It's good for now!

If/when you start implementing support for HW busy detection, then you
need to adjust to the timeout value according to cmd->busy_timeout
from the core.

Kind regards
Uffe
