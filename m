Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD67CE7A94
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Sep 2023 14:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjIYOAW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Sep 2023 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIYOAV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Sep 2023 10:00:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F93CE
        for <linux-mmc@vger.kernel.org>; Mon, 25 Sep 2023 07:00:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso7327234276.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 Sep 2023 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695650414; x=1696255214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=simHxQla0UGgl7e9uhulgQd+yieE8p7l9WM34RpzBNo=;
        b=MVvms30Gt+kQ1W/QtgHK6ZP7eyNvylwgYKzQvpsVRY5JRpZTkvJoIwlBzc5YSwAYIp
         5Q355GWgY/y4k8KuwRozwwOvYRU0mpdZ9DGKzQ0EELfprTt9u9eQ5RBCwRAsg0gpna1+
         BkJS2sA7Xp235MixqUM3k3Fwe5SIG8iKPxe5r+KCmbZ6qKEWKM11nVc5rQrPGNZh9t/a
         SBy9zQIiIKO5RQhsN2BxA72ej9g7HUAMv+QKY4Rbc/G5mg0zOMSt3hdfIfGloLMQYfUC
         DnfSwpxDbEYP7I71+5q8vlOvnvoOPViY7qCfCyLUd+BRR6mGCqL990pNdoMYXyiNQOmY
         kccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650414; x=1696255214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=simHxQla0UGgl7e9uhulgQd+yieE8p7l9WM34RpzBNo=;
        b=SjJ3sZr20WjQ1KSOYufgSQ9S3efBGAbTTmF/upcru9bB459Ge2VaXC2n8vWtjyHwXV
         Cn4n5Ezk1lorvFh5XP77tFvFH8X1Zw7mVHwHZeo/F+0T1edFYuFb1U22NfVdNwqyTlwZ
         1U2mS4m1u2DpUa0nvoUfLfsqlRIil8k7kqaFhZNR1IqC1Pf9Ive/eC+6auZmNc6NhIo4
         WhrBIxJC68gUZ3wf1k8VPR1CEt1dZIsUQw9HLLpDF4QOk717Z9Vn6yFrBD3vtzhu3z7N
         Rh8d9/lbYeK4OTLHn20w1L4zmtump63B5nTaLQMWON1T6Ehwl5UsglJTE2XfJZ0koHjK
         6bGA==
X-Gm-Message-State: AOJu0YxGi0uZ9QRgYRmqENhrjfDoa/XWBEnLD3sHnjGdVIoV8MJZvL2Q
        nFIXpb8h+AS3dGqn7UetFFUe5Mrgmo9cET7qU6YVAg==
X-Google-Smtp-Source: AGHT+IFdrhN2FzdmxrLxhj4hyTn+/FFWlAOvNyceXBIoIfDOhwc/3Stsrlp+HE4vRp2rU//z4W2h+ypQ0psOAE3ypvM=
X-Received: by 2002:a25:264b:0:b0:d4c:2a34:e577 with SMTP id
 m72-20020a25264b000000b00d4c2a34e577mr6557478ybm.19.1695650413981; Mon, 25
 Sep 2023 07:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230914000348.25790-1-michael@allwinnertech.com> <CA+Da2qzr0SBu-kUtFTnBqT+OObFOSTFgmU30L3B-Rjv3rYbGKw@mail.gmail.com>
In-Reply-To: <CA+Da2qzr0SBu-kUtFTnBqT+OObFOSTFgmU30L3B-Rjv3rYbGKw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Sep 2023 15:59:37 +0200
Message-ID: <CAPDyKFpHw+6vovHRWbhsDwre81U4Uu_X-Wy_viQCZp6nj=5Jkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add new flag to force hardware reset
To:     Michael Wu <michael@allwinnertech.com>,
        Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, jinpu.wang@ionos.com,
        victor.shih@genesyslogic.com.tw, avri.altman@wdc.com,
        asuk4.q@gmail.com, f.fainelli@gmail.com, beanhuo@micron.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sarthak Garg <quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- trimmed cc-list, + Sartak Garg

On Thu, 14 Sept 2023 at 10:00, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> On Thu, 14 Sept 2023 at 08:04, Michael Wu <michael@allwinnertech.com> wrote:
> >
> > Entering the recovery system itself indicates a transmission error.
> > In this situation, we intend to execute the mmc_blk_reset function
> > to clear any anomalies that may be caused by errors. We have previously
> > discussed with several MMC device manufacturers, and they expressed
> > their desire for us to reset the device when errors occur to ensure
> > stable operation. We aim to make this code compatible with all devices
> > and ensure its stable performance, so we would like to add this patch
> >
> > Signed-off-by: Michael Wu <michael@allwinnertech.com>
>
> like: https://lore.kernel.org/linux-mmc/20220603051534.22672-1-quic_sartgarg@quicinc.com/

Looks like this series didn't make it. I was awaiting a rebase from
Sartak to apply it, but apparently something got in his way for a new
submission.

>
> You should enable it in the vendor host.

Yes! We don't want unused code in the core. We need a user of it too.

May I suggest that you pick up Sartak's patch for the core and thus
add another patch for the host driver you care about and then
re-submit it as a small series.

Kind regards
Uffe

>
> > ---
> >  drivers/mmc/core/block.c | 2 +-
> >  include/linux/mmc/host.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index b5b414a71e0b..29fbe0ddeadb 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -1503,7 +1503,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
> >         pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
> >
> >         err = mmc_cqe_recovery(host);
> > -       if (err)
> > +       if (err || host->cqe_recovery_reset_always)
> >                 mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
> >         mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
> >
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 62a6847a3b6f..f578541a06b5 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -518,6 +518,7 @@ struct mmc_host {
> >         int                     cqe_qdepth;
> >         bool                    cqe_enabled;
> >         bool                    cqe_on;
> > +       bool                    cqe_recovery_reset_always;
> >
> >         /* Inline encryption support */
> >  #ifdef CONFIG_MMC_CRYPTO
> > --
> > 2.29.0
> >
