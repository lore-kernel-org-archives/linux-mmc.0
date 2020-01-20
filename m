Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D658C33CA1
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 08:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21122077C
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 08:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR97wZBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgATIOs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:14:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46927 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATIOs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 03:14:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so28403755wrl.13;
        Mon, 20 Jan 2020 00:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIic33wM3WlTJ/qyfJXoCISYAJdeCBgMYcJKMtJGZhk=;
        b=hR97wZBLWr1+Ibu1Ok50ubBmNZKDYxODRZGXmDgSE8I4z+qigOztYfDFRGhRbTBZNg
         vQrZH0sniNsaGedRp8/E1Nx8upDIiQZBvlWnzHvYE23kG2CuD7K7BlNo+Yz5UyY1EXNW
         /PODrFK9DeJ9fB9R10m7IqikGUNPD8nJpBUxeBHt+kmOozb1k7WGkOld2Rx90iYmagN0
         CterkSvdulr/3kvrKQt4aX9ilhVn8pYe95vUzHYvihYDoWX+lqAtQPq0lXUK5WKHqKhk
         fE4VTQl+MD8x24OkGou3MHHvPbUfa7fEpjZnCTx6TxYPPRPyRRye/nCsIR8Ywxhl0IkX
         1k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIic33wM3WlTJ/qyfJXoCISYAJdeCBgMYcJKMtJGZhk=;
        b=U6wiac5SEs0OG7Qxnjude9HGsKq0hjPT1nsfPZeyDtLTXqe8BG3vpQSM1U4QGgandu
         Dt+AnVcS68Bm7zzi8qzgbisydJEHLv+zse6wf1o51z9Gp/BI5zwF2PMq80zsXRSG8QBP
         T6p154Ik/Sg7oc8muIrNme+zqQALPa2rsuFdyTWSU0NqTaN0QQWeAhY9pTyirZF88BXv
         SGdxIc8jwWHJmORdkjpa8NRBh/FpZw204+536Dgh45IBOhaucAPy6rl7MuKMJE1yEJyj
         pZxZmkxNztkU5woYB7nxH2UV7jJpj6IiU8Y5wq5xXUeFoOu6VNM3Q1ihe33acuqNwW0B
         xfmQ==
X-Gm-Message-State: APjAAAVYqSoXe/0B6ICS/BpIG5iWdZjbdrYVVm2CFP35WICnUnXCsdpO
        kpeXbL9iCdW7WRw8reUj8AetWVlS3owqK2kC1gQ=
X-Google-Smtp-Source: APXvYqzgV/mG0TFZfplGPIk8mHqPPEpkeRaeT9UjNfROg6vhcZWqbbE6tfq0jl5yXrghTaEq4G+Z5sWN77M00vQS+ZY=
X-Received: by 2002:a5d:5704:: with SMTP id a4mr17680370wrv.198.1579508085926;
 Mon, 20 Jan 2020 00:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20200120031023.32482-1-zhang.chunyan@linaro.org>
 <20200120033223.897-1-zhang.chunyan@linaro.org> <65f7272c-ecea-03de-433b-21ba2e672d20@intel.com>
In-Reply-To: <65f7272c-ecea-03de-433b-21ba2e672d20@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 20 Jan 2020 16:14:09 +0800
Message-ID: <CAAfSe-vjmFGkK5Enj9Nj_qrERJbNQTLejpVL+JVJLG7tgNhT9w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: fix an issue of mixing different types
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jan 2020 at 15:15, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/01/20 5:32 am, Chunyan Zhang wrote:
> > Fix an issue reported by sparse, since mixed types of parameters are
> > used on calling dmaengine_prep_slave_sg().
> >
> > Fixes: 36e1da441fec (mmc: sdhci: add support for using external DMA devices)
>
> That commit number is only in next

Ok, so should this line be removed?

>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you!

Chunyan

>
> > ---
> > Changes from v1:
> > * address comments from Nathan Chancellor
> > - define a new variable to avoid type conversions.
> > ---
> >  drivers/mmc/host/sdhci.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 30b5a624b50e..f9e0b5f2c692 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1201,6 +1201,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
> >                                   struct mmc_command *cmd)
> >  {
> >       int ret, i;
> > +     enum dma_transfer_direction dir;
> >       struct dma_async_tx_descriptor *desc;
> >       struct mmc_data *data = cmd->data;
> >       struct dma_chan *chan;
> > @@ -1234,8 +1235,8 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
> >       if (sg_cnt <= 0)
> >               return -EINVAL;
> >
> > -     desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
> > -                                    mmc_get_dma_dir(data),
> > +     dir = data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> > +     desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len, dir,
> >                                      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >       if (!desc)
> >               return -EINVAL;
> >
>
