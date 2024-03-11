Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93A4174A
	for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169703; cv=none; b=s18NeNvgXFSCD/Sa5IJwuDDsgDC7jl2GjrFJ/8YeXyvM3XZK4XLxKd/tUIVOJnztOiPlCRZvi8wqq8n0PkB0rLsr4in7bFVCrVA2petVof4d66GOFKtqRYVhQfV62mKg3WDJfkntMJ87fWkuShEb+SuDeWBScvOmPCyO1snV9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169703; c=relaxed/simple;
	bh=ixbrY3GwYjixIF57s2PuegGj6UxFXQXGNTrUhEW/ydY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbwaqWPWD8TSHNDQc3XfgYayhctWBrXXWg9Z7c6me3O0plgC2cdfX/jKwgB4dcmHmm1XGl8Y0OE1H3BKiNMNKJOnhZ3IaoMNl8AlXA2P2vOFCOuytIysz2kdq8l4hm9PgriUE0Rr+LGUh/+QiBd+3VN8Xvgnr3uxu5lGkV+HE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=njFo9NtA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njFo9NtA"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513b39eea3dso242661e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710169699; x=1710774499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdSQvUzZuDjoCEuL6LEczdbqaW2+brjIv+6/ivU6YfA=;
        b=njFo9NtAXVPCbob6RlovfA4UlFjGSgbYKNItFJV+pl6GyvYoBEg+eJ8Onkj5c/JVE0
         dryeptPoVa3R3uAG4wmSSeIHAzrqJsnlfmtbd8nYRCyRGpQ7sEJR2Vv7qiki96PtyFl0
         V4uoOg5dBRLIaOBgZLushOFxJR73MHIdMMhlHHIL7xWUnPi5/x6KtZE16XK/hEWzZ/Ao
         1ZaFPl7ZXeahuuxsW0w7T+rSsORfchJmpEwje3U26k76Chr8VvhPWwrW9gB7rGiQBgeF
         WEJLbIY3lCHn2CTbo5UayhiljyN/kSKHXt48zIgetCCQJ6Pia58M9hHUU1l/JI1cyFfo
         d8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169699; x=1710774499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdSQvUzZuDjoCEuL6LEczdbqaW2+brjIv+6/ivU6YfA=;
        b=eIA/Z9j0tnACATQestWsbKgItbt5yrhVC1gSVZEbUGfJ8piSXagyae2SZvEUDjXlym
         qJYQNd4VYGKlrnPN8+evM5kr6JARMrGoyzfNdyQlA6y3v2N5Fsxq9S9Yt5IA4BtXp4i/
         1oXQSOIyO/ML575VCEDmUmuM0dlpUFOf+kSyMAhvHTFftIy4f+0gSh64vn4CKoeMDuCc
         /vGveQgJ9RqCAGMWpiNnuM2uk1gb4W+ZXOs8RqF2CR4xzpNOho+/AYRq1kGjcpTsJ41k
         0fCLE3MiO+QgSl+0AqGxz5fRFnSHwnHVI/rdEgHh4Rqy3m7GuuKt5nOzu4PqqyXJPEba
         2eqA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ev98qv6DfEqh587AfP3y9Hvq4AziTlDecfs/x8vdP07C5JZZrY/47rMnoKmdQyySrbCTGTFHBdDAT3PUJpL+izGir2JUR1tU
X-Gm-Message-State: AOJu0Yzp/ZpCUBt8usx2VekrKTQZlKIMDRmYUcdYBh8yT54s79cnQOHY
	0rpRaub1YisR8z7HePC8ROzjfR5jzg5aRg5IliPzdn6rMgkXgLfBEQMBDxQxn9Q=
X-Google-Smtp-Source: AGHT+IHkNMLvhn2bdwuDw2V8QGBKO7wn8ZRNcCSGV7t9sCQ/ki+bMiiDUYRamX9u8XSt0rjs9gb0Eg==
X-Received: by 2002:a05:6512:28b:b0:513:9d46:5fe8 with SMTP id j11-20020a056512028b00b005139d465fe8mr631874lfp.30.1710169698893;
        Mon, 11 Mar 2024 08:08:18 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id u17-20020ac258d1000000b005135a4935aasm1114574lfo.223.2024.03.11.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:08:18 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:08:16 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Avri Altman <Avri.Altman@wdc.com>, jens.wiklander@linaro.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Daniil Lunev <dlunev@google.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Message-ID: <Ze8eYFW4yZKcWxdo@nuoska>
