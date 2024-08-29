Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93218DF68;
	Thu, 29 Aug 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923344; cv=none; b=JEPiHfEI5HJGoK+d4DM5lnd9KxvZ0cq8e3NpsWcXYeSTpg9bWh7lQBLxACv9fqcpHfM+noFeW+yWbsMt/YrXeVqfMtIsYMG/PVgXvV9mYBq/WcwtjhjU/gyAKyZF5kYQL+fZ9H6rTrk4d1U/S+WMoa1ubkKCHINDF5Y8arjLsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923344; c=relaxed/simple;
	bh=2+aOxuqNbAW3W20Nin81sIpvL61zUCMSk1x5LqBfuyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ewnd7HyFRw/plPbJD0uCt+TY0bWGCF034lrmkU37NeUXFgEJHPZxuKf+3i/AhRJw0lyHsNnR/PUz4kxFuREJNuJwTygIjhcSLvPKEzTOIFVU3LkeSD4ML0JpTptSIPSpANsz6FH47u/cZXr1+dW+dEJ6Q/imkpGhfReDL0iezOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJvPuYc/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJvPuYc/"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4fd01b38dd7so197358e0c.0;
        Thu, 29 Aug 2024 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923341; x=1725528141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twRBYkOONX0wlD5mmd98ubanboiDWGmAa6bHWXyyDQc=;
        b=CJvPuYc/kQ9M9LFPku8PNYcUYO9Dotq/BmuYlJhPUYR/A6KzcnXqNngR98PWldOpy8
         Yb3zjduPXOTms9PEYqjQ/9gFuTErgSKd6G4a6LXSB4V40yd/6KY7T4cLkRdYTuL84mZv
         maWUr9WuY3VPAOKddOqcIuHwueVdbZpqidKoONFU87K8qA7hJTfGCN2IzfqprmIhOKVU
         paID7d3gbhAHUjMoAVgbrcW0K1e/tUpvABPqNGCfVgO/YsHRKhCWvhr3Wc+rTWG2aXF/
         +ieoLcpdf0N5omsvn0hLWNgmtV93m/mYvHX+n18bneKFrmkd45Kmy9/SpXtXrBXYWij5
         9ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923341; x=1725528141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twRBYkOONX0wlD5mmd98ubanboiDWGmAa6bHWXyyDQc=;
        b=ryU8w9Zd0+cBQj+ELlEp8uRW7sHi0GebB5J0GG/DPuhyEtOXivvpDPXf/MABxPmGC1
         tC+8SLMf7P1iZPem4J2zj7UD2RIbgtQFRxM6zGdWbg4UWPkfRMHqgL5cPNBn5k24dT1M
         ogTtt7PEPyoWg4Q+muf/efIltha5wd83UcJbs1y40yKBhr5BR1rOc+ip6d1Sr8fG0eFo
         jfYnDXo47wK7/tgYKwzPmbA0U/Ods9/96qMdGPDeOhzVwi1zM47lNfzz1XFNQITTjFSX
         CDm99wOMqYxMu0fDcvPLXTtYBlj1dO6q5P/tKqKmq8NSEMAZgXRMipMlNsYCcatoWrQv
         EE1g==
X-Forwarded-Encrypted: i=1; AJvYcCU0kb7+MbRi5H0fh2L1kb0zaFZH6EsLZ7ZcdD/zN3wMxTpNTbyN6LjyINdZ3XZrkI6jFsclBZN2wYh1E0s=@vger.kernel.org, AJvYcCVVMg6wnFxjF9DUo7NJz+ynxoU415jPYhqHNFS6er5nUR0EzQmTia7DvBZnKasBrTAJJW9sU4hlIpG2@vger.kernel.org
X-Gm-Message-State: AOJu0YykiqWGLHeoO80z5zb+NaeMCH2FJ8/XhogsV8k9VG1heJKRVuRu
	fA/d3eSEfUcZbUaVmnocC5EaBiPL62JJawNc3qytv3/B2v4+G0zveuAHrcZjVJJ3PeiopKXeb/j
	bRwMbdC8zW6wPdz+mPXvT7c3rzBY=
