Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0182AF05
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkMcQ+06"
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D4118
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 08:28:29 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5be6d6c04bfso60260777b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699979309; x=1700584109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2TA/53JughUb8jvSai4zSTNUnLhfnSUUE3vK7pOMXhc=;
        b=UkMcQ+06pcDYAyUc65WtadOxtYgKMrTwPGTi/L4Sq9PqyI1Lt0n2OfC162uIzXQuCd
         Ov7g4scEnVDYFLmO+wfCCh+/LZhMFN7iWwQgZfvyes56Cm+g0/PuanoszGZY/bRmchU3
         uAK2z2Wvg4LWtDdkRzrI8PTaMLHjweaqz0nGS8OvjFxioA457M8jcSF7BTcqQRwi6/vv
         gzcVN0FfGD/zGWRHGGaC6HtUpaEb2CVssVdY7L6Xr8QxuIRo1yPqcg7CPy8BlargOCi3
         3EuJy0BeDceGDxLCQZfJ4TnCv5OZVzBmf6Cot9F+eAANojI6Rn5Zlphx+EGSII+7kpj1
         +Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979309; x=1700584109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TA/53JughUb8jvSai4zSTNUnLhfnSUUE3vK7pOMXhc=;
        b=tZ2xsutZg28ZNO0we+d13yYP/1vePsA/UQg0dyYvXb0wYXBevRQC7GR94Uld+umqVo
         X1CD6fwuQyXJ15++3Q99abeTzQl3eQk7NNe1Ewif9eS4u71W8MqOq5d3Iu8kkKjBJ3iN
         1ch7OYpWRlscdXHoSl9aaV6mTiFhWDyEot758V+THxhVnvHaKDL/o1i1zRsWCLsSUp1Y
         6jB3GhLW4aJ9/M7J7VBQRLzMlAh9+2ZAQUIVAVg7s9vUO1FwMrpHZiSpsnLIfmVdVOXd
         2es+235oPAHt8shB2Sp9Ii3c+yy1aiQjf3AOkHsspapxmqZEY4UnmwIzIPXeB49c0EQ2
         1mLA==
X-Gm-Message-State: AOJu0YyfBEofqthuNK1tg60zTSlRE41PEpKnU8KbEHWcItvF9jRayV7W
	OpbYD3Q0MD92pPDZGRyS7B9blX7ewKujaWZU0wKZ1Q==
X-Google-Smtp-Source: AGHT+IECxw6pnl572hzcuJafZUZ5Z4SabETMDEq+PFNgKgLDJ7CsI1TPm6pMEfA9dXA9IQedpQLaOP39nGh8gxo1c2E=
X-Received: by 2002:a0d:d80d:0:b0:5a8:2d2b:ca9c with SMTP id
 a13-20020a0dd80d000000b005a82d2bca9cmr8049057ywe.32.1699979308940; Tue, 14
 Nov 2023 08:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030090906.1897035-1-avri.altman@wdc.com> <557eb489-3e1d-4cbd-b62d-d3046870a4cc@intel.com>
 <BL0PR04MB6564E2DDCA36806907F600BAFCAAA@BL0PR04MB6564.namprd04.prod.outlook.com>
 <DM6PR04MB657536595A7EF523A14A7D6BFCB2A@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657536595A7EF523A14A7D6BFCB2A@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 14 Nov 2023 17:27:52 +0100
Message-ID: <CAPDyKFqHt21E-TkrcJpm01Wg+7-f5oC1TzGDYEmrMN+YoExWyQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Use mrq.sbc in close-ended ffu
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Daniil Lunev <dlunev@google.com>, 
	Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Nov 2023 at 12:21, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > > >       }
> > > > @@ -1032,6 +1044,28 @@ static inline void
> > > > mmc_blk_reset_success(struct
> > > mmc_blk_data *md, int type)
> > > >       md->reset_done &= ~type;
> > > >  }
> > > >
> > > > +/* close-ended ffu */
> > > > +static void mmc_blk_check_ce_ffu(struct mmc_queue_req *mq_rq) {
> > > > +     struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
> > > > +
> > > > +     if (mq_rq->ioc_count != 4)
> > > > +             return;
> > > > +
> > > > +     if (idata[0]->ic.opcode != MMC_SWITCH)
> > > > +             return;
> > > > +
> > > > +     if (MMC_EXTRACT_INDEX_FROM_ARG(idata[0]->ic.arg) !=
> > > > +                     EXT_CSD_MODE_CONFIG)
> > > > +             return;
> > > > +
> > > > +     if (idata[1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> > > > +         idata[2]->ic.opcode == MMC_WRITE_MULTIPLE_BLOCK) {
> > > > +             idata[1]->flags |= MMC_BLK_IOC_DROP;
> > > > +             idata[2]->flags |= MMC_BLK_IOC_SBC;
> > > > +     }
> > >
> > > Could this be more generic e.g. simply
> > >
> > >         for (i = 1; i < mq_rq->ioc_count; i++)
> > >                 if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> > >                     mmc_op_multi(idata[i + 1]->ic.opcode)) {
> > I guess you meant (idata[i]
> >
> > >                         idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
> > >                         idata[i]->flags |= MMC_BLK_IOC_SBC;
> > >                 }
> > >
> > > with no need to check for 4 cmds, MMC_SWITCH or
> > EXT_CSD_MODE_CONFIG
> > Ditto
> Or, I can follow your proposal.
> Will send a v3.

Please do! I think it's better to solve this in a generic way, rather
than making it specific for FFU.

Kind regards
Uffe