References: <20231129092535.3278-1-avri.altman@wdc.com>
 <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska>
 <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>

Hi,

Adding Jens from OP-TEE.

On Mon, Mar 11, 2024 at 02:55:01PM +0000, Avri Altman wrote:
> > On Thu, Nov 30, 2023 at 11:36:10AM +0100, Ulf Hansson wrote:
> > > On Wed, 29 Nov 2023 at 10:25, Avri Altman <avri.altman@wdc.com> wrote:
> > > >
> > > > Field Firmware Update (ffu) may use close-ended or open ended sequence.
> > > > Each such sequence is comprised of a write commands enclosed between
> > > > 2 switch commands - to and from ffu mode. So for the close-ended
> > > > case, it will be: cmd6->cmd23-cmd25-cmd6.
> > > >
> > > > Some host controllers however, get confused when multi-block rw is
> > > > sent without sbc, and may generate auto-cmd12 which breaks the ffu
> > sequence.
> > > > I encountered  this issue while testing fwupd
> > > > (github.com/fwupd/fwupd) on HP Chromebook x2, a qualcomm based QC-
> > 7c, code name - strongbad.
> > > >
> > > > Instead of a quirk, or hooking the request function of the msm ops,
> > > > it would be better to fix the ioctl handling and make it use mrq.sbc
> > > > instead of issuing SET_BLOCK_COUNT separately.
> > > >
> > > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > >
> > > Applied for next (to get it tested a bit more) and by adding a stable
> > > tag, thanks!
> > 
> > This change is causing RPMB breakage in 6.6.13 and also 6.6.20. rockpi4b and
> > synquacer arm64 boards with u-boot, optee 4.1.0 and firmware TPM (fTPM) fail
> > to access RPMB via kernel and tee-supplicant 4.1.0.
> > 
> > More details in https://bugzilla.kernel.org/show_bug.cgi?id=218587
> > 
> > I've tried to identify what exactly is going wrong but failed so far. Reverting this
> > changes is the only working solution so far. This also triggered a kernel crash on
> > error path https://bugzilla.kernel.org/show_bug.cgi?id=218542 which is now
> > fixed/queued.
> > 
> > If you have any hints how to debug this further or patches to try, I'd be happy to
> > try those out.
> I don't know nothing about tpm nor the ftpm.
> The above patch is scanning command sequences sent via MMC_IOC_MULTI_CMD,
> looking for pairs of CMD23->CMD25 or CMD23->CMD18,
> drops the CMD23 and build one instead in __mmc_blk_ioctl_cmd as the mrq.sbc.
> AFAIK user-space utils, e.g. mmc-utils count on the mmc driver to provide SBC when accessing rpmb,
> so their multi-ioctl sequences does not include CMD23, hence does not affected by this code.
>
> Looking in the strace included, I tried to find where MMC_IOC_MULTI_CMD is sent.
> There are 8 such ioctl calls.
> I guess the tee supplicant sources are unavailable,
> But it looks like 2 simultaneous threads are trying to access the rpmb partition - which is forbidden.
> Opening /dev/mmcblk0rpmb from user space is exclusive, so I am not sure how even this is possible.

tee-supplicant sources are available from https://github.com/OP-TEE/optee_client
and specifically https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/rpmb.c#L893
for MMC_IOC_MULTI_CMD.

Interesting if there are two threads trying to access RPMB at the same time. Any
comments here from Jens? I would have expected kernel to keep RPMB access
exclusive for a single user.

Cheers,

-Mikko

