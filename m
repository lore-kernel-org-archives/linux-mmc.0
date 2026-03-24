Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC542652A2
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356307; cv=pass; b=m8YyeMt+lbjYh29/eqXr/ZUuQzFUWqcYKkkP6Ix8ZDWqswXXxjNrC8SDa6rs4rM0Ih5FhOp9c7DINxCaiv/5kUnksohRNsYHJvYrfmLdEkRk2CL+pxfwPh3+s1LaDQxg7n6AOcO8pzcuKbzc8RdiGXulM4iVaTqQt6aLqZN4eH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356307; c=relaxed/simple;
	bh=yqTSsXn3Tf0bFbAjwSIJvuO1YqDq8DGlfkp/JXwCRSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHnw71TrHSfVNedps/3ZG5BByL8oK+NK+i3uytSjyd+XReeFKK/JiM2xeok6CRV2fbzZUSMy4AHz6d7pWLg7vobvuYEAGWnFRULBuAggRYRCqA2JDn7EissmaI82dGjC1UWaoPGeV6z2fsIBZC7WcqpPrXt2tk0klCDrRogQq0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fAgAj3VR; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAgAj3VR"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59de8155501so5231163e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 05:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774356304; cv=none;
        d=google.com; s=arc-20240605;
        b=DyDZ/6nL4J+i67BssFtOysCG2SQat4emLgrapdGI1H/6aY5IzeMKqk1ZUvmLYj5svz
         KQGPZTcRSP3GLPQXK89gz9sowop5rqVsu0gfJu/MM01NtO4ZhTcXA42nTubaTc9CXb5H
         WiQoQdaolSUTvJC+Dgj7V/8CAA8EVtMKnEBiLZ0YZp1txz0Q6QjG5392vJIuNGQCyG+2
         EtJ8fs7OgOjqYCEeiIioOzO02g/D+DNN6pDFA1JdpH27qiL5akFwn99rdg1O2H0haDv0
         1tHg7AFrm6AzX/sT7C5dtv2o3O2udM7Llx0kA4khLpP3XU55EVNqD0NMVlLFOIozMrre
         1TbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t5fYTCkjrAgQURSIIg0HU6EB9FGTRkSpxZH93SzCPw8=;
        fh=j3ZOZL7zPVTyB2jVWxT3iAA5NTCqNVFoAZ25AjuaP/I=;
        b=HtW7t4UKsT3qKoFEw1SnErU7bZjM1kl1SGm/hMzrmTkSEOnGixnydmLuOic/HHCySJ
         /qkvw5TLFsZ39GNjgKLCBG60FTzfJOoG+EHm4IScRbpPNsV2lSHfhxhf4kB20GipcLwJ
         t4hAhIm6clqvyevUlGkYpulpwWyLLzuaw5W3H23rPYky1z5f6i2yRk1qs5mzjXGiiLPW
         xpzU43MrT276Fl8mugIEQJEPK7YXYgsvU0he0u+VwSCFVJ0y1869vi6FWsFZFGE/OuM4
         TwKWnQ8NuY4vmEZR01qgcdlOyhMYDy2xGjvXDwl3WCsPMT/nnsF55x/wQHzCUNHqQlBL
         xrHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774356304; x=1774961104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5fYTCkjrAgQURSIIg0HU6EB9FGTRkSpxZH93SzCPw8=;
        b=fAgAj3VR/2wpkKs1SpN01z9BDGgtwW8hI43hRZo2+Ztdw/xveAMkn0rUgO8H5cfux9
         k73FNPbOV5JL9rKQYJK1QQdwZR7dk2RZ1NK0sNuAteSBRklZSj/k7uQ3hQjoxgirokEx
         EzQVW2wckcVlHKn1gJDOy/MPIzXiV8Gp9ajFuuEvQMyqpEbc/CoH5AWooO7aBFKWZkA4
         2osCVlGVqCHOAkzRNOkyAA+hSaEsOlgCsLheDeWcxN/dU2wGJKqUQMi0x6nOqp5n7Z21
         NzQuJrEBxCR0HKhBY5xbfnsrceoKPXFZJrahkpVQpiLXpuDE6eERQ35zzqAN5v6Z3cIi
         QHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774356304; x=1774961104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5fYTCkjrAgQURSIIg0HU6EB9FGTRkSpxZH93SzCPw8=;
        b=FytF/KRb0pjxB06Zbjd9II2qF2qhJaxf0SOe931+baczUBYtTuPyQR15k2hVRswWJE
         M4JK/0XU6Vb9IQVNqoJT8njtNO7nS+swudunk7lLL7Fu2dg6oWKNsRd6t1BHYM2eAJl7
         Oj0AmNRPwqooGhBqhD0NKMQ2J5aT//vdpNZ7YDO3OH/fOLC/WqcjVoqFUfMgGXeRt0np
         dvah0Ruz0Xxcr5KzlgD1KfrdZcIpc6sj5XSdfpi1GiKIc9dp+881u/syGjhmcjl0TZtx
         5SnWFlB7gv3XBs63Ab+eaEQDDa4zRyIPQTxipKDkUJXIXNFRP/t7QgPFzUPiQN9irTSo
         qezQ==
X-Forwarded-Encrypted: i=1; AJvYcCW53no4jA2YiMsZwCQVUeO7MU8hsp6Lq7cD3PTVgN3v3pILSTWr2PnPYocgjwdEQTnQgG8hx2SMttU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygXUljyXVNah1F0oeCpg69s0zbLm21gURwWtFZ20jLPhvTX4UG
	bIxNsgY5lAT3y9+FKdv4cRCYCtimkth0cbnT8e2Uc3abbtxzUbuOeYUu2J5LJdRKzQbGeptW7hi
	xjnxFbe1vOpkM/lRsdHgIah3io6Ig5dnToPYtkU5mrQ==
