Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8712C46F;
	Fri, 21 Jun 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937096; cv=none; b=BvDvDHNcGo8Z6KTC8kI3ixO1ln0Hm2q9P68uIvW3XHoM18U5d5X8oy0uoyHPPxRSqyfJfA3lwpz/CtDKC+WaNvuCV/6vLk/gn+PlR9kgnr327AbsExDJdUPphAmkNFjv4WAvhFbhQ0PuMONEGb35h79h5e0iodDB8U2xcnTS7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937096; c=relaxed/simple;
	bh=q/LxFNhik+DWDPQ9VEh44vfHwyUOugEXvPVUFIPj7jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQJh1VS79Ll9t3qlSYEj1g6Sc+0Fd3xtU0uLS9c15pgto+jkSUlbYLs3oqsKwdRkgNn2UOwOP1VQ3HyukfsAv1AZqM7xlZCcbEYx6DuWVdAgbayiqlUJXogVsET19c9if1YQV5WRb396qNXpfiKMEd/X9DHBjxGvZ0Pvhdq3Sqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhoqeDde; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhoqeDde"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6ef64b092cso169910066b.1;
        Thu, 20 Jun 2024 19:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937091; x=1719541891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyHpd5T6+uz22Iwq0ar8KfwFU7mqYCVeTdoWGzEly8Q=;
        b=nhoqeDdeICi7cnG0YULmadg6KSUDCY+TUgq+DpXve/s+sQJM9i+JNYT4zn7ymJdLEZ
         kDKIQzQploNXXrXlsBu4ntiEQSAI3aq74EW9CwCY7wZZNrwy0pAbDs/egLBlRX+b43W/
         pTvvIPYODeKn7R7aCZ1fmmbqidSOshbykTBnd+6SLQ0Iwn1JondBtRmiXsTl7KPbohnA
         qz66X+rbr5BFeSVtmlEWeK38L9wu80a3lHDPYYmMs2X1tec24kNRQctIeXqSOt5wo5fZ
         J6QbqfbfcPhxi4D3VBNzt/Nbzq44XfMKYSqglh6nMm9D65ssD89eErSN7/RoMWkPIC+G
         E2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937091; x=1719541891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyHpd5T6+uz22Iwq0ar8KfwFU7mqYCVeTdoWGzEly8Q=;
        b=vuqRMS4fWZ1wT6yXnAxIIz0tE+OateC7j+tObEiIsArEuwVOOq35Uh/2kfUbPuB72i
         4QTjWyTcILfk3A9wTu3hR4vPdGMLG1c2ONdccbELfOpyKH6yTf3V9OcnoMlEUTXqOwxS
         kGNaCybtku3QgNgAhXmVhkTvuKoWVJhBukVkOMnHwKk3OsPfdS3cs4y7PFjokmmdsPEK
         9Io1bD9J4aeHWdOCTCTFauUM39nCvf1hzqn5CsNnM3KoZrcHXvFifccPnYcO5Kt2khoB
         l8EB7iHFZIdRjqS1vRw7uEfuqSbBoseH93Xw/2QWodvSg+yvqGmA1uux7gKYlGENisMa
         t9PA==
X-Forwarded-Encrypted: i=1; AJvYcCUPwvRhqCdanhPVY9J5+Fq0qc3eeNKytO8Z0ZfVY0OLAiLDhS6NCvCZ58ISdzBooLD6h6nOwdCx25iSgZDSraJ3YzCe4om9Dj2UevB+I9PujyrxgbiYwC8d0z7UWIjBZBbsCifp00sm
X-Gm-Message-State: AOJu0Yx+PfFm+EEals2+lx8CT22nOMu6/BBwZ/T2H9nLbCXkXVpAm9w0
	SUeVSq9LtC0zFt+RL0av81Sd/i8v+K9AK0kNK/EN3IjBCvXr2zZ1Ol85DB1tFFFPywXaHhIq+Tm
	+CtiB8KdCFijrnqIbB/R2kpQodfs=
X-Google-Smtp-Source: AGHT+IEE2zKtFe/CVBwchZdHF1VuvqWoqJvNQs5qFPOZjml57WKP1pvhcN7NCAd48BsVznKXdLNPpw+OuB7WrBWKLTc=
X-Received: by 2002:a17:906:682:b0:a6f:86fd:72b8 with SMTP id
 a640c23a62f3a-a6fab648c90mr447950166b.42.1718937090562; Thu, 20 Jun 2024
 19:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620104444.5862-1-victorshihgli@gmail.com> <20240620104444.5862-18-victorshihgli@gmail.com>
