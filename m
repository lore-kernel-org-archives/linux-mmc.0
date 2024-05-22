Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413F7D408;
	Wed, 22 May 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368694; cv=none; b=NQNT+YocbCW24MiLDREEnf+H0SkCxeBe6Lzk9YPBJur3I43OcZ/B/RRwiXak8LP/fR5ltvTkIaIfYe5N0jl62DficO7lrkT/QOQ+MryE/a6HaHVP16XoB3tjiAlBq7UDZKbwqGRgj40QfcPhvGejelotiucrSSXbS9C42YvBxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368694; c=relaxed/simple;
	bh=XoTU9HNyaj5Avp1zAP2fBjOZt1/Wrp+7dlpGOUx3EsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3PlUv8Zjl92KtWv7LmWSWRoqm/UcCEcuQLEyVVfus8vzXejCywt0E1DUTJ/Y7G4a8qkhEuxm9Dk2yh3QCZ5Ftzz5a6EIgIE8fsKLsq8KW2vpiSrtDpzeEPnb4W8m0iey/+/tB2iXveUWf667B8qFghgzJaP1cVV+WeOWUmbbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO+Vl960; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO+Vl960"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so1633755e0c.1;
        Wed, 22 May 2024 02:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368691; x=1716973491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuT14G4ulVhQ3VeO2a2c3aVIXoJ0Gf/lR6vI4Z46YJk=;
        b=NO+Vl960RlHBMlU44k7lOpR5z2tzP/EyhvXTe9LkH1LETMK7xlcWiU10RAjb4FkQjO
         Ai45hcOQC8MjNh4aroX2jmQXdCCIQnWkhCgD/+qFMn5HQ3ptX+3eaJxHBPSarFd+0aOa
         XQG7vUHHQ7opIllOi3eff+hFpDy0DFYF6/xu4odhm0v5Gmz2daZx/LRGXW9VCrCMDqkE
         Ql8gTozkReK3/0yXICGaom5Kplpr69VhAKX5nlojvnCVB1vuTNa3fPpIFirsEYu6BkKX
         hJkQD7+C8zrMQBW3pagx/uvMn17fg3DE4Fp+LQyDb3S7nF4sQI98zu9N03SmOl/4kzCw
         p2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368691; x=1716973491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuT14G4ulVhQ3VeO2a2c3aVIXoJ0Gf/lR6vI4Z46YJk=;
        b=iPrOyOqVmTDvHKdVUeIZ5XuNRHGdNj4iMMvhC5H0GzHiy9zYVuJ4dOlOS39ys6iV/d
         Vaa1pj1RZGRu0zgt1nGSg7vwc/NJLzM2+7uIBdP+BeMdMLJZuZ/oO39U1Ag3bVjoCk5h
         mESAm6W6uZNj6j1e8XyfD/snNLF1ol63DU9iEv+ZNoFis6tdZTePf2qJp7FpnaWtHCXl
         8KQe1SqQkuqpT/TZ2Xgh3sjcSmA4t63T9SxMQh4/efTf5K4dB3cTj+jO5c24uBCDmq5z
         gP/cnlfSjmB5/6b8Zn8hQj7q8rvQp+cfXkQK/5r1ifZj9vfQqDsrZB+YeszXwtGkHF4z
         FaGA==
X-Forwarded-Encrypted: i=1; AJvYcCWX2Rl7HyugO7Zt3QWmvq8X8irB16xrImqCY5s6lf3lrAwgWN6kZ1MIFkf7oYmjb2ugKt7XgjpLN01bsfQe1pLUEcE61KnJrX7O4JmbTqsS1hdza0/AQmiCYfado489mp9C9W93HtLa
X-Gm-Message-State: AOJu0YxRii/EXTriSgwCNNHk7WH72tUWgR1HUvJTLa23kJM8rdpKQ6Fj
	UnrScbvh1x7gA0Ywj36PI+eCAs4iWOmC1Xupa2t4QQWsgDpf05F5ENDb6xQryN1KKvIeD2qioId
	B9gY9pxg5ozXRhxuaRv7zJN1OpoM=