X-Gm-Gg: ATEYQzz98ronC8iCr6EizgQQZmS5U08vHc/U/WRYTCSKdpV+bo2ybsUoBw/xdSOBHvV
	bumDQEv5i50/3QRaNXy0lC1zJbKMhg0RodtGOL2supRGAP1CiFQfHgFb5L5jAMuZZ3DeMXJGUuV
	9exQxtCNiuYnzwomDnsOKiN0x7o/YGtNiOgSHFwzv3Rq5UFkLYYfEAfEvrkZJWRia3J22BHHAfB
	NhpCfcRt5PNSJtG7LJEOucgPL8aS2PKu0n8NPaJRBcQPzNBNAHZveoCyeDus4BfNmK48TU6GsP7
	vPBLG3M8
X-Received: by 2002:a05:6512:609:20b0:5a2:864a:bebb with SMTP id
 2adb3069b0e04-5a2864abeffmr3572286e87.20.1774356303463; Tue, 24 Mar 2026
 05:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310160408.3976760-1-b-liu@ti.com> <CAPDyKFrM92eAxCxU9E1eDNfXMdOC4JvAOXYgY=HcmFG2YfrQEg@mail.gmail.com>
 <20260316162241.2zry4hjmufiwphmg@iaqt7>
In-Reply-To: <20260316162241.2zry4hjmufiwphmg@iaqt7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 13:44:27 +0100
X-Gm-Features: AQROBzBIVyK8PtCTVLrDRNOS2gRTfn-qhdFv6gGKbTwAiOJKddMixLXpA7wQmq8
Message-ID: <CAPDyKFrHnhoUB4LqXV6RU6i=it4GcM_OXAzD2YeGK8rPq3cQ_w@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 17:23, Bin Liu <b-liu@ti.com> wrote:
>
> Hi Ulf,
>
> On Mon, Mar 16, 2026 at 04:01:38PM +0100, Ulf Hansson wrote:
> > On Tue, 10 Mar 2026 at 17:04, Bin Liu <b-liu@ti.com> wrote:
> > >
> > > Due to errata i2493[0], multi-block write would still fail in retries.
> > >
> > > This patch reuses recovery_mode flag, and switches to single-block
> > > write in retry when multi-block write fails. It covers both CQE and
> > > non-CQE cases.
> > >
> > > [0] https://www.ti.com/lit/pdf/sprz582
> >
> > It's great that a link like the above can be provided, still it would
> > be nice to explain a bit more about the problem in the commit message
> > too. Can you please do that?
>
> Sure I will add the errata details in the commit message in v2.
>
> >
> > > Signed-off-by: Bin Liu <b-liu@ti.com>
> > > ---
> > >  block/blk-mq-debugfs.c   |  1 +
> > >  drivers/mmc/core/block.c | 12 ++++++++++--
> > >  include/linux/blk-mq.h   |  3 +++
> > >  3 files changed, 14 insertions(+), 2 deletions(-)

Please split this patch into two, one for the blk-mq core and one for mmc core.

> > >
> > > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > > index 28167c9baa55..5f97d07fa3c8 100644
> > > --- a/block/blk-mq-debugfs.c
> > > +++ b/block/blk-mq-debugfs.c
> > > @@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
> > >         RQF_NAME(ZONE_WRITE_PLUGGING),
> > >         RQF_NAME(TIMED_OUT),
> > >         RQF_NAME(RESV),
> > > +       RQF_NAME(XFER_SINGLE_BLK),
> > >  };
> > >  #undef RQF_NAME
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > index 05ee76cb0a08..00016584d70d 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> > >                     rq_data_dir(req) == WRITE &&
> > >                     (md->flags & MMC_BLK_REL_WR);
> > >
> > > +       if (req->rq_flags & RQF_XFER_SINGLE_BLK)
> > > +               recovery_mode = 1;
> > > +
> >
> > I don't get this, sorry.
>
> No worries, the logic of this solution is not that obvious.
>
> In summary of this patch, in both CQE-enabled and non-CQE cases, in
> *_complete_rq(), flag RQF_XFER_SINGLE_BLK is set in req->rq_flags when
> WRITE request fails. This is to mark that single-block write, according
> to errata i2493, should be used in retrying this WRITE request.
>
> In retrying, mmc_blk_data_prep() is called again with
> RQF_XFER_SINGLE_BLK set, this makes recovery_mode to be forced to 1,
>
> then a few lines down in mmc_blk_data_prep():
>
>         if (recovery_mode)
>                 brq->data.blocks = queue_physical_block_size(mq->queue) >> 9;
>
> The req block size is set to 1 to use single block write.
>
> Please let me know if this explains the logic of this patch.

Yes, that makes more sense now, thanks for clarifying!

>
> >
> > Under what circumstances do we need to fall back to using "single
> > block"? Or is this just for debugging?
>
> When multiple block write fails, use single block write. This is
> the software workaround documented in the errata i2493.
>
> This is not for debugging. When multiple block write fails, switching
> to single block write will sccuseed.

Okay, again, thanks for clarifying!

[...]

I noticed your conversation with Shawn, where he pointed out, that we
already have something similar for READ, which is implemented
internally within the mmc block device driver.

I don't have a strong opinion on how to do this, so assuming Jens is
okay with the approach in $subject patch, I am happy to proceed.

If we decide to move forward with this, perhaps we should re-work the
internal MMC fallback for READ to align with this approach too.

Kind regards
Uffe