In-Reply-To: <20240620104444.5862-18-victorshihgli@gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Fri, 21 Jun 2024 10:31:16 +0800
Message-ID: <CACT4zj9visXkZDqeEAhbaDPJ5N1muasrj=Y_fNN=Zuze8F-inw@mail.gmail.com>
Subject: Re: [PATCH V17 17/22] mmc: sdhci-uhs2: add irq() and others
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Victor,

On Thu, Jun 20, 2024 at 6:46=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a UHS-II version of sdhci's request() operation.
> It handles UHS-II related command interrupts and errors.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V17:
>  - Add sdhci_uhs2_reset_cmd_data() and sdhci_uhs2_needs_reset() to
>    resolve the data error or cmd error.
>
> Updates in V14:
>  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
>    sdhci_uhs2_complete_work(), sdhci_uhs2_irq() and
>    sdhci_uhs2_thread_irq().
>
> Updates in V13:
>  - Re-order function to avoid declaration.
>  - Remove unnecessary definitions.
>
> Updates in V9:
>  - Cancel export state of sdhci_set_mrq_done() function.
>
> Updates in V8:
>  - Forward declare struct mmc_request in sdhci_uhs2.h.
>  - Remove forward declaration of sdhci_send_command().
>  - Use mmc_dev() to simplify code in sdhci_request_done_dma().
>
> Updates in V7:
>  - Remove unnecessary functions.
>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_irq().
>  - Modify descriptions in sdhci_uhs2_irq().
>  - Cancel export state of some functions.
>
> Updates in V6:
>  - Remove unnecessary functions.
>  - Add sdhci_uhs2_mode() in sdhci_uhs2_complete_work().
>  - Add sdhci_uhs2_mode() in sdhci_uhs2_thread_irq().
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 237 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   2 +
>  drivers/mmc/host/sdhci.c      | 102 ++++++++-------
>  drivers/mmc/host/sdhci.h      |   5 +
>  4 files changed, 300 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.=
c
> index 31486e28496d..2ed00c8abe88 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -106,6 +106,19 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 m=
ask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>
> +static void sdhci_uhs2_reset_cmd_data(struct sdhci_host *host)
> +{
> +       sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);

Can the SDHCI_RESET_DATA bit be used in UHS-II mode?
Because you put it here it means that the sdhci_uhs2_reset_cmd_data()
can be used with other vendor chips in addition to GL9755/GL9767.
In order to have no side effects for all, please help check the Spec.

Best regards,
Ben Chuang

