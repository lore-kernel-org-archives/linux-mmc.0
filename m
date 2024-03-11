Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126213FE23
	for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165604; cv=none; b=rLBF47v2QypjaWhr1NWzWPvRpZ8OS6oHzxoi2UYzNeGwhMvDO94mP2fE5aQcnk7Gw8FGtOv0V+bb367gYjRT8dUQpgHRhQbgESh/38vp3yVHyHdf1+81iptTS8k36FRd9qdNLl0GoTEeJVUMq/HoFmpd5DPInZJNNmVM+7X0PYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165604; c=relaxed/simple;
	bh=DTrDqxNbMAu/D/nMTy8YgQo/jk+CtmqofIeEFgRafRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLXMsLHC7iNSQ7d7ixNmoh5aZH5RD/K1vOXdJjegUgoHACEEVXIyi1bKPtI4lw+sjnBqgUlIFQkH77406A5pD0Dedl1eGZGApIRfX6CcaYKHpcEOgjnbqeU6LU/stp9J/5Qv4uk9kn/UYBEGyM8cQGlF1wcvI9h6LisnYnFPMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rXlKGA6B; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXlKGA6B"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513b022a238so679700e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710165600; x=1710770400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs+OJ5JvGn0slYZQ04UyEkvHdxXEWetAxpEwAq3DCdQ=;
        b=rXlKGA6Bu6drPfp7M2MI4xTfe8jjx0FuZADUfwpla5wOEIWbhSA42whCY0dzFQi2Ga
         y/UWUem5TDGYkXHGjkzXOD7WZeQVfoXJYGYmW0ATGlyaaLJ1i4hcUYpgPNOFZWT/ngsV
         lXrTn5F91Jh1dbT4Z2Y+7x0pfTe39iFqCotsfLatasPOx+snR56hCQ+mtfbAPp2nVRUo
         KiDSzJjq5zCfeFcCF04We0l1glTwxa7HIDZZTfx8+gcCcbnR84s8cqlVC4b2CgBb9D/b
         eUXkhfY8V2HNAXCR2E2tfAGJ2rQeB9CgphrC4XRngmuvhnVWI5oscf0wknhWAOeCgrQ6
         VVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710165600; x=1710770400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs+OJ5JvGn0slYZQ04UyEkvHdxXEWetAxpEwAq3DCdQ=;
        b=GcwMlhqkRg0UmfYe7l0Qc/zM1LvBFG7LpW8JQNk5sbdUhu6gptq8YGOg0AZF2P3blh
         BtII/MTEZBTyRNokTfWHAJ+dS4IdCi6Z3qKNFy5bf7M0/XQPhSRxNbwxDFuTqMl7Zn/l
         hc8gQpjRKNbPd9RKK4Q2/CoMiXPDcBDDIuory2RY1fxOmnQodjxKK9A8+7/mWcTu6EH1
         U0/mEEs64gp3WAw0O8ykV7Sp1qejvBT6jTXSGJbteqnlFdpOEebfE8KZjx/ba9KSO1hY
         CO+o9IraIS6Pd9ZpWIRlV1O45F+61ev8gTp1B23bBJCMXBzzqOIEvY8H2cEQPBANiik2
         OaOA==
X-Forwarded-Encrypted: i=1; AJvYcCWCcEGYB2zcaj6M7Qd5OS6N4z7pjwgMTfzTxxLDSnpGfnZmZY+gO3BbO7pCsZxLidr4MyO1SyDGiTF6F5Vy6N11E2XdoAxclSOf
X-Gm-Message-State: AOJu0YyDnej/UHt5XrbbhuxKdVHi6H/FiKPohJ4he4i45KpNoQNMBAcP
	KhvX3qwvDYqE36g7k9uPJkZGsoozZgsrGGyW9RkbzEgFeKWWVtUxO1SpG+K+lTliPTxOpR7bkjv
	HMgA=
X-Google-Smtp-Source: AGHT+IEOF9mQ2gCts1aticz9p5w/fwMWiXs+d4TgEjXmMh5yioUa+y6qyI97N0RVbGVlGlENpgrKWA==
X-Received: by 2002:ac2:5145:0:b0:513:a05d:7e9a with SMTP id q5-20020ac25145000000b00513a05d7e9amr3380998lfd.45.1710165600078;
        Mon, 11 Mar 2024 07:00:00 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id cf34-20020a056512282200b005132fc23e92sm1087099lfb.147.2024.03.11.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:59:59 -0700 (PDT)
Date: Mon, 11 Mar 2024 15:59:57 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Daniil Lunev <dlunev@google.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Message-ID: <Ze8OXcCA_BCN2MVE@nuoska>
References: <20231129092535.3278-1-avri.altman@wdc.com>
 <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>

Hi,