X-Google-Smtp-Source: AGHT+IFJkjQvXr6VQAjOPJQmvSjxANkfDvlmAjUwQ8RI1iRPH2IYd+btq0nvysOsN6lNq41vIzroRk/bqDbMBB2f7Ec=
X-Received: by 2002:a05:6122:2017:b0:4f2:a973:8ae with SMTP id
 71dfb90a1353d-4ffe4a7d640mr2461906e0c.5.1724923340885; Thu, 29 Aug 2024
 02:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802102229.10204-1-victorshihgli@gmail.com>
 <20240802102229.10204-18-victorshihgli@gmail.com> <a1ed46af-cd9d-4f5d-8780-80349318cb9b@intel.com>
In-Reply-To: <a1ed46af-cd9d-4f5d-8780-80349318cb9b@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 29 Aug 2024 17:22:02 +0800
Message-ID: <CAK00qKD25EFJ2EJ8uJThhNpTH-4paBu67NWG77RmuCNidZ19dQ@mail.gmail.com>
Subject: Re: [PATCH V18 17/22] mmc: sdhci-uhs2: add irq() and others
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 8:44=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 2/08/24 13:22, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a UHS-II version of sdhci's request() operation.
> > It handles UHS-II related command interrupts and errors.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V18:
> >  - Modify the judgment condition in the sdhci_uhs2_reset_cmd_data() and
> >    replace it from mmc_card_uhs2() to host->mmc->uhs2_sd_tran flag.
> >
> > Updates in V17:
> >  - Add sdhci_uhs2_reset_cmd_data() and sdhci_uhs2_needs_reset() to
> >    resolve the data error or cmd error.
> >
> > Updates in V14:
> >  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >    sdhci_uhs2_complete_work(), sdhci_uhs2_irq() and
> >    sdhci_uhs2_thread_irq().
> >
> > Updates in V13:
> >  - Re-order function to avoid declaration.
> >  - Remove unnecessary definitions.
> >
> > Updates in V9:
> >  - Cancel export state of sdhci_set_mrq_done() function.
> >
> > Updates in V8:
> >  - Forward declare struct mmc_request in sdhci_uhs2.h.
> >  - Remove forward declaration of sdhci_send_command().
> >  - Use mmc_dev() to simplify code in sdhci_request_done_dma().
> >
> > Updates in V7:
> >  - Remove unnecessary functions.
> >  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_irq().
> >  - Modify descriptions in sdhci_uhs2_irq().
> >  - Cancel export state of some functions.
> >
> > Updates in V6:
> >  - Remove unnecessary functions.
> >  - Add sdhci_uhs2_mode() in sdhci_uhs2_complete_work().
> >  - Add sdhci_uhs2_mode() in sdhci_uhs2_thread_irq().
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 237 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   2 +
> >  drivers/mmc/host/sdhci.c      | 102 ++++++++-------
> >  drivers/mmc/host/sdhci.h      |   5 +
> >  4 files changed, 300 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 31486e28496d..c9bd438e9c26 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -106,6 +106,19 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16=
 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >
> > +static void sdhci_uhs2_reset_cmd_data(struct sdhci_host *host)
> > +{
> > +     sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> > +
> > +     if (host->mmc->uhs2_sd_tran) {
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +
> > +             sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +             sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +             sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI=
_UHS2_INT_ERROR_MASK);
> > +     }
> > +}
> > +
> >  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,=
 unsigned short vdd)