> I can try and help you debug this - you can contact me offline.
> 
> Thanks,
> Avri
> 
> > 
> > Cheers,
> > 
> > -Mikko
> > 
> > > Kind regards
> > > Uffe
> > >
> > >
> > > > ---
> > > >
> > > > Changelog:
> > > > v3--v4:
> > > >         check sbc.error as well
> > > > v2--v3:
> > > >         Adopt Adrian's proposal
> > > > v1--v2:
> > > >         remove redundant reference of reliable write
> > > > ---
> > > >  drivers/mmc/core/block.c | 46
> > > > +++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 43 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > > index f9a5cffa64b1..892e74e611a0 100644
> > > > --- a/drivers/mmc/core/block.c
> > > > +++ b/drivers/mmc/core/block.c
> > > > @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
> > > >         struct mmc_ioc_cmd ic;
> > > >         unsigned char *buf;
> > > >         u64 buf_bytes;
> > > > +       unsigned int flags;
> > > > +#define MMC_BLK_IOC_DROP       BIT(0)  /* drop this mrq */
> > > > +#define MMC_BLK_IOC_SBC        BIT(1)  /* use mrq.sbc */
> > > > +
> > > >         struct mmc_rpmb_data *rpmb;
> > > >  };
> > > >
> > > > @@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct
> > > > mmc_ioc_cmd __user *ic_ptr,  }
> > > >
> > > >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> > mmc_blk_data *md,
> > > > -                              struct mmc_blk_ioc_data *idata)
> > > > +                              struct mmc_blk_ioc_data **idatas, int
> > > > + i)
> > > >  {
> > > >         struct mmc_command cmd = {}, sbc = {};
> > > >         struct mmc_data data = {};
> > > > @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct
> > mmc_card *card, struct mmc_blk_data *md,
> > > >         unsigned int busy_timeout_ms;
> > > >         int err;
> > > >         unsigned int target_part;
> > > > +       struct mmc_blk_ioc_data *idata = idatas[i];
> > > > +       struct mmc_blk_ioc_data *prev_idata = NULL;
> > > >
> > > >         if (!card || !md || !idata)
> > > >                 return -EINVAL;
> > > >
> > > > +       if (idata->flags & MMC_BLK_IOC_DROP)
> > > > +               return 0;
> > > > +
> > > > +       if (idata->flags & MMC_BLK_IOC_SBC)
> > > > +               prev_idata = idatas[i - 1];
> > > > +
> > > >         /*
> > > >          * The RPMB accesses comes in from the character device, so we
> > > >          * need to target these explicitly. Else we just target the
> > > > @@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> > > >                         return err;
> > > >         }
> > > >
> > > > -       if (idata->rpmb) {
> > > > +       if (idata->rpmb || prev_idata) {
> > > >                 sbc.opcode = MMC_SET_BLOCK_COUNT;
> > > >                 /*
> > > >                  * We don't do any blockcount validation because the
> > > > max size @@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct
> > mmc_card *card, struct mmc_blk_data *md,
> > > >                  * 'Reliable Write' bit here.
> > > >                  */
> > > >                 sbc.arg = data.blocks | (idata->ic.write_flag &
> > > > BIT(31));
> > > > +               if (prev_idata)
> > > > +                       sbc.arg = prev_idata->ic.arg;
> > > >                 sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > > >                 mrq.sbc = &sbc;
> > > >         }
> > > > @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
> > > >         mmc_wait_for_req(card->host, &mrq);
> > > >         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> > > >
> > > > +       if (prev_idata) {
> > > > +               memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
> > > > +               if (sbc.error) {
> > > > +                       dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
> > > > +                                                       __func__, sbc.error);
> > > > +                       return sbc.error;
> > > > +               }
> > > > +       }
> > > > +
> > > >         if (cmd.error) {
> > > >                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
> > > >                                                 __func__,
> > > > cmd.error); @@ -1032,6 +1055,20 @@ static inline void
> > mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> > > >         md->reset_done &= ~type;
> > > >  }
> > > >
> > > > +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq) {
> > > > +       struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
> > > > +       int i;
> > > > +
> > > > +       for (i = 1; i < mq_rq->ioc_count; i++) {
> > > > +               if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> > > > +                   mmc_op_multi(idata[i]->ic.opcode)) {
> > > > +                       idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
> > > > +                       idata[i]->flags |= MMC_BLK_IOC_SBC;
> > > > +               }
> > > > +       }
> > > > +}
> > > > +
> > > >  /*
> > > >   * The non-block commands come back from the block layer after it queued
> > it and
> > > >   * processed it with all other requests and then they get issued in
> > > > this @@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(struct
> > mmc_queue *mq, struct request *req)
> > > >                         if (ret)
> > > >                                 break;
> > > >                 }
> > > > +
> > > > +               mmc_blk_check_sbc(mq_rq);
> > > > +
> > > >                 fallthrough;
> > > >         case MMC_DRV_OP_IOCTL_RPMB:
> > > >                 idata = mq_rq->drv_op_data;
> > > >                 for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> > > > -                       ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> > > > +                       ret = __mmc_blk_ioctl_cmd(card, md, idata,
> > > > + i);
> > > >                         if (ret)
> > > >                                 break;
> > > >                 }
> > > > --
> > > > 2.42.0
> > > >
