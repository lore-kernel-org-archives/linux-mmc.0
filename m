Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C57828B;
	Fri, 31 May 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151532; cv=none; b=PQgzHS2PgxX57parLdAaGa6zs9+/crAfQ75XNAjNcK0NJn1MMU5YxIkmlrWwx38cPmuENIeBCtUnovpn38RYsrSiHZN/8E1F0vX32cPAXCNOosEMuM8duNtoYSy9d6LoP1vJ0uOYf4odYljppQ1uMYAZjh1i9UmyxuzyTvbtDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151532; c=relaxed/simple;
	bh=dDDEfEsjfFj4dAcpfnAUrhvu/hMoCIIpnPxuOy34JhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhxfOhn0kDhEeUIJatNGcaU/umPwYZ5RXeuSS1FcEx49dBqxzqwFOXqYfUK51+ZWU7zb1Fkgt9y82BPzcs+7MU91tWuXypfbdWNR11is505RExqVnpNfm4nVORstM5OgyZFreDYe8FmX2s8GhCc4Jf6HE0tHiKplehGiSPG7VSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/zOt286; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/zOt286"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48bb4f21172so435469137.3;
        Fri, 31 May 2024 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717151530; x=1717756330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcM/q+B64c+IL4z3ll1HNo6g5Ua5mFGJaDl0RMo26bw=;
        b=L/zOt286fPVQtRfoIQf3gm4hGixulnHmVoNGnxDIdg/1H5mBtOBaySjbVZDCCV0Ln+
         MXQc3b4YUElTT+bZJkmTeyZ+TW6xOsahgIgFaiafV8BJY5QhiKC8pP0aIzX79GzbMUH7
         qmyGiW4DNAQ0AYDdB7bBtCBiGqGnN9ZTnaR6evrBGZ/aKvKyhrY2cUccA8dniH4l+peg
         5LfM5H5D4ol+yYY5SQz/xt2rd0pgSfo9VdmA3KuzkPzIyEosGB6hi7GEdBo9UaVMxqn1
         6iKoCVFpJFIvae856MjJRKhri1m+gj7HAnesJO4q8Jurp0qoAS4V9ajNs8g6M7LbcJUK
         yvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717151530; x=1717756330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcM/q+B64c+IL4z3ll1HNo6g5Ua5mFGJaDl0RMo26bw=;
        b=T/IIbmlesL1gJJHbSqwfqhVdIVhIJ6o6BycDpadwznblSTx4fYdHOM4Li6/3qmM+AL
         3HH/DMmin8LxxeM/P2GmZJj+j8Xc98X9zcMszByHo+74MM6FqsFj3qNX0FyYmZWyFSab
         lire34BsARl1OB+RIxLO/cxSHFlpJpOCtasA7vyTB+BbnUIVMub0QpxtG0jshnBEEcwY
         9nJJVb+wyZX70MKk+QdD7buqe5kVUd1HPCj3qyn7auVvNsuGoANWZM79XHEt5l1eK6rE
         QQOooXzAoC9FzZFKIJffrOwrpDe3q1ItN8wjoxJWfAiohDiCMCCiRXyjcPuN4J3q77JH
         4ZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkT2QiZfZqPlmnGjXQxKLu3E7CY104JDhxdAbdbypo8d3exwY6J80PthBXJu/nG9ZPbqr7un5GpXEKtKU5VCy5FelvFKVil4PlJazx
X-Gm-Message-State: AOJu0YyoNGBlYHQFp/dG11iV/irYxxnG8opep8qd/ahfVSwJRYC6q78O
	cNASHX+9WFvoEjf+EdNgBgAIdC1V1CbcVIo1KodHgt9RdBaB0wBDV1ObR1f1mAtNNdynlWBM3j7
	yKXCN1tMFBE6q02+EdYkLmVVJFdY=