> +
> +       if (mmc_card_uhs2(host->mmc)) {
> +               sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +
> +               sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +               sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +               sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI=
_UHS2_INT_ERROR_MASK);
> +       }
> +}
> +
>  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, u=
nsigned short vdd)
>  {
>         struct mmc_host *mmc =3D host->mmc;
> @@ -904,6 +917,230 @@ static void sdhci_uhs2_request(struct mmc_host *mmc=
, struct mmc_request *mrq)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> +/***********************************************************************=
******\
> + *                                                                      =
     *
> + * Request done                                                         =
     *
> + *                                                                      =
     *
> +\***********************************************************************=
******/
> +
> +static bool sdhci_uhs2_needs_reset(struct sdhci_host *host, struct mmc_r=
equest *mrq)
> +{
> +       return sdhci_needs_reset(host, mrq) ||
> +              (!(host->flags & SDHCI_DEVICE_DEAD) && mrq->data && mrq->d=
ata->error);
> +}
> +
> +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> +{
> +       unsigned long flags;
> +       struct mmc_request *mrq;
> +       int i;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       for (i =3D 0; i < SDHCI_MAX_MRQS; i++) {
> +               mrq =3D host->mrqs_done[i];
> +               if (mrq)
> +                       break;
> +       }
> +
> +       if (!mrq) {
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               return true;
> +       }
> +
> +       /*
> +        * Always unmap the data buffers if they were mapped by
> +        * sdhci_prepare_data() whenever we finish with a request.
> +        * This avoids leaking DMA mappings on error.
> +        */
> +       if (host->flags & SDHCI_REQ_USE_DMA)
> +               sdhci_request_done_dma(host, mrq);
> +
> +       /*
> +        * The controller needs a reset of internal state machines
> +        * upon error conditions.
> +        */
> +       if (sdhci_uhs2_needs_reset(host, mrq)) {
> +               /*
> +                * Do not finish until command and data lines are availab=
le for
> +                * reset. Note there can only be one other mrq, so it can=
not
> +                * also be in mrqs_done, otherwise host->cmd and host->da=
ta_cmd
> +                * would both be null.
> +                */
> +               if (host->cmd || host->data_cmd) {
> +                       spin_unlock_irqrestore(&host->lock, flags);
> +                       return true;
> +               }
> +
> +               if (mrq->cmd->error || mrq->data->error)
> +                       sdhci_uhs2_reset_cmd_data(host);
> +               else
> +                       sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET);
> +               host->pending_reset =3D false;
> +       }
> +
> +       host->mrqs_done[i] =3D NULL;
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       if (host->ops->request_done)
> +               host->ops->request_done(host, mrq);
> +       else
> +               mmc_request_done(host->mmc, mrq);
> +
> +       return false;
> +}
> +
> +static void sdhci_uhs2_complete_work(struct work_struct *work)
> +{
> +       struct sdhci_host *host =3D container_of(work, struct sdhci_host,
> +                                              complete_work);
> +
> +       if (!mmc_card_uhs2(host->mmc)) {
> +               sdhci_complete_work(work);
> +               return;
> +       }
> +
> +       while (!sdhci_uhs2_request_done(host))
> +               ;
> +}
> +
> +/***********************************************************************=
******\
> + *                                                                      =
     *
> + * Interrupt handling                                                   =
     *
> + *                                                                      =
     *
> +\***********************************************************************=
******/
> +
> +static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
> +{
> +       struct mmc_command *cmd =3D host->cmd;
> +
> +       DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
> +           mmc_hostname(host->mmc), uhs2mask);
> +
> +       if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
> +               if (!host->cmd) {
> +                       pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\=
n",
> +                              mmc_hostname(host->mmc),
> +                              (unsigned int)uhs2mask);
> +                       sdhci_dumpregs(host);
> +                       return;
> +               }
> +               host->cmd->error =3D -EILSEQ;
> +               if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
> +                       host->cmd->error =3D -ETIMEDOUT;
> +       }
> +
> +       if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
> +               if (!host->data) {
> +                       pr_err("%s: Got data interrupt 0x%08x but no data=
.\n",
> +                              mmc_hostname(host->mmc),
> +                              (unsigned int)uhs2mask);
> +                       sdhci_dumpregs(host);
> +                       return;
> +               }
> +
> +               if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
> +                       pr_err("%s: Got deadlock timeout interrupt 0x%08x=
\n",
> +                              mmc_hostname(host->mmc),
> +                              (unsigned int)uhs2mask);
> +                       host->data->error =3D -ETIMEDOUT;
> +               } else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
> +                       pr_err("%s: ADMA error =3D 0x %x\n",
> +                              mmc_hostname(host->mmc),
> +                              sdhci_readb(host, SDHCI_ADMA_ERROR));
> +                       host->data->error =3D -EIO;
> +               } else {
> +                       host->data->error =3D -EILSEQ;
> +               }
> +       }
> +
> +       if (host->data && host->data->error)
> +               sdhci_uhs2_finish_data(host);
> +       else
> +               sdhci_finish_mrq(host, cmd->mrq);
> +}
> +
> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
> +{
> +       u32 mask =3D intmask, uhs2mask;
> +
> +       if (!mmc_card_uhs2(host->mmc))
> +               goto out;
> +
> +       if (intmask & SDHCI_INT_ERROR) {
> +               uhs2mask =3D sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
> +               if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
> +                       goto cmd_irq;
> +
> +               /* Clear error interrupts */
> +               sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
> +                            SDHCI_UHS2_INT_STATUS);
> +
> +               /* Handle error interrupts */
> +               __sdhci_uhs2_irq(host, uhs2mask);
> +
> +               /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
errors */
> +               intmask &=3D ~SDHCI_INT_ERROR;
> +               mask &=3D SDHCI_INT_ERROR;
> +       }
> +
> +cmd_irq:
> +       if (intmask & SDHCI_INT_CMD_MASK) {
> +               /* Clear command interrupt */
> +               sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_IN=
T_STATUS);
> +
> +               /* Handle command interrupt */
> +               if (intmask & SDHCI_INT_RESPONSE)
> +                       sdhci_uhs2_finish_command(host);
> +
> +               /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
commands */
> +               intmask &=3D ~SDHCI_INT_CMD_MASK;
> +               mask &=3D SDHCI_INT_CMD_MASK;
> +       }
> +
> +       /* Clear already-handled interrupts. */
> +       sdhci_writel(host, mask, SDHCI_INT_STATUS);
> +
> +out:
> +       return intmask;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
> +
> +static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
> +{
> +       struct sdhci_host *host =3D dev_id;
> +       struct mmc_command *cmd;
> +       unsigned long flags;
> +       u32 isr;
> +
> +       if (!mmc_card_uhs2(host->mmc))
> +               return sdhci_thread_irq(irq, dev_id);
> +
> +       while (!sdhci_uhs2_request_done(host))
> +               ;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       isr =3D host->thread_isr;
> +       host->thread_isr =3D 0;
> +
> +       cmd =3D host->deferred_cmd;
> +       if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
> +               sdhci_finish_mrq(host, cmd->mrq);
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> +               struct mmc_host *mmc =3D host->mmc;
> +
> +               mmc->ops->card_event(mmc);
> +               mmc_detect_change(mmc, msecs_to_jiffies(200));
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
>  /***********************************************************************=
******\
>   *                                                                      =
     *
>   * Driver init/exit                                                     =
     *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.=
h
> index f6649a518842..077a2c7a6cb0 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -176,11 +176,13 @@
>
>  struct sdhci_host;
>  struct mmc_command;
> +struct mmc_request;
>
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, u=
nsigned short vdd);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command =
*cmd);
>  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 s=
et);
> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
>
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4eff8a9f6b9a..7c9d475eacb7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -235,7 +235,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_reset);
>
> -static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  {
>         if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>                 struct mmc_host *mmc =3D host->mmc;
> @@ -248,6 +248,7 @@ static bool sdhci_do_reset(struct sdhci_host *host, u=
8 mask)
>
>         return true;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_do_reset);
>
>  static void sdhci_reset_for_all(struct sdhci_host *host)
>  {
> @@ -1497,7 +1498,7 @@ static void sdhci_set_transfer_mode(struct sdhci_ho=
st *host,
>         sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
>  }
>
> -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_reques=
t *mrq)
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>         return (!(host->flags & SDHCI_DEVICE_DEAD) &&
>                 ((mrq->cmd && mrq->cmd->error) ||
> @@ -1505,6 +1506,7 @@ static bool sdhci_needs_reset(struct sdhci_host *ho=
st, struct mmc_request *mrq)
>                  (mrq->data && mrq->data->stop && mrq->data->stop->error)=
 ||
>                  (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
>  }
> +EXPORT_SYMBOL_GPL(sdhci_needs_reset);
>
>  static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_reque=
st *mrq)
>  {
> @@ -3113,6 +3115,53 @@ static const struct mmc_host_ops sdhci_ops =3D {
>   *                                                                      =
     *
>  \***********************************************************************=
******/
>
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request =
*mrq)
> +{
> +       struct mmc_data *data =3D mrq->data;
> +
> +       if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> +               if (host->bounce_buffer) {
> +                       /*
> +                        * On reads, copy the bounced data into the
> +                        * sglist
> +                        */
> +                       if (mmc_get_dma_dir(data) =3D=3D DMA_FROM_DEVICE)=
 {
> +                               unsigned int length =3D data->bytes_xfere=
d;
> +
> +                               if (length > host->bounce_buffer_size) {
> +                                       pr_err("%s: bounce buffer is %u b=
ytes but DMA claims to have transferred %u bytes\n",
> +                                              mmc_hostname(host->mmc),
> +                                              host->bounce_buffer_size,
> +                                              data->bytes_xfered);
> +                                       /* Cap it down and continue */
> +                                       length =3D host->bounce_buffer_si=
ze;
> +                               }
> +                               dma_sync_single_for_cpu(mmc_dev(host->mmc=
),
> +                                                       host->bounce_addr=
,
> +                                                       host->bounce_buff=
er_size,
> +                                                       DMA_FROM_DEVICE);
> +                               sg_copy_from_buffer(data->sg,
> +                                                   data->sg_len,
> +                                                   host->bounce_buffer,
> +                                                   length);
> +                       } else {
> +                               /* No copying, just switch ownership */
> +                               dma_sync_single_for_cpu(mmc_dev(host->mmc=
),
> +                                                       host->bounce_addr=
,
> +                                                       host->bounce_buff=
er_size,
> +                                                       mmc_get_dma_dir(d=
ata));
> +                       }
> +               } else {
> +                       /* Unmap the raw data */
> +                       dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> +                                    data->sg_len,
> +                                    mmc_get_dma_dir(data));
> +               }
> +               data->host_cookie =3D COOKIE_UNMAPPED;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
> +
>  static bool sdhci_request_done(struct sdhci_host *host)
>  {
>         unsigned long flags;
> @@ -3177,48 +3226,7 @@ static bool sdhci_request_done(struct sdhci_host *=
host)
>                         sdhci_set_mrq_done(host, mrq);
>                 }
>
> -               if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> -                       if (host->bounce_buffer) {
> -                               /*
> -                                * On reads, copy the bounced data into t=
he
> -                                * sglist
> -                                */
> -                               if (mmc_get_dma_dir(data) =3D=3D DMA_FROM=
_DEVICE) {
> -                                       unsigned int length =3D data->byt=
es_xfered;
> -
> -                                       if (length > host->bounce_buffer_=
size) {
> -                                               pr_err("%s: bounce buffer=
 is %u bytes but DMA claims to have transferred %u bytes\n",
> -                                                      mmc_hostname(host-=
>mmc),
> -                                                      host->bounce_buffe=
r_size,
> -                                                      data->bytes_xfered=
);
> -                                               /* Cap it down and contin=
ue */
> -                                               length =3D host->bounce_b=
uffer_size;
> -                                       }
> -                                       dma_sync_single_for_cpu(
> -                                               mmc_dev(host->mmc),
> -                                               host->bounce_addr,
> -                                               host->bounce_buffer_size,
> -                                               DMA_FROM_DEVICE);
> -                                       sg_copy_from_buffer(data->sg,
> -                                               data->sg_len,
> -                                               host->bounce_buffer,
> -                                               length);
> -                               } else {
> -                                       /* No copying, just switch owners=
hip */
> -                                       dma_sync_single_for_cpu(
> -                                               mmc_dev(host->mmc),
> -                                               host->bounce_addr,
> -                                               host->bounce_buffer_size,
> -                                               mmc_get_dma_dir(data));
> -                               }
> -                       } else {
> -                               /* Unmap the raw data */
> -                               dma_unmap_sg(mmc_dev(host->mmc), data->sg=
,
> -                                            data->sg_len,
> -                                            mmc_get_dma_dir(data));
> -                       }
> -                       data->host_cookie =3D COOKIE_UNMAPPED;
> -               }
> +               sdhci_request_done_dma(host, mrq);
>         }
>
>         host->mrqs_done[i] =3D NULL;
> @@ -3233,7 +3241,7 @@ static bool sdhci_request_done(struct sdhci_host *h=
ost)
>         return false;
>  }
>
> -static void sdhci_complete_work(struct work_struct *work)
> +void sdhci_complete_work(struct work_struct *work)
>  {
>         struct sdhci_host *host =3D container_of(work, struct sdhci_host,
>                                                complete_work);
> @@ -3241,6 +3249,7 @@ static void sdhci_complete_work(struct work_struct =
*work)
>         while (!sdhci_request_done(host))
>                 ;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_complete_work);
>
>  static void sdhci_timeout_timer(struct timer_list *t)
>  {
> @@ -3702,7 +3711,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>         return result;
>  }
>
> -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  {
>         struct sdhci_host *host =3D dev_id;
>         struct mmc_command *cmd;
> @@ -3732,6 +3741,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *=
dev_id)
>
>         return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
>
>  /***********************************************************************=
******\
>   *                                                                      =
     *
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 3a68fd1e4bd3..d3098d231122 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -833,6 +833,7 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
>  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, u=
nsigned long timeout);
>  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *dat=
a);
>  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)=
;
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
);
>  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_rese=
t);
> @@ -854,6 +855,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_r=
equest *mrq);
>  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> @@ -863,6 +865,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_i=
os *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>                                       struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request =
*mrq);
> +void sdhci_complete_work(struct work_struct *work);
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>                            dma_addr_t addr, int len, unsigned int cmd);
>
> --
> 2.25.1
>