> >  {
> >       struct mmc_host *mmc =3D host->mmc;
> > @@ -904,6 +917,230 @@ static void sdhci_uhs2_request(struct mmc_host *m=
mc, struct mmc_request *mrq)
> >       spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Request done                                                       =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static bool sdhci_uhs2_needs_reset(struct sdhci_host *host, struct mmc=
_request *mrq)
> > +{
> > +     return sdhci_needs_reset(host, mrq) ||
> > +            (!(host->flags & SDHCI_DEVICE_DEAD) && mrq->data && mrq->d=
ata->error);
> > +}
> > +
> > +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> > +{
> > +     unsigned long flags;
> > +     struct mmc_request *mrq;
> > +     int i;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     for (i =3D 0; i < SDHCI_MAX_MRQS; i++) {
> > +             mrq =3D host->mrqs_done[i];
> > +             if (mrq)
> > +                     break;
> > +     }
> > +
> > +     if (!mrq) {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> > +             return true;
> > +     }
> > +
> > +     /*
> > +      * Always unmap the data buffers if they were mapped by
> > +      * sdhci_prepare_data() whenever we finish with a request.
> > +      * This avoids leaking DMA mappings on error.
> > +      */
> > +     if (host->flags & SDHCI_REQ_USE_DMA)
> > +             sdhci_request_done_dma(host, mrq);
> > +
> > +     /*
> > +      * The controller needs a reset of internal state machines
> > +      * upon error conditions.
> > +      */
> > +     if (sdhci_uhs2_needs_reset(host, mrq)) {
> > +             /*
> > +              * Do not finish until command and data lines are availab=
le for
> > +              * reset. Note there can only be one other mrq, so it can=
not
> > +              * also be in mrqs_done, otherwise host->cmd and host->da=
ta_cmd
> > +              * would both be null.
> > +              */
> > +             if (host->cmd || host->data_cmd) {
> > +                     spin_unlock_irqrestore(&host->lock, flags);
> > +                     return true;
> > +             }
> > +
> > +             if (mrq->cmd->error || mrq->data->error)
> > +                     sdhci_uhs2_reset_cmd_data(host);
> > +             else
> > +                     sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET);
>
> sdhci_uhs2_reset() 2nd parameter is mask but SDHCI_UHS2_SW_RESET
> is the register offset
>

Hi, Adrian

I will correct this issue in the next version.

Thanks, Victor Shih

> > +             host->pending_reset =3D false;
> > +     }
> > +
> > +     host->mrqs_done[i] =3D NULL;
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     if (host->ops->request_done)
> > +             host->ops->request_done(host, mrq);
> > +     else
> > +             mmc_request_done(host->mmc, mrq);
> > +
> > +     return false;
> > +}
> > +
> > +static void sdhci_uhs2_complete_work(struct work_struct *work)
> > +{
> > +     struct sdhci_host *host =3D container_of(work, struct sdhci_host,
> > +                                            complete_work);
> > +
> > +     if (!mmc_card_uhs2(host->mmc)) {
> > +             sdhci_complete_work(work);
> > +             return;
> > +     }
> > +
> > +     while (!sdhci_uhs2_request_done(host))
> > +             ;
> > +}
> > +
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Interrupt handling                                                 =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
> > +{
> > +     struct mmc_command *cmd =3D host->cmd;
> > +
> > +     DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
> > +         mmc_hostname(host->mmc), uhs2mask);
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
> > +             if (!host->cmd) {
> > +                     pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\=
n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +             host->cmd->error =3D -EILSEQ;
> > +             if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
> > +                     host->cmd->error =3D -ETIMEDOUT;
> > +     }
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
> > +             if (!host->data) {
> > +                     pr_err("%s: Got data interrupt 0x%08x but no data=
.\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +
> > +             if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
> > +                     pr_err("%s: Got deadlock timeout interrupt 0x%08x=
\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     host->data->error =3D -ETIMEDOUT;
> > +             } else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
> > +                     pr_err("%s: ADMA error =3D 0x %x\n",
> > +                            mmc_hostname(host->mmc),
> > +                            sdhci_readb(host, SDHCI_ADMA_ERROR));
> > +                     host->data->error =3D -EIO;
> > +             } else {
> > +                     host->data->error =3D -EILSEQ;
> > +             }
> > +     }
> > +
> > +     if (host->data && host->data->error)
> > +             sdhci_uhs2_finish_data(host);
> > +     else
> > +             sdhci_finish_mrq(host, cmd->mrq);
> > +}
> > +
> > +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
> > +{
> > +     u32 mask =3D intmask, uhs2mask;
> > +
> > +     if (!mmc_card_uhs2(host->mmc))
> > +             goto out;
> > +
> > +     if (intmask & SDHCI_INT_ERROR) {
> > +             uhs2mask =3D sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
> > +             if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
> > +                     goto cmd_irq;
> > +
> > +             /* Clear error interrupts */
> > +             sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
> > +                          SDHCI_UHS2_INT_STATUS);
> > +
> > +             /* Handle error interrupts */
> > +             __sdhci_uhs2_irq(host, uhs2mask);
> > +
> > +             /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
errors */
> > +             intmask &=3D ~SDHCI_INT_ERROR;
> > +             mask &=3D SDHCI_INT_ERROR;
> > +     }
> > +
> > +cmd_irq:
> > +     if (intmask & SDHCI_INT_CMD_MASK) {
> > +             /* Clear command interrupt */
> > +             sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_IN=
T_STATUS);
> > +
> > +             /* Handle command interrupt */
> > +             if (intmask & SDHCI_INT_RESPONSE)
> > +                     sdhci_uhs2_finish_command(host);
> > +
> > +             /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
commands */
> > +             intmask &=3D ~SDHCI_INT_CMD_MASK;
> > +             mask &=3D SDHCI_INT_CMD_MASK;
> > +     }
> > +
> > +     /* Clear already-handled interrupts. */
> > +     sdhci_writel(host, mask, SDHCI_INT_STATUS);
> > +
> > +out:
> > +     return intmask;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
> > +
> > +static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
> > +{
> > +     struct sdhci_host *host =3D dev_id;
> > +     struct mmc_command *cmd;
> > +     unsigned long flags;
> > +     u32 isr;
> > +
> > +     if (!mmc_card_uhs2(host->mmc))
> > +             return sdhci_thread_irq(irq, dev_id);
> > +
> > +     while (!sdhci_uhs2_request_done(host))
> > +             ;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     isr =3D host->thread_isr;
> > +     host->thread_isr =3D 0;
> > +
> > +     cmd =3D host->deferred_cmd;
> > +     if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
> > +             sdhci_finish_mrq(host, cmd->mrq);
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> > +             struct mmc_host *mmc =3D host->mmc;
> > +
> > +             mmc->ops->card_event(mmc);
> > +             mmc_detect_change(mmc, msecs_to_jiffies(200));
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index f6649a518842..077a2c7a6cb0 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -176,11 +176,13 @@
> >
> >  struct sdhci_host;
> >  struct mmc_command;
> > +struct mmc_request;
> >
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,=
 unsigned short vdd);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
