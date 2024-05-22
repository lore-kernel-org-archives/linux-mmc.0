Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20879B9D;
	Wed, 22 May 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374813; cv=none; b=GcPHxACm4WxLe02Svuxq47Wq7gKZutsUWh02ICsVCBsd+cllwRgWzJ3WQw4QWb/T3r8GeiyfP2qZnZaC7eppFhuEEvGYlZneNDyI2m7yIvUW7updpTRTNRERUsCJxRSnB7dCxSjRjO+CVqfSbXNasLcox17Kgcahlb9gPvCEBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374813; c=relaxed/simple;
	bh=Y1p8yl29w+zxr7Q556YvLChHdclCscA/h3XgVnPiEYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMQ3rJQqtFLpGC4n/5ScabgQBMnEBzPoDXXirCyivHqEQnunBiSUV46+VGe6m5cQpS0SLlJxSTFqkgeN3uGXjrC7wQaOaCiBMFpPk/DvEklmOXfEm5NgxkUfS1Ffq5PHZOaUYXHnTIh1eiaYeg75zLCN7iNnjOEVYZRfeE7/us4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laokKxTA; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laokKxTA"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f169d3ef53so1512867241.1;
        Wed, 22 May 2024 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716374811; x=1716979611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWhwj205Gpz+dPHvfOUryNPQZpqpGjRKNGPsPHXITkQ=;
        b=laokKxTAUpA5tqQYEtotJyLGJTASB6Op1tD1lA0fwfGPnbeisMVFI42OYavfO4VAJA
         DHAdQ/tZ01HBaOVjlt4ScXWMUcrwFo+4nCdV8JJGv7jWx6RJQwjiVGwemnzlKoQiW9/+
         Nykzqyp3rkmfaoSf0gSpKL7RhFvx+aazG6MP/1T23k5uQ0OaMmwdaSgf357CGJW7doxk
         4qlMJFKuWeFVMCfKm/nNcU9L4xlTMRU/CWzS+r2v8QqQzuMmcGsGfCb/PuO7nwEHHscq
         +A5zDg4jNGenKbpQODizp2JMd4KkVDLKhHWfT9wwlvguL3o85GkulAV5CtlNIVGUaS9Q
         3ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716374811; x=1716979611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWhwj205Gpz+dPHvfOUryNPQZpqpGjRKNGPsPHXITkQ=;
        b=fBH1l0Cxp54vt0h29RnUkCFXxi4zI3cKYo1ShSAC4B9ePsIfPNX49EeNx2H5VpuMbx
         f7/yv+7AKyQwMUG7nKtHVxFCz7q7gUd4ktImn8V8XxntgNuKxWSbDq2UqnzpgqJTbeOl
         yMDKHUzkp8anLX3HmURcSNDtmAE6FZfq9ddRgiFAm0mBbsgRl+MVkZcwtkJNzl0W+gEO
         nqHScN8w4qHZ/v814fwgsqHuKXOi3ytjFrGSFh2bt0BFjd8OzC9vXXTFo+7dKdrnG0Pp
         xuUPlNbBEO+3RIAKuakjKGS8pL6yq+tYn4VVo6c5t5LP2ZbX8tcqrM1VahqyMka2MLPe
         8zBg==
X-Forwarded-Encrypted: i=1; AJvYcCW/nsKHiGw8nVDdS933KH1zVhhYzxrLupoM8tgJguQbd1AwiSKth2/wqLxMGpiLEp9jatTD8bWYfMqyy1FLVNBQ5L9GD7sMQ2J6Iaa/vgPTDBi0cpqPx7CF2S4/sjOdBXXW3qnT/4Bb
X-Gm-Message-State: AOJu0YzZXHUUmS8fEMx7jxZeXfYUVfyykMEL4oKxopO7RxuOKFR1R5/m
	ImhRev+KzsLhK1vq0cTgw1zwWLbpa//LHUOR6D/fMsEh/h5+Hxc0QziQ60oEuYpE8d2ArOvR3n0
	hvmi9PBUOtsecKKRsA4AJ7mmmiZQ=
