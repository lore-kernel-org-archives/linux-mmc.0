From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/6] mmc: omap_hsmmc: convert to use devm_* and fixes
Date: Wed, 21 May 2014 12:09:06 +0200
Message-ID: <CAPDyKFq73GLT6F4mLC03oQ6mY2bSP0AzG8HRSbH72Qg80Kf1xQ@mail.gmail.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 May 2014 18:46, Balaji T K <balajitk@ti.com> wrote:
> v2:
> use devm_ioremap_resource
> add cmd23 multiblock read/write fix
>
> Balaji T K (6):
>   mmc: omap_hsmmc: use devm_clk_get
>   mmc: omap_hsmmc: use devm_request_irq
>   mmc: omap_hsmmc: use devm_request_threaded_irq
>   mmc: omap_hsmmc: use devm_ioremap_resource
>   mmc: omap_hsmmc: fix cmd23 multiblock read/write
>   mmc: omap_hsmmc: split omap-dma header file
>
>  drivers/mmc/host/omap_hsmmc.c  |   57 ++++++++++++---------------------------
>  include/linux/omap-dma.h       |   19 +------------
>  include/linux/omap-dmaengine.h |   21 ++++++++++++++
>  3 files changed, 40 insertions(+), 57 deletions(-)
>  create mode 100644 include/linux/omap-dmaengine.h
>

Thanks Balaji,

I will include this patchset in the next PR I send to Chris.

Kind regards
Ulf Hansson

> --
> 1.7.5.4
>
