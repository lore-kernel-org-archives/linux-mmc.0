Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C92230F;
	Sun,  9 Jun 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717958420; cv=none; b=EhUIvge8sNvy9p3u90DdVO3bujNEIXJ2UlT7O9ZJ0TCYPqRPSX6zMajV3G4cK98iJcAq3ESUQOEjEzfKm2VJ0/0U5gXyBg1C4kZ3sFQb1f1rxVsmlzoH48/KYnagLWPApJmvRo8hXvatuMgemAihcs9uUdpupW6flpZXc9kK1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717958420; c=relaxed/simple;
	bh=+bViJuDxXa74UHn4YmTjEWVDpJeuv+vmp/IQOhBpbUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaOt3D1wemTymeGS6bkoiHNfki17UrSDOEuiDIUbXV6vfn6uIc1weNcHpHTB5s7UVvj+UwXx+KhQ1LbDCxnB6b1CMKh0Op3eY23ufh36JbU79AQfNeu+1+pX6c2GtGkQqe43tC+WGPWq0cCbKRXlx2XnWz/MhuwrC1CEnfd7fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuR4bvXq; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuR4bvXq"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-804ee8b03afso1077423241.0;
        Sun, 09 Jun 2024 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717958417; x=1718563217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLalX01o4044G4qjc+kHPp7MpcTDv6VnqaMgH/BUy8k=;
        b=HuR4bvXqB0zTGtlTTbOYTvcmyIdWdcfP2iBZRN9/pIzFbfNKH0ShOf3vAu5etKftze
         nBUUonjDz3o7eDDl5CwIcAi6afIGxEt1sXy4nJrcA3C38oTAvmqRA3Srb33Og6nd1u+t
         I/ka45ioNLSbTHuurtg8Rb7qG9Tgv65nJ10/Zfh3qiWRBrVyEEL7eAz4bwnVKQF/dO6e
         /qxkR2Y7TXB5eoT+3kX0u2eWM/yciKUxaRiHfLAZdYvkp4JtG0vBZsb+nH3LMI6L1qxY
         XIN6YNVSg1ahtqD88DjWJwrsnxK6YLkY44CksBYtQ8ct3EDEW4FlSNLYztf+czJUqeaX
         8U/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717958417; x=1718563217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLalX01o4044G4qjc+kHPp7MpcTDv6VnqaMgH/BUy8k=;
        b=GkWIr4n+ola+bbnVjjZ13hfoPLcSzg0pTEnNGds95CjHRhSmjiA7DoItotrh4+NVF6
         MfThcKSkwNKAsnlHyVziQSZlaljoqXn2nOAySF4s/FoZQQKH3Yj0o1tr8MWD9DqBjdGJ
         pZr46peeZcuw3g5bCx0VJpRfTyVEQqRRKf12lisQfGL0zIPdavkALl1oAJxyRcWrCBWT
         MNJcRmCMiyrIdeiKxwowEMtD3FxLyuEk0YpoCFaYnXKMprlw7I+1XMI1MWEN6dbC5tgH
         kMPaPAixd+Lj45neafAW1OCjcFwZ9HCLzDIOqCrKiUpJYp92LGd9CESe+zPjEG8mOori
         BuXA==
X-Forwarded-Encrypted: i=1; AJvYcCU81ulmOqUnNRgHnr7CtaphiyHzkmLD/GZ+mTQ/szervnd5hitqaMV6/onDuhSMdVr6f7CAN3mCC2VXkkiuT4/kqVNFHH5StWSHEyKc
X-Gm-Message-State: AOJu0Yysrblm8GW/j9de8bN5wQBlPDVyVAsvVT/qfNpGl4892CnesPl/
	bH5W/mYhk+eHGQdELe1bK0mBZIAnUJxDo90lKG+cyQvyN4mid0YktXQYSaTXeBBJqcpK101O7cu
	JhFoOFpwHXHsAz/BTmpggFWpDe1M=