X-Google-Smtp-Source: AGHT+IFMx05bSFeyu9+XIMW5dT9oLVgwhPOC7hSRPgf5r+X56J3wm4qotnkJlP/JvyyuWn5DKR7+dZuysCe50OUcaew=
X-Received: by 2002:a67:ba0a:0:b0:48b:bce7:a80 with SMTP id
 ada2fe7eead31-48bc21a90a2mr1617620137.24.1717151529815; Fri, 31 May 2024
 03:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-9-victorshihgli@gmail.com> <4354636c-24dd-4145-a551-75dc5c69910b@intel.com>
In-Reply-To: <4354636c-24dd-4145-a551-75dc5c69910b@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 31 May 2024 18:31:57 +0800
Message-ID: <CAK00qKCRD1Xdb5DmWud9F=r85aVxtnQ5wS_=yhzQ46LS0Mjqsg@mail.gmail.com>
Subject: Re: [PATCH V16 08/23] mmc: core: Support UHS-II Auto Command Error Recovery
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 2:54=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 22/05/24 14:08, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Add UHS-II Auto Command Error Recovery functionality
> > into the MMC request processing flow.
>
> Not sure what "auto" means here, but the commit message
> should outline what the spec. requires for error recovery.
>

Hi, Adrian

     I will add instructions in the v17 version.

Thanks, Victor Shih

> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V16:
> >  - Separate the Error Recovery mechanism from patch#7 to patch#8.
> >
> > ---
> >
> >  drivers/mmc/core/core.c    |  4 ++
> >  drivers/mmc/core/core.h    |  1 +
> >  drivers/mmc/core/sd_uhs2.c | 80 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h   |  6 +++
> >  4 files changed, 91 insertions(+)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 68496c51a521..18642afc405f 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -403,6 +403,10 @@ void mmc_wait_for_req_done(struct mmc_host *host, =
struct mmc_request *mrq)
> >       while (1) {
> >               wait_for_completion(&mrq->completion);
> >
> > +             if (host->ops->get_cd(host))
> > +                     if (mrq->cmd->error || (mrq->data && mrq->data->e=
rror))
> > +                             mmc_sd_uhs2_error_recovery(host, mrq);
>
> There are several issues with this:
>
> 1. It is not OK to start a request from within the request path
> because it is recursive:
>
>    mmc_wait_for_req_done()                      <--
>       mmc_sd_uhs2_error_recovery()
>          sd_uhs2_abort_trans()
>             mmc_wait_for_cmd()
>                mmc_wait_for_req()
>                   mmc_wait_for_req_done()       <--
>
> 2. The mmc block driver does not use this path
>
> 3. No need to always call ->get_cd() if there is no error
>
> It is worth considering whether the host controller could
> send the abort command as part of the original request, as
> is done with the stop command.
>

Hi, Adrian

     1. It looks like just issuing a command in
mmc_wait_for_req_done() will cause a recursion.
         I will drop sd_uhs2_abort_trans() and
sd_uhs2_abort_status_read() in the v17 version.
     2. I have no idea about this part, could you please give me some advic=
e?
     3. I will try to modify this part in the v17 version.

Thanks, Victor Shih

> > +
> >               cmd =3D mrq->cmd;
> >
> >               if (!cmd->error || !cmd->retries ||
> > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > index 920323faa834..259d47c8bb19 100644
> > --- a/drivers/mmc/core/core.h
> > +++ b/drivers/mmc/core/core.h
> > @@ -82,6 +82,7 @@ int mmc_attach_mmc(struct mmc_host *host);
> >  int mmc_attach_sd(struct mmc_host *host);
> >  int mmc_attach_sdio(struct mmc_host *host);
> >  int mmc_attach_sd_uhs2(struct mmc_host *host);
> > +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_reque=
st *mrq);
> >
> >  /* Module parameters */
> >  extern bool use_spi_crc;
> > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > index 85939a2582dc..d5acb4e6ccac 100644
> > --- a/drivers/mmc/core/sd_uhs2.c
> > +++ b/drivers/mmc/core/sd_uhs2.c
> > @@ -1324,3 +1324,83 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
> >
> >       return err;
> >  }
> > +
> > +static void sd_uhs2_abort_trans(struct mmc_host *mmc)
> > +{
> > +     struct mmc_request mrq =3D {};
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     int err;
> > +
> > +     mrq.cmd =3D &cmd;
> > +     mmc->ongoing_mrq =3D &mrq;
> > +
> > +     uhs2_cmd.header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
> > +                       mmc->card->uhs2_config.node_id;
> > +     uhs2_cmd.arg =3D ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
> > +                     UHS2_NATIVE_CMD_WRITE |
> > +                     (UHS2_DEV_CMD_TRANS_ABORT >> 8);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> > +     err =3D mmc_wait_for_cmd(mmc, &cmd, 0);
> > +
> > +     if (err)
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(mmc), __func__, err);
> > +}
> > +
> > +static void sd_uhs2_abort_status_read(struct mmc_host *mmc)
> > +{
> > +     struct mmc_request mrq =3D {};
> > +     struct mmc_command cmd =3D {0};
> > +     struct uhs2_command uhs2_cmd =3D {};
> > +     int err;
> > +
> > +     mrq.cmd =3D &cmd;
> > +     mmc->ongoing_mrq =3D &mrq;
> > +
> > +     uhs2_cmd.header =3D UHS2_NATIVE_PACKET |
> > +                       UHS2_PACKET_TYPE_CCMD |
> > +                       mmc->card->uhs2_config.node_id;
> > +     uhs2_cmd.arg =3D ((UHS2_DEV_STATUS_REG & 0xFF) << 8) |
> > +                     UHS2_NATIVE_CMD_READ |
> > +                     UHS2_NATIVE_CMD_PLEN_4B |
> > +                     (UHS2_DEV_STATUS_REG >> 8);
> > +
> > +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> > +     err =3D mmc_wait_for_cmd(mmc, &cmd, 0);
> > +
> > +     if (err)
> > +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> > +                    mmc_hostname(mmc), __func__, err);
> > +}
> > +
> > +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_reque=
st *mrq)
> > +{
> > +     mmc->ops->uhs2_reset_cmd_data(mmc);
>
> The host controller should already have done any resets needed.
> sdhci already has support for doing that - see host->pending_reset
>

Hi, Adrian

     I'm not sure what this means. Could you please give me more informatio=
n?

Thanks, Victor Shih

> > +
> > +     if (mrq->data) {
> > +             if (mrq->data->error && mmc_card_uhs2(mmc)) {
> > +                     if (mrq->cmd) {
> > +                             switch (mrq->cmd->error) {
> > +                             case ETIMEDOUT:
> > +                             case EILSEQ:
> > +                             case EIO:
> > +                                     sd_uhs2_abort_trans(mmc);
> > +                                     sd_uhs2_abort_status_read(mmc);
>
> What is the purpose of sd_uhs2_abort_status_read() here?
> It is not obvious it does anything.
>

Hi, Adrian

     sd_uhs2_abort_status_read() seems to only have read status,
     I will drop this in the v17 version.

Thanks, Victor Shih

> > +                                     break;
> > +                             default:
> > +                                     break;
> > +                             }
> > +                     }
> > +             }
> > +     } else {
> > +             if (mrq->cmd) {
> > +                     switch (mrq->cmd->error) {
> > +                     case ETIMEDOUT:
> > +                             sd_uhs2_abort_trans(mmc);
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +}
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index fc9520b3bfa4..c914a58f7e1e 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -271,6 +271,12 @@ struct mmc_host_ops {
> >        * negative errno in case of a failure or zero for success.
> >        */
> >       int     (*uhs2_control)(struct mmc_host *host, enum sd_uhs2_opera=
tion op);
> > +
> > +     /*
> > +      * The uhs2_reset_cmd_data callback is used to excute reset
> > +      * when a auto command error occurs.
> > +      */
> > +     void    (*uhs2_reset_cmd_data)(struct mmc_host *host);
> >  };
> >
> >  struct mmc_cqe_ops {
>
