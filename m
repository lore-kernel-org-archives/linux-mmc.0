From: Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date: Mon, 28 Oct 2019 17:15:30 +0800
Message-ID: <CADBw62qf4qM7c-3YWEpo-8o9qw6RD2_G7qqqBDZZC4Ht37SNnA@mail.gmail.com>
References: <cover.1571722391.git.baolin.wang@linaro.org> <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
 <50696230-75f4-3de4-7424-c33d531ee159@intel.com> <CAMz4kuJAwV7f=pjUqs1nO3+L5NbcwCQrCi-HGUPPXgp7rWUs=g@mail.gmail.com>
 <CAMz4kuKfqMoM3WdaG8o0JHpXeUZHYpLt4P15BsOriU2h2OV--A@mail.gmail.com> <60aabcc6-9def-1472-0e1f-3fec391ef1cd@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60aabcc6-9def-1472-0e1f-3fec391ef1cd@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 28, 2019 at 5:11 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/10/19 10:38 AM, Baolin Wang wrote:
> > On Mon, 28 Oct 2019 at 16:27, Baolin Wang <baolin.wang@linaro.org> wrote:
> >>
> >> Hi Adrian,
> >>
> >> On Mon, 28 Oct 2019 at 16:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> On 22/10/19 8:58 AM, Baolin Wang wrote:
> >>>> Add request_done ops for struct sdhci_ops as a preparation in case some
> >>>> host controllers have different method to complete one request, such as
> >>>> supporting request completion of MMC software queue.
> >>>>
> >>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >>>> ---
> >>>>  drivers/mmc/host/sdhci.c |   12 ++++++++++--
> >>>>  drivers/mmc/host/sdhci.h |    2 ++
> >>>>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>>> index b056400..850241f 100644
> >>>> --- a/drivers/mmc/host/sdhci.c
> >>>> +++ b/drivers/mmc/host/sdhci.c
> >>>> @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >>>>
> >>>>       spin_unlock_irqrestore(&host->lock, flags);
> >>>>
> >>>> -     mmc_request_done(host->mmc, mrq);
> >>>> +     if (host->ops->request_done)
> >>>> +             host->ops->request_done(host, mrq);
> >>>
> >>> For hsq, couldn't this result in sdhci_request() being called interrupt
> >>> context here.
> >>
> >> Right, now it did not support.
> >>
> >>>
> >>> To prevent that you would need to add a condition to sdhci_defer_done() so
> >>> it always defers when using hsq.
> >>
> >> Yes, but now the condition can be matched in sdhci_defer_done()  when
> >> using hsq. So no need to worry that the sdhci_request() will be called
> >> in interrupt
> >> context in this patch set. Thanks.
> >>
> >
> > Wait, sorry, I realized some drivers may not select the
> > SDHCI_REQ_USE_DMA flag in sdhci_defer_done()  when using hsq. OK, So
> > how about below changes?
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 850241f..6c7a396 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
> > sdhci_host *host,
> >  {
> >         struct mmc_data *data = mrq->data;
> >
> > -       return host->pending_reset ||
> > +       return IS_ENABLED(CONFIG_MMC_HSQ) || host->pending_reset ||
>
> Just because it is configured does not mean it is used.  How about adding a
> variable host->always_defer_done and set it in sdhci_sprd_probe().

Sure, sounds reasonable to me. Thanks.
