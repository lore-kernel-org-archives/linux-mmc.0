Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC426AF6
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329492; cv=none; b=pksomK5ILXpNkIz4rY+wsedShRj6EELUewuku96HbXXrBpsDWFcyvoNV6yKpHYT4SQIAdNuGVxjFII1oR7ehiLEcBtI+zJnF/bn0aSCv2F0qkQeFCA9UlEMGxyYO114wTpzHur4GCflsZjwJ7vkxUqlJiEk3jJtw89Eb6MKAeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329492; c=relaxed/simple;
	bh=/NG8EHxGchqQ6K00q6eOqBJqLodpn81fZfi0nHttRwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji7dFsvdQT0U2juYJaLrBUymR3XGYLgnBCSDOChwTeUY3ityinsln4bXf08nuulv5DqOeonzbB1Go+7NRIfAaAHR/f3JkNm3mZVw6pCoM+rWb7M7X49paSU+fc78QgxkKGrFwfrMLdEgR8YPwG3CpXjqxB/wj+W4akNfLRMQTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eh5UASzy; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eh5UASzy"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso758815276.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724329489; x=1724934289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DTslBlFM6B2/2pt0qtc+AuM69EVs/+D55dSvLPo1Y1A=;
        b=Eh5UASzyPDw/t+xkPpWB6Mk15UVcpVxWb7hnpdb8es6N1n7n0SpuKTGQlPULSb+fZC
         KciGGf563iUa37IA7R6+/VndFhYhbMNlaS7VG6uMT4Vg0wV6ZUTvysf+ul5pAXWwhh9X
         8jlfLkW810sGRtIuLiEB1AJVQSfQdNMJiXNw2weZBMQluYNaSux0QqHsyGwIg8anz1rx
         SoaaK7+WgFAdboJLRMzfIaLlOJcdIILzjWU5hFj/4huCZxlblKT4WKD0gJgPfM9VMlUZ
         dRZfUJflb7MgVf1+EDXZSUbo/qLvTaTGvuEfKYrCsgbtjob5q6GxYE/De3f7ABsZB8Tb
         So+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724329489; x=1724934289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTslBlFM6B2/2pt0qtc+AuM69EVs/+D55dSvLPo1Y1A=;
        b=P+qDbaWuN4acQMVCT38ArVX9hwc+8tn7945CRpE2RICjFyzhZcACfHelT8z/5lXz7B
         bX2ll8AIh83pcQus4v/80THRoRei0w0pMlMpJvvYYTeRCO8mzrSjmrox5lrGP2FC6qBx
         fxwSiBjXWPq7JQE8fHp6IbjniR5kNsMhY3B/3+XDdqSNes0qp9tOTg7mKzD5ZZT0xjxB
         wKSvj6/MS2i5oDz3lqpXkksOg9H1ufic1amzPDUCO8DStV+L8uo1C6ozwqB0W/qQYKwS
         xPx3/Gm8p0ea/UCbBZS+LPEKM7/KaRS7y4BJzMjDgmI/D/S16rOPKAh1317bxuNGCNoo
         5nww==
X-Gm-Message-State: AOJu0YyXVOBlbwnYZvNYEkEKgPK29nS/l3AcLNfBp7qMMDPvPVAy7fgs
	usuMKVLy2oBkUmteJVpPZ+yHC/J+uB9OBiKOLkHK76z7Eqz7XX9gcv69lfAGb2c7TqTSTQiM3qG
	Nfy8qUU13tuktIEJw/WzLRxIL0f3iFHipF/ZS6w==
X-Google-Smtp-Source: AGHT+IGg0juxLalfAkcwfpKnE+FMbRkEIJie+nvwae8Vpt9xE0bExC79osbBYzgEKlbf+ry2MDPISDKx3AJOrL8uKt8=
X-Received: by 2002:a05:6902:138d:b0:e11:7096:5478 with SMTP id
 3f1490d57ef6-e1666400f28mr6080725276.20.1724329489510; Thu, 22 Aug 2024
 05:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <20240814072934.2559911-5-avri.altman@wdc.com>
 <CAPDyKFpNCZi6biSaCLUFKaB-Xc4Kg4Z1NjzjW5vcY4TeLKDD4g@mail.gmail.com>
In-Reply-To: <CAPDyKFpNCZi6biSaCLUFKaB-Xc4Kg4Z1NjzjW5vcY4TeLKDD4g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 14:24:13 +0200
Message-ID: <CAPDyKFqQ-zS9vQP63+DxL1J4UA31FAW1dA7HfHv+BKS5SZjXyQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
> >
> > For open-ended read/write - just send CMD22 before issuing the command.
> > While at it, make sure that the rw command arg is properly casting the
> > lower 32 bits, as it can be larger now.
> >
> > Tested-by: Ricky WU <ricky_wu@realtek.com>
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > ---
> >  drivers/mmc/core/block.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 2c9963248fcb..1129f4e1a268 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -180,6 +180,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
> >  static int mmc_spi_err_check(struct mmc_card *card);
> >  static int mmc_blk_busy_cb(void *cb_data, bool *busy);
> > +static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host);
> >
> >  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
> >  {
> > @@ -1664,7 +1665,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >
> >         brq->mrq.cmd = &brq->cmd;
> >
> > -       brq->cmd.arg = blk_rq_pos(req);
> > +       brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
> >         if (!mmc_card_blockaddr(card))
> >                 brq->cmd.arg <<= 9;
> >         brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > @@ -1712,6 +1713,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >                         (do_data_tag ? (1 << 29) : 0);
> >                 brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> >                 brq->mrq.sbc = &brq->sbc;
> > +       } else if (mmc_card_is_sduc(card->host)) {
> > +               mmc_blk_wait_for_idle(mq, card->host);
>
> If I understand correctly, this means the async request mechanism will
> not be disabled for SDUC cards.

/s/will not/will

>
> Maybe this is the easiest way to move this forward for now, but it's
> still a bit sad if we can't keep using it for SDUC cards too.
>
> No matter what, can you please elaborate why you have chosen this approach?
>
> > +               mmc_send_ext_addr(card->host, blk_rq_pos(req));
> >         }
> >  }
> >
> > --
> > 2.25.1
> >
>
> Kind regards
> Uffe
