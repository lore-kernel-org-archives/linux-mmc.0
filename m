From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Issue with Broadcom wireless in 5.2rc1 (was Re: [PATCH] mmc:
 sdhci: queue work after sdhci_defer_done())
Date: Tue, 28 May 2019 22:11:55 +0200
Message-ID: <CAPDyKFrm=NTKjsEPiwzUVbDDzjW5PwZteXbKtPUi9GTUB4kbMQ@mail.gmail.com>
References: <20190524111053.12228-1-masneyb@onstation.org> <70782901-a9ac-5647-1abe-89c86a44a01b@intel.com>
 <20190524154958.GB16322@basecamp> <20190526122136.GA26456@basecamp>
 <e8c049ce-07e1-8b34-678d-41b3d6d41983@broadcom.com> <20190526195819.GA29665@basecamp>
 <20190527093711.GA853@basecamp> <ead7f268-b730-3541-31f7-4499556efec0@intel.com>
 <20190527125026.GA4272@basecamp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527125026.GA4272@basecamp>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Faiz Abbas <faiz_abbas@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>, linux-wireless <linux-wireless@vger.kernel.org>, brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 27 May 2019 at 14:50, Brian Masney <masneyb@onstation.org> wrote:
>
> On Mon, May 27, 2019 at 03:08:07PM +0300, Adrian Hunter wrote:
> > On 27/05/19 12:37 PM, Brian Masney wrote:
> > > On Sun, May 26, 2019 at 03:58:19PM -0400, Brian Masney wrote:
> > >> I attached a patch that shows how I was able to determine what had
> > >> already claimed the host.
> > > On Mon, May 27, 2019 at 10:48:24AM +0300, Adrian Hunter wrote:
> > >> This is because SDHCI is using the IRQ thread to process the SDIO card
> > >> interrupt (sdio_run_irqs()).  When the card driver tries to use the card, it
> > >> causes interrupts which deadlocks since c07a48c26519 ("mmc: sdhci: Remove
> > >> finish_tasklet") has moved the tasklet processing to the IRQ thread.
> > >>
> > >> I would expect to be able to use the IRQ thread to complete requests, and it
> > >> is desirable to do so because it is lower latency.
> > >>
> > >> Probably, SDHCI should use sdio_signal_irq() which queues a work item, and
> > >> is what other drivers are doing.
> > >>
> > >> I will investigate some more and send a patch.
> >
> > Please try the patch below:
> >
> > From: Adrian Hunter <adrian.hunter@intel.com>
> > Date: Mon, 27 May 2019 14:45:55 +0300
> > Subject: [PATCH] mmc: sdhci: Fix SDIO IRQ thread deadlock
> >
> > Since commit c07a48c26519 ("mmc: sdhci: Remove finish_tasklet"), the IRQ
> > thread might be used to complete requests, but the IRQ thread is also used
> > to process SDIO card interrupts. This can cause a deadlock when the SDIO
> > processing tries to access the card since that would also require the IRQ
> > thread. Change SDHCI to use sdio_signal_irq() to schedule a work item
> > instead. That also requires implementing the ->ack_sdio_irq() mmc host op.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Fixes: c07a48c26519 ("mmc: sdhci: Remove finish_tasklet")
>
> Yes, this fixes the issue for me. You can add my:
>
> Reported-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Brian Masney <masneyb@onstation.org>
>

Applied for fixes, thanks!

Kind regards
Uffe