X-Google-Smtp-Source: AGHT+IG8wL1izuP/xo42A2rkMiV2NKEQ6n5nAmRJtqvWecagI1ALgXmwTvySfYms0yDZ3fE7oZrjCZhPMhw628x1kW4=
X-Received: by 2002:a05:6122:1351:b0:4df:2ce2:6e4 with SMTP id
 71dfb90a1353d-4e2184e70cdmr1231897e0c.4.1716368689611; Wed, 22 May 2024
 02:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123062827.8525-1-victorshihgli@gmail.com>
 <20240123062827.8525-8-victorshihgli@gmail.com> <CAK00qKBf24CMFygfutpfxQwaKEQEo+FKv2XU4X_oxv38un-YEg@mail.gmail.com>
 <a81d0f82-ec9b-4ccf-b31b-9ef9d403ec6b@intel.com>
In-Reply-To: <a81d0f82-ec9b-4ccf-b31b-9ef9d403ec6b@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Wed, 22 May 2024 17:04:37 +0800
Message-ID: <CAK00qKDzY7gSALrKLqdQg-JdwXDP6NDt17oAX2aoj4P-yfDkPA@mail.gmail.com>
Subject: Re: [PATCH V14 07/21] mmc: core: Support UHS-II card control and access
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Jason Lai <jason.lai@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 5:36=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 27/01/24 10:28, Victor Shih wrote:
> > On Tue, Jan 23, 2024 at 2:28=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> >>
> >> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>
> >> Embed UHS-II access/control functionality into the MMC request
> >> processing flow.
> >>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> >> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >> ---
> >>
> >> Updates in V13:
> >>  - Separate __mmc_go_idle() into one patch for re-factorring the code.
> >>  - Move mmc_decode_scr declaration to sd.h.
> >>  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> >>  - Drop unnecessary comment.
> >>
> >> Updates in V12:
> >>  - Use mmc_op_multi() to check DCMD which supports multi read/write
> >>    in mmc_uhs2_prepare_cmd().
> >>
> >> Updates in V10:
> >>  - Move some definitions of PatchV9[02/23] to PatchV10[06/23].
> >>  - Move some definitions of PatchV9[05/23] to PatchV10[06/23].
> >>  - Drop do_multi in the mmc_blk_rw_rq_prep().
> >>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag.
> >>  - Move entire control of the tmode into mmc_uhs2_prepare_cmd().
> >>
> >> Updates in V8:
> >>  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> >>  - Modify return value in sd_uhs2_attach().
> >>
> >> Updates in V7:
> >>  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
> >>  - Drop uhs2_state in favor of ios->timing.
> >>  - Remove unnecessary functions.
> >>
> >> ---
> >>
> >>  drivers/mmc/core/core.c    |   10 +-
> >>  drivers/mmc/core/sd.c      |   10 +-
> >>  drivers/mmc/core/sd.h      |    5 +
> >>  drivers/mmc/core/sd_ops.c  |    9 +
> >>  drivers/mmc/core/sd_ops.h  |   17 +
> >>  drivers/mmc/core/sd_uhs2.c | 1115 ++++++++++++++++++++++++++++++++++-=
-
> >>  include/linux/mmc/core.h   |   13 +
> >>  include/linux/mmc/host.h   |   15 +
> >>  8 files changed, 1155 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index 2edf31492a5d..be77cebe1fb8 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, str=
uct mmc_request *mrq)
> >>
> >>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> >>  {
> >> +       struct uhs2_command uhs2_cmd;
> >> +       __be32 payload[4]; /* for maximum size */
> >>         int err;
> >>
> >>         init_completion(&mrq->cmd_completion);
> >> @@ -351,6 +353,8 @@ int mmc_start_request(struct mmc_host *host, struc=
t mmc_request *mrq)
> >>         if (err)
> >>                 return err;
> >>
> >> +       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> >> +
> >>         led_trigger_event(host->led, LED_FULL);
> >>         __mmc_start_request(host, mrq);
> >>
> >
> > Hi, Adrian
> >
> > I referenced your comments of the V9:
> >
> > Refer:
> > https://patchwork.kernel.org/project/linux-mmc/patch/20230721101349.123=
87-7-victorshihgli@gmail.com/
> >
> > My understanding is as follows, please correct me if there are any mist=
akes.
> > There is already "struct uhs2_command *uhs2_cmd" in struct mmc_command.
> > If I also put "__be32 payload[4]" in struct mmc_command.
> > The code will become:
> > mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd, mrq->cmd->pay=
load);
> > But a null pointer problem occurs when sending commands like COM0(mmc_g=
o_idle).
> > In this case I just can only plan for the time being as follows:
> >
> > if (mrq->cmd->uhs2_cmd)
> >      mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd,
> > mrq->cmd->payload);
> > else
> >      mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> >
> > Would you give me any other advice?
>
> struct uhs2_command uhs2_cmd should not be on the stack local to
> mmc_start_request().  Probably moving it to struct mmc_request
> is as good as any other option.  So starting like below and
> then with whatever other changes are needed to make it work.
>
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index be77cebe1fb8..68496c51a521 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -334,8 +334,6 @@ static int mmc_mrq_prep(struct mmc_host *host, struct=
 mmc_request *mrq)