> >  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set);
> > +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index a43a3b8d7b8b..442a89234b54 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -235,7 +235,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_reset);
> >
> > -static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> > +bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> >  {
> >       if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
> >               struct mmc_host *mmc =3D host->mmc;
> > @@ -248,6 +248,7 @@ static bool sdhci_do_reset(struct sdhci_host *host,=
 u8 mask)
> >
> >       return true;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_do_reset);
> >
> >  static void sdhci_reset_for_all(struct sdhci_host *host)
> >  {
> > @@ -1497,7 +1498,7 @@ static void sdhci_set_transfer_mode(struct sdhci_=
host *host,
> >       sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
> >  }
> >
> > -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_requ=
est *mrq)
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mr=
q)
> >  {
> >       return (!(host->flags & SDHCI_DEVICE_DEAD) &&
> >               ((mrq->cmd && mrq->cmd->error) ||
> > @@ -1505,6 +1506,7 @@ static bool sdhci_needs_reset(struct sdhci_host *=
host, struct mmc_request *mrq)
> >                (mrq->data && mrq->data->stop && mrq->data->stop->error)=
 ||
> >                (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_needs_reset);
> >
> >  static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_req=
uest *mrq)
> >  {
> > @@ -3097,6 +3099,53 @@ static const struct mmc_host_ops sdhci_ops =3D {
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_reques=
t *mrq)
> > +{
> > +     struct mmc_data *data =3D mrq->data;
> > +
> > +     if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> > +             if (host->bounce_buffer) {
> > +                     /*
> > +                      * On reads, copy the bounced data into the
> > +                      * sglist
> > +                      */
> > +                     if (mmc_get_dma_dir(data) =3D=3D DMA_FROM_DEVICE)=
 {
> > +                             unsigned int length =3D data->bytes_xfere=
d;
> > +
> > +                             if (length > host->bounce_buffer_size) {
> > +                                     pr_err("%s: bounce buffer is %u b=
ytes but DMA claims to have transferred %u bytes\n",
> > +                                            mmc_hostname(host->mmc),
> > +                                            host->bounce_buffer_size,
> > +                                            data->bytes_xfered);
> > +                                     /* Cap it down and continue */
> > +                                     length =3D host->bounce_buffer_si=
ze;
> > +                             }
> > +                             dma_sync_single_for_cpu(mmc_dev(host->mmc=
),
> > +                                                     host->bounce_addr=
,
> > +                                                     host->bounce_buff=
er_size,
> > +                                                     DMA_FROM_DEVICE);
> > +                             sg_copy_from_buffer(data->sg,
> > +                                                 data->sg_len,
> > +                                                 host->bounce_buffer,
> > +                                                 length);
> > +                     } else {
> > +                             /* No copying, just switch ownership */
> > +                             dma_sync_single_for_cpu(mmc_dev(host->mmc=
),
> > +                                                     host->bounce_addr=
,
> > +                                                     host->bounce_buff=
er_size,
> > +                                                     mmc_get_dma_dir(d=
ata));
> > +                     }
> > +             } else {
> > +                     /* Unmap the raw data */
> > +                     dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> > +                                  data->sg_len,
> > +                                  mmc_get_dma_dir(data));
> > +             }
> > +             data->host_cookie =3D COOKIE_UNMAPPED;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
> > +
> >  static bool sdhci_request_done(struct sdhci_host *host)
> >  {
> >       unsigned long flags;
> > @@ -3161,48 +3210,7 @@ static bool sdhci_request_done(struct sdhci_host=
 *host)
> >                       sdhci_set_mrq_done(host, mrq);
> >               }
> >
> > -             if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> > -                     if (host->bounce_buffer) {
> > -                             /*
> > -                              * On reads, copy the bounced data into t=
he
> > -                              * sglist
> > -                              */
> > -                             if (mmc_get_dma_dir(data) =3D=3D DMA_FROM=
_DEVICE) {
> > -                                     unsigned int length =3D data->byt=
es_xfered;
> > -
> > -                                     if (length > host->bounce_buffer_=
size) {
> > -                                             pr_err("%s: bounce buffer=
 is %u bytes but DMA claims to have transferred %u bytes\n",
> > -                                                    mmc_hostname(host-=
>mmc),
> > -                                                    host->bounce_buffe=
r_size,
> > -                                                    data->bytes_xfered=
);
> > -                                             /* Cap it down and contin=
ue */
> > -                                             length =3D host->bounce_b=
uffer_size;
> > -                                     }
> > -                                     dma_sync_single_for_cpu(
> > -                                             mmc_dev(host->mmc),
> > -                                             host->bounce_addr,
> > -                                             host->bounce_buffer_size,
> > -                                             DMA_FROM_DEVICE);
> > -                                     sg_copy_from_buffer(data->sg,
> > -                                             data->sg_len,
> > -                                             host->bounce_buffer,
> > -                                             length);
> > -                             } else {
> > -                                     /* No copying, just switch owners=
hip */
> > -                                     dma_sync_single_for_cpu(
> > -                                             mmc_dev(host->mmc),
> > -                                             host->bounce_addr,
> > -                                             host->bounce_buffer_size,
> > -                                             mmc_get_dma_dir(data));
> > -                             }
> > -                     } else {
> > -                             /* Unmap the raw data */
> > -                             dma_unmap_sg(mmc_dev(host->mmc), data->sg=
,
> > -                                          data->sg_len,
> > -                                          mmc_get_dma_dir(data));
> > -                     }
> > -                     data->host_cookie =3D COOKIE_UNMAPPED;
> > -             }
> > +             sdhci_request_done_dma(host, mrq);
> >       }
> >
> >       host->mrqs_done[i] =3D NULL;
> > @@ -3217,7 +3225,7 @@ static bool sdhci_request_done(struct sdhci_host =
*host)
> >       return false;
> >  }
> >
> > -static void sdhci_complete_work(struct work_struct *work)
> > +void sdhci_complete_work(struct work_struct *work)
> >  {
> >       struct sdhci_host *host =3D container_of(work, struct sdhci_host,
> >                                              complete_work);
> > @@ -3225,6 +3233,7 @@ static void sdhci_complete_work(struct work_struc=
t *work)
> >       while (!sdhci_request_done(host))
> >               ;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_complete_work);
> >
> >  static void sdhci_timeout_timer(struct timer_list *t)
> >  {
> > @@ -3686,7 +3695,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_i=
d)
> >       return result;
> >  }
> >
> > -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> >  {
> >       struct sdhci_host *host =3D dev_id;
> >       struct mmc_command *cmd;
> > @@ -3716,6 +3725,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void=
 *dev_id)
> >
> >       return IRQ_HANDLED;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
> >
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index ff53ad592d85..941723cea698 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -831,6 +831,7 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
> >  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,=
 unsigned long timeout);
> >  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *d=
ata);
> >  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)=
;
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mr=
q);
> >  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *m=
rq);
> >  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
);
> >  void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_re=
set);
> > @@ -853,6 +854,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc=
_request *mrq);
> >  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq=
);
> >  void sdhci_set_bus_width(struct sdhci_host *host, int width);
> >  void sdhci_reset(struct sdhci_host *host, u8 mask);
> > +bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)=
;
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> >  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> > @@ -862,6 +864,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc=
_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
> >  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_reques=
t *mrq);
> > +void sdhci_complete_work(struct work_struct *work);
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
> >  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> >                          dma_addr_t addr, int len, unsigned int cmd);
> >
>
