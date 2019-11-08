From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to
 complete data requests if needed
Date: Fri, 8 Nov 2019 19:27:01 +0800
Message-ID: <CAMz4kuLT_3Hun_=ZiwRsqOcwxNoSasgFTfj7_1naBtVneSiJpg@mail.gmail.com>
References: <cover.1572326519.git.baolin.wang@linaro.org> <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
 <a9f42792-3432-48f2-c5c4-8b03c32995dd@intel.com> <CAMz4kuK=wV1qtO4tOCcqibzKAFD-_p8+OzGOjdkvajVymJ5EgA@mail.gmail.com>
 <2ed0bcd1-fa74-d095-97ee-7d0c46a4fdbb@intel.com> <CAMz4kuJe64hdVGBTCvZW3t4_JGnTBRF=NhYDookrzNPiXacq_w@mail.gmail.com>
 <CAMz4ku+KVWw-M4AaPJ=Yn8xeLNaD2W4+gVqEN_P0QRwne3wwzA@mail.gmail.com> <0c70b5cf-4453-b21b-5622-f97ff069cf1b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c70b5cf-4453-b21b-5622-f97ff069cf1b@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 8 Nov 2019 at 19:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 8/11/19 1:08 PM, Baolin Wang wrote:
> > On 06/11/2019, Baolin Wang <baolin.wang@linaro.org> wrote:
> >> On Wed, 6 Nov 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> To move ahead in the meantime without a new host API, just defer always
> >
> > Before new version, I want to make things clear in case I
> > misunderstood your points, so you mean I should set always_defer_done
> > = true for our Spreadtrum host driver in this patch? Or just like
> > below patch? Thanks.
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 850241f..4bef066 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
> > sdhci_host *host,
> >  {
> >         struct mmc_data *data = mrq->data;
> >
> > -       return host->pending_reset ||
> > +       return host->pending_reset || host->always_defer_done ||
> >                ((host->flags & SDHCI_REQ_USE_DMA) && data &&
> >                 data->host_cookie == COOKIE_MAPPED);
> >  }
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index d89cdb9..a73ce89 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -533,6 +533,7 @@ struct sdhci_host {
> >         bool pending_reset;     /* Cmd/data reset is pending */
> >         bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >         bool v4_mode;           /* Host Version 4 Enable */
> > +       bool always_defer_done; /* Always defer to complete requests */
> >
> >         struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
> >         struct mmc_command *cmd;        /* Current command */
> >
>
> Yes

Got it. Thanks for your confirming.

-- 
Baolin Wang
Best Regards