X-Google-Smtp-Source: AGHT+IHaSEC+fdh2UaA/TGIGFgvFmuVPN1orLp10ojcUUZjUQvIvHY06LlSGowV8e6LpgPajSn5N7PVIHeR3eyQdq1s=
X-Received: by 2002:a05:6102:1623:b0:47c:2b38:4847 with SMTP id
 ada2fe7eead31-4890a14633emr1382193137.26.1716374810840; Wed, 22 May 2024
 03:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123062827.8525-1-victorshihgli@gmail.com>
 <20240123062827.8525-8-victorshihgli@gmail.com> <CAK00qKBf24CMFygfutpfxQwaKEQEo+FKv2XU4X_oxv38un-YEg@mail.gmail.com>
 <a81d0f82-ec9b-4ccf-b31b-9ef9d403ec6b@intel.com> <CAK00qKDzY7gSALrKLqdQg-JdwXDP6NDt17oAX2aoj4P-yfDkPA@mail.gmail.com>
 <822f7274-5f34-4186-b859-938e0401caa8@intel.com>
In-Reply-To: <822f7274-5f34-4186-b859-938e0401caa8@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Wed, 22 May 2024 18:46:38 +0800
Message-ID: <CAK00qKCsFxLs4RApVP9g2TpJjtcR3x1Wm0Pzyi4m0eFU7O+0wQ@mail.gmail.com>
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