On Thu, Nov 30, 2023 at 11:36:10AM +0100, Ulf Hansson wrote:
> On Wed, 29 Nov 2023 at 10:25, Avri Altman <avri.altman@wdc.com> wrote:
> >
> > Field Firmware Update (ffu) may use close-ended or open ended sequence.
> > Each such sequence is comprised of a write commands enclosed between 2
> > switch commands - to and from ffu mode. So for the close-ended case, it
> > will be: cmd6->cmd23-cmd25-cmd6.
> >
> > Some host controllers however, get confused when multi-block rw is sent
> > without sbc, and may generate auto-cmd12 which breaks the ffu sequence.
> > I encountered  this issue while testing fwupd (github.com/fwupd/fwupd)
> > on HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.
> >
> > Instead of a quirk, or hooking the request function of the msm ops,
> > it would be better to fix the ioctl handling and make it use mrq.sbc
> > instead of issuing SET_BLOCK_COUNT separately.
> >
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> 
> Applied for next (to get it tested a bit more) and by adding a stable
> tag, thanks!

This change is causing RPMB breakage in 6.6.13 and also 6.6.20. rockpi4b and
synquacer arm64 boards with u-boot, optee 4.1.0 and firmware TPM (fTPM) fail to
access RPMB via kernel and tee-supplicant 4.1.0.

More details in https://bugzilla.kernel.org/show_bug.cgi?id=218587

I've tried to identify what exactly is going wrong but failed so far. Reverting
this changes is the only working solution so far. This also triggered a kernel crash
on error path https://bugzilla.kernel.org/show_bug.cgi?id=218542 which is
now fixed/queued.

If you have any hints how to debug this further or patches to try, I'd be happy to
try those out.

Cheers,

-Mikko

> Kind regards
> Uffe
> 
> 
> > ---
> >
> > Changelog:
> > v3--v4:
> >         check sbc.error as well
> > v2--v3:
> >         Adopt Adrian's proposal
> > v1--v2:
> >         remove redundant reference of reliable write
> > ---
> >  drivers/mmc/core/block.c | 46 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index f9a5cffa64b1..892e74e611a0 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
> >         struct mmc_ioc_cmd ic;
> >         unsigned char *buf;
> >         u64 buf_bytes;
> > +       unsigned int flags;
> > +#define MMC_BLK_IOC_DROP       BIT(0)  /* drop this mrq */
> > +#define MMC_BLK_IOC_SBC        BIT(1)  /* use mrq.sbc */
> > +
> >         struct mmc_rpmb_data *rpmb;
> >  };
> >
> > @@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
> >  }
> >
> >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> > -                              struct mmc_blk_ioc_data *idata)
> > +                              struct mmc_blk_ioc_data **idatas, int i)
> >  {
> >         struct mmc_command cmd = {}, sbc = {};
> >         struct mmc_data data = {};
> > @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >         unsigned int busy_timeout_ms;
> >         int err;
> >         unsigned int target_part;
> > +       struct mmc_blk_ioc_data *idata = idatas[i];
> > +       struct mmc_blk_ioc_data *prev_idata = NULL;
> >
> >         if (!card || !md || !idata)
> >                 return -EINVAL;
> >
> > +       if (idata->flags & MMC_BLK_IOC_DROP)
> > +               return 0;
> > +
> > +       if (idata->flags & MMC_BLK_IOC_SBC)
> > +               prev_idata = idatas[i - 1];
> > +
> >         /*
> >          * The RPMB accesses comes in from the character device, so we
> >          * need to target these explicitly. Else we just target the
> > @@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >                         return err;
> >         }
> >
> > -       if (idata->rpmb) {
> > +       if (idata->rpmb || prev_idata) {
> >                 sbc.opcode = MMC_SET_BLOCK_COUNT;
> >                 /*
> >                  * We don't do any blockcount validation because the max size
> > @@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >                  * 'Reliable Write' bit here.
> >                  */
> >                 sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
> > +               if (prev_idata)
> > +                       sbc.arg = prev_idata->ic.arg;
> >                 sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> >                 mrq.sbc = &sbc;
> >         }
> > @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >         mmc_wait_for_req(card->host, &mrq);
> >         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> >
> > +       if (prev_idata) {
> > +               memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
> > +               if (sbc.error) {
> > +                       dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
> > +                                                       __func__, sbc.error);
> > +                       return sbc.error;
> > +               }
> > +       }
> > +
> >         if (cmd.error) {
> >                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
> >                                                 __func__, cmd.error);
> > @@ -1032,6 +1055,20 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> >         md->reset_done &= ~type;
> >  }
> >
> > +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)
> > +{
> > +       struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
> > +       int i;
> > +
> > +       for (i = 1; i < mq_rq->ioc_count; i++) {
> > +               if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> > +                   mmc_op_multi(idata[i]->ic.opcode)) {
> > +                       idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
> > +                       idata[i]->flags |= MMC_BLK_IOC_SBC;
> > +               }
> > +       }
> > +}
> > +
> >  /*
> >   * The non-block commands come back from the block layer after it queued it and
> >   * processed it with all other requests and then they get issued in this
> > @@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
> >                         if (ret)
> >                                 break;
> >                 }
> > +
> > +               mmc_blk_check_sbc(mq_rq);
> > +
> >                 fallthrough;
> >         case MMC_DRV_OP_IOCTL_RPMB:
> >                 idata = mq_rq->drv_op_data;
> >                 for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> > -                       ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> > +                       ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
> >                         if (ret)
> >                                 break;
> >                 }
> > --
> > 2.42.0
> >