X-Google-Smtp-Source: AGHT+IHzx4REhqhCgV7VOEsx43Fefo6LRmYcB4taGEm99vDtReySNKBIedezN20FM6Vi+Tn0MDtEE3JJ03bsZrm3yco=
X-Received: by 2002:a67:ebcc:0:b0:48c:39d6:4c43 with SMTP id
 ada2fe7eead31-48c39d64df5mr5375382137.25.1717958417456; Sun, 09 Jun 2024
 11:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-9-victorshihgli@gmail.com> <4354636c-24dd-4145-a551-75dc5c69910b@intel.com>
 <CAK00qKCRD1Xdb5DmWud9F=r85aVxtnQ5wS_=yhzQ46LS0Mjqsg@mail.gmail.com> <84c57084-eb9d-4d11-9c2f-2a4ded6290c6@intel.com>
In-Reply-To: <84c57084-eb9d-4d11-9c2f-2a4ded6290c6@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Mon, 10 Jun 2024 02:40:10 +0800
Message-ID: <CAK00qKAHuLKGtcUnv=pKyQ4bKe+HqM1rFCQMRxPrGH9Aeat6Qw@mail.gmail.com>
Subject: Re: [PATCH V16 08/23] mmc: core: Support UHS-II Auto Command Error Recovery
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 7:23=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/05/24 13:31, Victor Shih wrote:
> > On Fri, May 24, 2024 at 2:54=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 22/05/24 14:08, Victor Shih wrote:
> >>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>
> >>> Add UHS-II Auto Command Error Recovery functionality
> >>> into the MMC request processing flow.
> >>
> >> Not sure what "auto" means here, but the commit message
> >> should outline what the spec. requires for error recovery.
> >>
> >
> > Hi, Adrian
> >
> >      I will add instructions in the v17 version.
> >
> > Thanks, Victor Shih
> >
> >>>
> >>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>> ---
> >>>
> >>> Updates in V16:
> >>>  - Separate the Error Recovery mechanism from patch#7 to patch#8.
> >>>
> >>> ---
> >>>
> >>>  drivers/mmc/core/core.c    |  4 ++
> >>>  drivers/mmc/core/core.h    |  1 +
> >>>  drivers/mmc/core/sd_uhs2.c | 80 ++++++++++++++++++++++++++++++++++++=
++
> >>>  include/linux/mmc/host.h   |  6 +++
> >>>  4 files changed, 91 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>> index 68496c51a521..18642afc405f 100644
> >>> --- a/drivers/mmc/core/core.c
> >>> +++ b/drivers/mmc/core/core.c
> >>> @@ -403,6 +403,10 @@ void mmc_wait_for_req_done(struct mmc_host *host=
, struct mmc_request *mrq)
> >>>       while (1) {
> >>>               wait_for_completion(&mrq->completion);
> >>>
> >>> +             if (host->ops->get_cd(host))
> >>> +                     if (mrq->cmd->error || (mrq->data && mrq->data-=
>error))
> >>> +                             mmc_sd_uhs2_error_recovery(host, mrq);
> >>
> >> There are several issues with this:
> >>
> >> 1. It is not OK to start a request from within the request path
> >> because it is recursive:
> >>
> >>    mmc_wait_for_req_done()                      <--
> >>       mmc_sd_uhs2_error_recovery()
> >>          sd_uhs2_abort_trans()
> >>             mmc_wait_for_cmd()
> >>                mmc_wait_for_req()
> >>                   mmc_wait_for_req_done()       <--
> >>
> >> 2. The mmc block driver does not use this path
> >>
> >> 3. No need to always call ->get_cd() if there is no error
> >>
> >> It is worth considering whether the host controller could
> >> send the abort command as part of the original request, as
> >> is done with the stop command.
> >>
> >
> > Hi, Adrian
> >
> >      1. It looks like just issuing a command in
> > mmc_wait_for_req_done() will cause a recursion.
> >          I will drop sd_uhs2_abort_trans() and
> > sd_uhs2_abort_status_read() in the v17 version.
> >      2. I have no idea about this part, could you please give me some a=
dvice?
>
> The mmc block driver sets the ->done() callback and so
> mmc_wait_for_req_done() is never called for data transfers.
>
> That won't matter if the host controller handles doing
> the abort command, as was suggested elsewhere.
>
> >      3. I will try to modify this part in the v17 version.
> >
> > Thanks, Victor Shih
> >
> >>> +
> >>>               cmd =3D mrq->cmd;
> >>>
> >>>               if (!cmd->error || !cmd->retries ||
> >>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> >>> index 920323faa834..259d47c8bb19 100644
> >>> --- a/drivers/mmc/core/core.h
> >>> +++ b/drivers/mmc/core/core.h
> >>> @@ -82,6 +82,7 @@ int mmc_attach_mmc(struct mmc_host *host);
> >>>  int mmc_attach_sd(struct mmc_host *host);
> >>>  int mmc_attach_sdio(struct mmc_host *host);
> >>>  int mmc_attach_sd_uhs2(struct mmc_host *host);
> >>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_req=
uest *mrq);
> >>>
> >>>  /* Module parameters */
> >>>  extern bool use_spi_crc;
> >>> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> >>> index 85939a2582dc..d5acb4e6ccac 100644
> >>> --- a/drivers/mmc/core/sd_uhs2.c
> >>> +++ b/drivers/mmc/core/sd_uhs2.c
> >>> @@ -1324,3 +1324,83 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
> >>>
> >>>       return err;
> >>>  }
> >>> +
> >>> +static void sd_uhs2_abort_trans(struct mmc_host *mmc)
> >>> +{
> >>> +     struct mmc_request mrq =3D {};
> >>> +     struct mmc_command cmd =3D {0};
> >>> +     struct uhs2_command uhs2_cmd =3D {};
> >>> +     int err;
> >>> +
> >>> +     mrq.cmd =3D &cmd;
> >>> +     mmc->ongoing_mrq =3D &mrq;
> >>> +
> >>> +     uhs2_cmd.header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD =
|
> >>> +                       mmc->card->uhs2_config.node_id;
> >>> +     uhs2_cmd.arg =3D ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
> >>> +                     UHS2_NATIVE_CMD_WRITE |
> >>> +                     (UHS2_DEV_CMD_TRANS_ABORT >> 8);
> >>> +
> >>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> >>> +     err =3D mmc_wait_for_cmd(mmc, &cmd, 0);
> >>> +
> >>> +     if (err)
> >>> +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> >>> +                    mmc_hostname(mmc), __func__, err);
> >>> +}
> >>> +
> >>> +static void sd_uhs2_abort_status_read(struct mmc_host *mmc)
> >>> +{
> >>> +     struct mmc_request mrq =3D {};
> >>> +     struct mmc_command cmd =3D {0};
> >>> +     struct uhs2_command uhs2_cmd =3D {};
> >>> +     int err;
> >>> +
> >>> +     mrq.cmd =3D &cmd;
> >>> +     mmc->ongoing_mrq =3D &mrq;
> >>> +
> >>> +     uhs2_cmd.header =3D UHS2_NATIVE_PACKET |
> >>> +                       UHS2_PACKET_TYPE_CCMD |
> >>> +                       mmc->card->uhs2_config.node_id;
> >>> +     uhs2_cmd.arg =3D ((UHS2_DEV_STATUS_REG & 0xFF) << 8) |
> >>> +                     UHS2_NATIVE_CMD_READ |
> >>> +                     UHS2_NATIVE_CMD_PLEN_4B |
> >>> +                     (UHS2_DEV_STATUS_REG >> 8);
> >>> +
> >>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> >>> +     err =3D mmc_wait_for_cmd(mmc, &cmd, 0);
> >>> +
> >>> +     if (err)
> >>> +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> >>> +                    mmc_hostname(mmc), __func__, err);
> >>> +}
> >>> +
> >>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_req=
uest *mrq)
> >>> +{
> >>> +     mmc->ops->uhs2_reset_cmd_data(mmc);
> >>
> >> The host controller should already have done any resets needed.
> >> sdhci already has support for doing that - see host->pending_reset
> >>
> >
> > Hi, Adrian
> >
> >      I'm not sure what this means. Could you please give me more inform=
ation?
>
> sdhci_uhs2_request_done() checks sdhci_needs_reset() and does
> sdhci_uhs2_reset().
>
> sdhci_needs_reset() does not cater for data errors because
> the reset for data errors is done directly in what becomes
> __sdhci_finish_data_common().
>
> You may need to:
>  1. add a parameter to __sdhci_finish_data_common() to
>  skip doing the sdhci reset and instead set
>  host->pending_reset
>  2. amend sdhci_uhs2_request_done() to check for data error
>  also to decide if a reset is needed
>

Hi, Adrian

If there is any mistake in my understanding, please help me correct it.
My understanding is as follows:

static bool sdhci_uhs2_request_done(struct sdhci_host *host)
{
      ...
      if (sdhci_needs_reset(host, mrq)) {
            ...
            if (mrq->cmd->error || (mrq->data && mrq->data->error))
                  sdhci_uhs2_reset_cmd_data(host->mmc);
            ...
      }
      ...
}

I have another question. the sdhci_uhs2_request_done() belongs to the patch=
#18.
Can the above content be modified directly in the patch#18?
Or does it need to be separated into another patch?

Thanks, Victor Shih

> >
> > Thanks, Victor Shih
> >
> >>> +
> >>> +     if (mrq->data) {
> >>> +             if (mrq->data->error && mmc_card_uhs2(mmc)) {
> >>> +                     if (mrq->cmd) {
> >>> +                             switch (mrq->cmd->error) {
> >>> +                             case ETIMEDOUT:
> >>> +                             case EILSEQ:
> >>> +                             case EIO:
> >>> +                                     sd_uhs2_abort_trans(mmc);
> >>> +                                     sd_uhs2_abort_status_read(mmc);
> >>
> >> What is the purpose of sd_uhs2_abort_status_read() here?
> >> It is not obvious it does anything.
> >>
> >
> > Hi, Adrian
> >
> >      sd_uhs2_abort_status_read() seems to only have read status,
> >      I will drop this in the v17 version.
> >
> > Thanks, Victor Shih
> >
> >>> +                                     break;
> >>> +                             default:
> >>> +                                     break;
> >>> +                             }
> >>> +                     }
> >>> +             }
> >>> +     } else {
> >>> +             if (mrq->cmd) {
> >>> +                     switch (mrq->cmd->error) {
> >>> +                     case ETIMEDOUT:
> >>> +                             sd_uhs2_abort_trans(mmc);
> >>> +                             break;
> >>> +                     }
> >>> +             }
> >>> +     }
> >>> +}
> >>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >>> index fc9520b3bfa4..c914a58f7e1e 100644
> >>> --- a/include/linux/mmc/host.h
> >>> +++ b/include/linux/mmc/host.h
> >>> @@ -271,6 +271,12 @@ struct mmc_host_ops {
> >>>        * negative errno in case of a failure or zero for success.
> >>>        */
> >>>       int     (*uhs2_control)(struct mmc_host *host, enum sd_uhs2_ope=
ration op);
> >>> +
> >>> +     /*
> >>> +      * The uhs2_reset_cmd_data callback is used to excute reset
> >>> +      * when a auto command error occurs.
> >>> +      */
> >>> +     void    (*uhs2_reset_cmd_data)(struct mmc_host *host);
> >>>  };
> >>>
> >>>  struct mmc_cqe_ops {
> >>
>