>
>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
> -       struct uhs2_command uhs2_cmd;
> -       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         init_completion(&mrq->cmd_completion);
> @@ -353,7 +351,7 @@ int mmc_start_request(struct mmc_host *host, struct m=
mc_request *mrq)
>         if (err)
>                 return err;
>
> -       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> +       mmc_uhs2_card_prepare_cmd(host, mrq);
>
>         led_trigger_event(host->led, LED_FULL);
>         __mmc_start_request(host, mrq);
> @@ -434,8 +432,6 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
>   */
>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
> -       struct uhs2_command uhs2_cmd;
> -       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         /*
> @@ -456,7 +452,7 @@ int mmc_cqe_start_req(struct mmc_host *host, struct m=
mc_request *mrq)
>         if (err)
>                 goto out_err;
>
> -       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> +       mmc_uhs2_card_prepare_cmd(host, mrq);
>
>         err =3D host->cqe_ops->cqe_request(host, mrq);
>         if (err)
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index d3a3465c7669..e3af68a52de8 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -24,14 +24,10 @@ int mmc_app_sd_status(struct mmc_card *card, void *ss=
r);
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
>  void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq=
);
>
> -static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, stru=
ct mmc_request *mrq,
> -                                            struct uhs2_command uhs2_cmd=
, __be32 payload[4])
> +static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, stru=
ct mmc_request *mrq)
>  {
> -       if (host->uhs2_sd_tran) {
> -               uhs2_cmd.payload =3D payload;
> -               mrq->cmd->uhs2_cmd =3D &uhs2_cmd;
> +       if (host->uhs2_sd_tran)
>                 mmc_uhs2_prepare_cmd(host, mrq);
> -       }
>  }
>
>  static inline int mmc_sd_can_poweroff_notify(struct mmc_card *card)
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index c46729d85644..9cabb6937dc1 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -1194,6 +1194,7 @@ void mmc_uhs2_prepare_cmd(struct mmc_host *host, st=
ruct mmc_request *mrq)
>         u8 plen;
>
>         cmd =3D mrq->cmd;
> +       cmd->uhs2_cmd =3D &mrq->uhs2_cmd;
>         header =3D host->card->uhs2_config.node_id;
>         if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC)
>                 header |=3D UHS2_PACKET_TYPE_DCMD;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index f30f6be86f66..83c901794c17 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -23,13 +23,18 @@ enum mmc_blk_status {
>         MMC_BLK_NEW_REQUEST,
>  };
>
> +#define UHS2_MAX_PAYLOAD_LEN 2
> +#define UHS2_MAX_RESP_LEN 20
> +
>  struct uhs2_command {
>         u16     header;
>         u16     arg;
> -       __be32  *payload;
> -       u32     payload_len;
> -       u32     packet_len;
> +       __be32  payload[UHS2_MAX_PAYLOAD_LEN];
> +       u8      payload_len;
> +       u8      packet_len;     // TODO: is this really needed?
>         u8      tmode_half_duplex;
> +       u8      uhs2_resp_len;  /* UHS2 native cmd resp len */
> +       u8      uhs2_resp[UHS2_MAX_RESP_LEN];   /* UHS2 native cmd resp *=
/
>  };
>
>  struct mmc_command {
> @@ -119,8 +124,6 @@ struct mmc_command {
>         struct mmc_request      *mrq;           /* associated request */
>
>         struct uhs2_command     *uhs2_cmd;      /* UHS2 command */
> -       u8                      *uhs2_resp;     /* UHS2 native cmd resp *=
/
> -       u8                      uhs2_resp_len;  /* UHS2 native cmd resp l=
en */
>  };
>
>  struct mmc_data {
> @@ -179,6 +182,7 @@ struct mmc_request {
>         const struct bio_crypt_ctx *crypto_ctx;
>         int                     crypto_key_slot;
>  #endif
> +       struct uhs2_command     uhs2_cmd;
>  };
>
>  struct mmc_card;
>
>
>

Hi, Adrian

I have modified the above into patch#7 and patch#16 in the patch series v15=
.
But I will submit the patch series v16 later.
Please help review the changes in patch series v16.

Thanks, Victor Shih
