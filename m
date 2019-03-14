From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
Date: Thu, 14 Mar 2019 12:40:19 +0100
Message-ID: <CAK8P3a1KJpWtyUOyyyab03tFYwkeROQXXV1+jM7EJ2d8So2bbA@mail.gmail.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com> <20190215192033.24203-2-faiz_abbas@ti.com>
 <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com> <8d72ff93-e07f-52b9-da85-acd54f046694@ti.com>
 <63b6631d-86e7-b8ef-ffaf-40e7d4e96cfb@intel.com> <842caafd-1547-1ea6-faf0-27a85a912622@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <842caafd-1547-1ea6-faf0-27a85a912622@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon <kishon@ti.com>, Chunyan Zhang <zhang.chunyan@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 12, 2019 at 6:32 PM Rizvi, Mohammad Faiz Abbas
<faiz_abbas@ti.com> wrote:
> On 3/8/2019 7:06 PM, Adrian Hunter wrote:
> > On 6/03/19 12:00 PM, Faiz Abbas wrote:
> > It is a performance drop that can be avoided, so it might as well be.
> > Splitting the success path from the failure path is common for I/O drivers
> > for similar reasons as here: the success path can be optimized whereas the
> > failure path potentially needs to sleep.
>
> Understood. You wanna keep the success path as fast as possible.

I looked at the sdhci_request_done() function and found that almost all
of it is executed inside of a 'spin_lock_irqsave()', including the potentially
expensive dma_sync_single_for_cpu() calls.

This means there is very little benefit in using the tasklet in the first place,
it could just as well run in the hwirq context that triggered it.

The part that is actually run with interrupts enabled in the tasklet
is mmc_blk_cqe_req_done(), but other drivers also call this from
IRQ context.

       Arnd