On Wed, May 22, 2024 at 5:11=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 22/05/24 12:04, Victor Shih wrote:
> > On Tue, Jan 30, 2024 at 5:36=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 27/01/24 10:28, Victor Shih wrote:
> >>> On Tue, Jan 23, 2024 at 2:28=E2=80=AFPM Victor Shih <victorshihgli@gm=
ail.com> wrote:
> >>>>
> >>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>
> >>>> Embed UHS-II access/control functionality into the MMC request
> >>>> processing flow.
> >>>>
> >>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> >>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>> ---
> >>>>
> >>>> Updates in V13:
> >>>>  - Separate __mmc_go_idle() into one patch for re-factorring the cod=
e.
> >>>>  - Move mmc_decode_scr declaration to sd.h.
> >>>>  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> >>>>  - Drop unnecessary comment.
> >>>>
> >>>> Updates in V12:
> >>>>  - Use mmc_op_multi() to check DCMD which supports multi read/write
> >>>>    in mmc_uhs2_prepare_cmd().
> >>>>
> >>>> Updates in V10:
> >>>>  - Move some definitions of PatchV9[02/23] to PatchV10[06/23].
> >>>>  - Move some definitions of PatchV9[05/23] to PatchV10[06/23].
> >>>>  - Drop do_multi in the mmc_blk_rw_rq_prep().
> >>>>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag.
> >>>>  - Move entire control of the tmode into mmc_uhs2_prepare_cmd().
> >>>>
> >>>> Updates in V8:
> >>>>  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> >>>>  - Modify return value in sd_uhs2_attach().
> >>>>
> >>>> Updates in V7:
> >>>>  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
> >>>>  - Drop uhs2_state in favor of ios->timing.
> >>>>  - Remove unnecessary functions.
> >>>>
> >>>> ---
> >>>>
> >>>>  drivers/mmc/core/core.c    |   10 +-
> >>>>  drivers/mmc/core/sd.c      |   10 +-
> >>>>  drivers/mmc/core/sd.h      |    5 +
> >>>>  drivers/mmc/core/sd_ops.c  |    9 +
> >>>>  drivers/mmc/core/sd_ops.h  |   17 +
> >>>>  drivers/mmc/core/sd_uhs2.c | 1115 +++++++++++++++++++++++++++++++++=
+--
> >>>>  include/linux/mmc/core.h   |   13 +
> >>>>  include/linux/mmc/host.h   |   15 +
> >>>>  8 files changed, 1155 insertions(+), 39 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>>> index 2edf31492a5d..be77cebe1fb8 100644
> >>>> --- a/drivers/mmc/core/core.c
> >>>> +++ b/drivers/mmc/core/core.c
> >>>> @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, s=
truct mmc_request *mrq)
> >>>>
> >>>>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mr=
q)
> >>>>  {
> >>>> +       struct uhs2_command uhs2_cmd;
> >>>> +       __be32 payload[4]; /* for maximum size */
> >>>>         int err;
> >>>>
> >>>>         init_completion(&mrq->cmd_completion);
> >>>> @@ -351,6 +353,8 @@ int mmc_start_request(struct mmc_host *host, str=
uct mmc_request *mrq)
> >>>>         if (err)
> >>>>                 return err;
> >>>>
> >>>> +       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> >>>> +
> >>>>         led_trigger_event(host->led, LED_FULL);
> >>>>         __mmc_start_request(host, mrq);
> >>>>
> >>>
> >>> Hi, Adrian
> >>>
> >>> I referenced your comments of the V9:
> >>>
> >>> Refer:
> >>> https://patchwork.kernel.org/project/linux-mmc/patch/20230721101349.1=
2387-7-victorshihgli@gmail.com/
> >>>
> >>> My understanding is as follows, please correct me if there are any mi=
stakes.
> >>> There is already "struct uhs2_command *uhs2_cmd" in struct mmc_comman=
d.
> >>> If I also put "__be32 payload[4]" in struct mmc_command.
> >>> The code will become:
> >>> mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd, mrq->cmd->p=
ayload);
> >>> But a null pointer problem occurs when sending commands like COM0(mmc=
_go_idle).
> >>> In this case I just can only plan for the time being as follows:
> >>>
> >>> if (mrq->cmd->uhs2_cmd)
> >>>      mmc_uhs2_card_prepare_cmd(host, mrq, *mrq->cmd->uhs2_cmd,
> >>> mrq->cmd->payload);
> >>> else
> >>>      mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> >>>
> >>> Would you give me any other advice?
> >>
> >> struct uhs2_command uhs2_cmd should not be on the stack local to
> >> mmc_start_request().  Probably moving it to struct mmc_request
> >> is as good as any other option.  So starting like below and
> >> then with whatever other changes are needed to make it work.
> >>
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index be77cebe1fb8..68496c51a521 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -334,8 +334,6 @@ static int mmc_mrq_prep(struct mmc_host *host, str=
uct mmc_request *mrq)
> >>
> >>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
> >>  {
> >> -       struct uhs2_command uhs2_cmd;
> >> -       __be32 payload[4]; /* for maximum size */
> >>         int err;
> >>
> >>         init_completion(&mrq->cmd_completion);
> >> @@ -353,7 +351,7 @@ int mmc_start_request(struct mmc_host *host, struc=
t mmc_request *mrq)
> >>         if (err)
> >>                 return err;
> >>
> >> -       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> >> +       mmc_uhs2_card_prepare_cmd(host, mrq);
> >>
> >>         led_trigger_event(host->led, LED_FULL);
> >>         __mmc_start_request(host, mrq);
> >> @@ -434,8 +432,6 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
> >>   */
> >>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> >>  {
> >> -       struct uhs2_command uhs2_cmd;
> >> -       __be32 payload[4]; /* for maximum size */
> >>         int err;
> >>
> >>         /*
> >> @@ -456,7 +452,7 @@ int mmc_cqe_start_req(struct mmc_host *host, struc=
t mmc_request *mrq)
> >>         if (err)
> >>                 goto out_err;
> >>
> >> -       mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
> >> +       mmc_uhs2_card_prepare_cmd(host, mrq);
> >>
> >>         err =3D host->cqe_ops->cqe_request(host, mrq);
> >>         if (err)
> >> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> >> index d3a3465c7669..e3af68a52de8 100644
> >> --- a/drivers/mmc/core/sd_ops.h
> >> +++ b/drivers/mmc/core/sd_ops.h
> >> @@ -24,14 +24,10 @@ int mmc_app_sd_status(struct mmc_card *card, void =
*ssr);
> >>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> >>  void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *=
mrq);
> >>
> >> -static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, s=
truct mmc_request *mrq,
> >> -                                            struct uhs2_command uhs2_=
cmd, __be32 payload[4])
> >> +static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, s=
truct mmc_request *mrq)
> >>  {
> >> -       if (host->uhs2_sd_tran) {
> >> -               uhs2_cmd.payload =3D payload;
> >> -               mrq->cmd->uhs2_cmd =3D &uhs2_cmd;
> >> +       if (host->uhs2_sd_tran)
> >>                 mmc_uhs2_prepare_cmd(host, mrq);
> >> -       }
> >>  }
> >>
> >>  static inline int mmc_sd_can_poweroff_notify(struct mmc_card *card)
> >> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> >> index c46729d85644..9cabb6937dc1 100644
> >> --- a/drivers/mmc/core/sd_uhs2.c
> >> +++ b/drivers/mmc/core/sd_uhs2.c
> >> @@ -1194,6 +1194,7 @@ void mmc_uhs2_prepare_cmd(struct mmc_host *host,=
 struct mmc_request *mrq)
> >>         u8 plen;
> >>
> >>         cmd =3D mrq->cmd;
> >> +       cmd->uhs2_cmd =3D &mrq->uhs2_cmd;
> >>         header =3D host->card->uhs2_config.node_id;
> >>         if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC)
> >>                 header |=3D UHS2_PACKET_TYPE_DCMD;
> >> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> >> index f30f6be86f66..83c901794c17 100644
> >> --- a/include/linux/mmc/core.h
> >> +++ b/include/linux/mmc/core.h
> >> @@ -23,13 +23,18 @@ enum mmc_blk_status {
> >>         MMC_BLK_NEW_REQUEST,
> >>  };
> >>
> >> +#define UHS2_MAX_PAYLOAD_LEN 2
> >> +#define UHS2_MAX_RESP_LEN 20
> >> +
> >>  struct uhs2_command {
> >>         u16     header;
> >>         u16     arg;
> >> -       __be32  *payload;
> >> -       u32     payload_len;
> >> -       u32     packet_len;
> >> +       __be32  payload[UHS2_MAX_PAYLOAD_LEN];
> >> +       u8      payload_len;
> >> +       u8      packet_len;     // TODO: is this really needed?
> >>         u8      tmode_half_duplex;
> >> +       u8      uhs2_resp_len;  /* UHS2 native cmd resp len */
> >> +       u8      uhs2_resp[UHS2_MAX_RESP_LEN];   /* UHS2 native cmd res=
p */
> >>  };
> >>
> >>  struct mmc_command {
> >> @@ -119,8 +124,6 @@ struct mmc_command {
> >>         struct mmc_request      *mrq;           /* associated request =
*/
> >>
> >>         struct uhs2_command     *uhs2_cmd;      /* UHS2 command */
> >> -       u8                      *uhs2_resp;     /* UHS2 native cmd res=
p */
> >> -       u8                      uhs2_resp_len;  /* UHS2 native cmd res=
p len */
> >>  };
> >>
> >>  struct mmc_data {
> >> @@ -179,6 +182,7 @@ struct mmc_request {
> >>         const struct bio_crypt_ctx *crypto_ctx;
> >>         int                     crypto_key_slot;
> >>  #endif
> >> +       struct uhs2_command     uhs2_cmd;
> >>  };
> >>
> >>  struct mmc_card;
> >>
> >>
> >>
> >
> > Hi, Adrian
> >
> > I have modified the above into patch#7 and patch#16 in the patch series=
 v15.
> > But I will submit the patch series v16 later.
> > Please help review the changes in patch series v16.
> >
> > Thanks, Victor Shih
>
> If you make a V16, please separate the Error Recovery mechanism added in =
V15
> into a separate patch.
>

Hi, Adrian

I will separate this part to patch#8 in v16.

Thanks, Victor Shih
