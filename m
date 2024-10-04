Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE819146A93
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034760; cv=none; b=hASqpNbpfZL3Tseqe1QwxwCJVSYwJOYxUhg9CxnFX79NB6LK5RpHB/KcTTpSYQ3Yph/l+S0SJ00TC2yWEaNCVv2ewp9eHxetB6WIeTlU2ly3/G+OwQ5LpszPWPfAMHndDEZl34UOKZcxJHBVRr1Njh1fMmMEZN6y8Q/UoIiwrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034760; c=relaxed/simple;
	bh=G1qo1+oONkvUIVvfIQxLu/6X9vshyO0305XZ45wMG+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS9hRH5/86BQyge1yAEmgM2XQpFMclYuN2Kc8Jhh519kujhSeeypWylVnqGCllMGHuWlWadkqUulN3bi7FAh3kGjIJRQu636PIjbHkwVxCQVFuX72oBQj/wCrYZLyxTRdxOsmvAwcCX5LqsXFENmAUL56S09xwYEV7LaajMW0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fv2duE4V; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fv2duE4V"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e25ccd64be9so1647089276.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2024 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728034756; x=1728639556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWTEumFcArtdGDI/m8zBF58Qc99ecb+Ln2NpkjB57m8=;
        b=fv2duE4V9kzwTl0WSIGzj8NTkQdsqHJ8EWfWFQ0zI2DcQxS1+p7kQq/L4lzpd+xLUk
         fmN7mGLmP9xRiYXqBGHMFUs1xjEp71qWphaY5/rIn2PlO93ZLGQzcKEMbqJ5xoz+3pSU
         regLe+vQ5WcYyhDjfY6IebUwYqYaBwMeHiO8+Bijm2b5th0qlqonwzGxUn73onKmRWlV
         zbaSCEFDtTkz3KCQWTbJ3XwtzoFOAjXv0So57jQcL+q/s1H+yx593IyTSI35Bcooz1vd
         L4og4ksChyqH7RD2oauRQQABUzbPyltktAcX8P83v5Bcs4neAUDdJ8ZzOhVad/WRF6+c
         gttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728034756; x=1728639556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWTEumFcArtdGDI/m8zBF58Qc99ecb+Ln2NpkjB57m8=;
        b=BdO5+DwlgzZQ7nmaPlgRK2aYquhmPemEGD/A5u8TZkMmyH8g70lWnRzWW21QKHQ786
         JIc8CQcGoXyxB2CsDrKzJNsRrwwRnHM1GS5PPjt+RdjPcbGmb2sgGkZrPTBn9OB5UcNK
         i8blI/ARlGF1zu7ej5OtuSNxrfW5jnS1OYVJRLl7CJdmeK6wqzZLXiU1F2i4zV4S0gKJ
         R9fXQ5LZ+Tv2A1eeeCK47cCixUOErYYZ47xUrf4LYWE2zP+G+f87RXgKjgS+U2vHX80t
         n+hKCwJ5rTgQXofwZVzpBz9O/91vQFaq3LjkpDEJAN1HnyDwT2qc/PzhIG6LCiuJyjQp
         /Nzw==
X-Gm-Message-State: AOJu0YyU4EBYXEljwaLVrEntyZH+HTwyfvt03wx1AUdwmoGxB8cbxASX
	NbENEZnmS+cE6BD45VeS3F2TiD0Tbw4uo119oIEOSuuM8cc93rwdR+yoIgdiTB1dyuZ2+HevkFb
	fd9iaO5dHTyNDqhcYDwUqj7hW5jX84ipWz1wt3g==
X-Google-Smtp-Source: AGHT+IESmTmwe2gYIkZccs8P8nLzYcW9xq2k8QSzUdfhAYZ+T888cmWiMUG9ynwQpJ3fyyZNfKpa02Kkup4XrPa+JL4=
X-Received: by 2002:a05:6902:c0f:b0:e26:1422:400b with SMTP id
 3f1490d57ef6-e2893956363mr1550592276.53.1728034755789; Fri, 04 Oct 2024
 02:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <20240908102018.3711527-5-avri.altman@wdc.com>
 <CAPDyKFqE2SZ1NcsYGpuL4wYW1r6s5Di_4Vrjbkk8uPP82xpoCw@mail.gmail.com> <DM6PR04MB6575049927531335ACA5D611FC712@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575049927531335ACA5D611FC712@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Oct 2024 11:38:39 +0200
Message-ID: <CAPDyKFo64szpExHeK8Aa=1=XZF2RR90ovVEa-U3SUMJf929v7w@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 18:44, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On Sun, 8 Sept 2024 at 12:22, Avri Altman <avri.altman@wdc.com> wrote:
> > >
> > > For open-ended read/write - just send CMD22 before issuing the
> > command.
> > >
> > > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > > ---
> > >  drivers/mmc/core/block.c | 5 +++++
> > >  drivers/mmc/core/core.c  | 3 +++
> > >  include/linux/mmc/core.h | 5 +++++
> > >  3 files changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > > 05a7745c2a68..ba2ed413be5c 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -1759,6 +1759,11 @@ static void mmc_blk_rw_rq_prep(struct
> > mmc_queue_req *mqrq,
> > >                 brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > >                 brq->mrq.sbc = &brq->sbc;
> > >         }
> > > +
> > > +       if (mmc_card_ult_capacity(card)) {
> > > +               brq->cmd.ext_addr = blk_rq_pos(req) >> 32;
> > > +               brq->cmd.has_ext_addr = true;
> > > +       }
> > >  }
> > >
> > >  #define MMC_MAX_RETRIES                5
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > > d6c819dd68ed..a0b2999684b3 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -336,6 +336,9 @@ int mmc_start_request(struct mmc_host *host,
> > > struct mmc_request *mrq)  {
> > >         int err;
> > >
> > > +       if (mrq->cmd && mrq->cmd->has_ext_addr)
> > > +               mmc_send_ext_addr(host, mrq->cmd->ext_addr);
> > > +
> > >         init_completion(&mrq->cmd_completion);
> > >
> > >         mmc_retune_hold(host);
> > > diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
> > > f0ac2e469b32..c86df8443a88 100644
> > > --- a/include/linux/mmc/core.h
> > > +++ b/include/linux/mmc/core.h
> > > @@ -96,6 +96,11 @@ struct mmc_command {
> > >         unsigned int            busy_timeout;   /* busy detect timeout in ms */
> > >         struct mmc_data         *data;          /* data segment associated with
> > cmd */
> > >         struct mmc_request      *mrq;           /* associated request */
> > > +
> > > +       /* for SDUC */
> > > +       bool has_ext_addr;
> > > +       u8 ext_addr;
> > > +       u16 reserved;
> >
> > I don't see this being used, at least in this patch. Perhaps move it to the patch
> > that starts using it?
> In mmc_blk_rw_rq_prep().

I was only pointing at the "u16 reserved", the other new variables are fine.

Looking at the complete series, it seems like the "u16 reserved" is
unused and can be removed.

[...]

Kind regards
Uffe
