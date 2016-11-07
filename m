From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: sdhci-iproc: Add byte register access support
Date: Mon, 7 Nov 2016 13:14:40 +0100
Message-ID: <CAPDyKFrWffNpwvXA7Yj2=t_9g-ikJnhpwqMpTp3+jCu1A9FRnQ@mail.gmail.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1 November 2016 at 17:37, Scott Branden <scott.branden@broadcom.com> wrote:
> Add brcm,sdhci-iproc compat string and code for support of newer versions of
> sdhci-iproc controller that allow byte-wise register accesses.
>
> Changes from v1:
> - added details to bindings documentation to clarify usage of brcm,sdhci-iproc
> compatibility string
>
> Scott Branden (2):
>   mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings
>     document
>   mmc: sdhci-iproc: support standard byte register accesses
>
>  .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  9 ++++++
>  drivers/mmc/host/sdhci-iproc.c                     | 35 ++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> --
> 2.5.0
>

It seems I had already applied v1 of this series. I have dropped those
now, waiting to receive an ack from Rob first.

Kind regards
Uffe
