Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B68BC10DCE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479762072C
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFoDY6tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCMKlU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:41:20 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46741 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMKlU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2020 06:41:20 -0400
Received: by mail-vs1-f66.google.com with SMTP id z125so5743288vsb.13
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2020 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sl0meI3plL58jaw0Qn1AdAWhf8RIUGrDFYSMJvhelBw=;
        b=TFoDY6tq1CclvO8EkOjepj4tylcaIF65pOAXcfAXxet0sVS5LUfme4mHmxBidw8h0L
         BpzOjocK5m66RwzWVYkE/3+YEIWwy12trkPA6wi5hJcx9xdGjpnnJy88/BhaBlDVodh5
         J/QJ47l+U9vxcbzxinpHuoPT81ucFdsPV+CsnKPL//WMAEKUTfjOtLuBCFaKQsGJZUAC
         T8BMB+OTSkOYrR6zyucQ+awNRJeSRCa06pkD6N+rRPZaEIh0N6EG7kNRWBUaqu3H8ryt
         QDH4+y8Q4l2dL1oPdUNz+Duk7WucEQlqkpjXRP7Jq+9ckUcKJi6JV5eN+BOYd5amxDkN
         UpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl0meI3plL58jaw0Qn1AdAWhf8RIUGrDFYSMJvhelBw=;
        b=T7qM2u7rSJLIygVD22IdIwgiHA56LZ5ZuDYIOC7WZ993V7JMXLAtDGkZOSRLxK0ByC
         b5EFWgzW1MBmgR1FzwYW2TXhPKLp4TNAHd4yZr24zcE0IWwEGiuKk00boFKSN5JQkeNx
         0jjKKSSjmqGLddHCz4gREmqZ9Pf5/g8v+puqDL3UPbGxtkATJGCc/u/Ss1rAzNmRLa7t
         6ZVPofwVIgJYh9V1yucd9Qfsi2CFlOzNkxHB87sENvhdZw2yHwBFzNanK7UOkHxTi4ay
         Wkt17ldGXQ0HkwmfbQ0bSDvqa5WDK8ieXU87+qNYISYH9kQKkjL0DUotUi28bAFneqy1
         7QRg==
X-Gm-Message-State: ANhLgQ1PBg/nIPvt9qx1wSWOaWvo+Az2I3HChr0+i4Mdv1NiYXBYBJ4E
        4boidoqVGca2nefwTRwvm1nF7OMKGTai57JMgojeLw==
X-Google-Smtp-Source: ADFU+vsGVajjIaVqV/6quFeoXB3Og6NXN/aEzj+rQ04GDqvDUUIbygdUrm5eDfdzRm1wavrQF14EtQutqbGwIBL2/xQ=
X-Received: by 2002:a67:2ec6:: with SMTP id u189mr8782404vsu.200.1584096077691;
 Fri, 13 Mar 2020 03:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200312142501.9868-1-adrian.hunter@intel.com>
 <20200312142501.9868-2-adrian.hunter@intel.com> <CAPDyKFpHZDy3TvHdQBuKgu5k3QkE+Pqcu5jumWa=LAY+ixUheg@mail.gmail.com>
 <5e2007ba-a090-b09b-6933-87c3548ed4f5@intel.com>
In-Reply-To: <5e2007ba-a090-b09b-6933-87c3548ed4f5@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Mar 2020 11:40:41 +0100
Message-ID: <CAPDyKFrthSS+SMFMZUCPLY+QSUiO0w3pWij9aw3oh2f5jEMa_Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] mmc: core: Try harder if transfer mode switch fails
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Kyungmin Seo <kyungmin.seo@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 13 Mar 2020 at 10:53, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 12/03/20 5:45 pm, Ulf Hansson wrote:
> > On Thu, 12 Mar 2020 at 15:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Add extra busy wait and retries if transfer mode switch fails.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  drivers/mmc/core/mmc_ops.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> >> index aa0cab190cd8..619088a94688 100644
> >> --- a/drivers/mmc/core/mmc_ops.c
> >> +++ b/drivers/mmc/core/mmc_ops.c
> >> @@ -599,6 +599,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> >>                 cmd.sanitize_busy = true;
> >>
> >>         err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> >> +       if (err && index == EXT_CSD_HS_TIMING) {
> >> +               /* Try harder for timing changes */
> >> +               __mmc_poll_for_busy(card, timeout_ms, send_status,
> >> +                                   retry_crc_err, MMC_BUSY_CMD6);
> >> +               err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> >> +       }
> >
> > Hmm, what do you think of moving this to the caller(s) of
> > __mmc_switch() and in particular only at those places were we find it
> > useful. Me personally, would prefer that option.
> >
> > To do that, we may need to have the possibility of specifying the
> > number of retries that should be used in the mmc_wait_for_cmd() call
> > to the caller can check the error code better.
> >
> > Moreover, it looks a bit risky to do the polling for all kinds of
> > errors - shouldn't we do for CRC errors?
> >
>
> What about this then?

Looks good to me!

Is the retry in __mmc_switch() with MMC_CMD_RETRIES okay for now you think?

Kind regards
Uffe

>
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c2abd417a84a..faa5d30ed891 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1235,20 +1235,35 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         int err;
>         u8 val;
>
> -       /* Reduce frequency to HS */
> -       max_dtr = card->ext_csd.hs_max_dtr;
> -       mmc_set_clock(host, max_dtr);
> -
>         /* Switch HS400 to HS DDR */
>         val = EXT_CSD_TIMING_HS;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>                            val, card->ext_csd.generic_cmd6_time, 0,
>                            false, true);
> -       if (err)
> -               goto out_err;
> +       if (err == -EILSEQ) {
> +               __mmc_poll_for_busy(card, card->ext_csd.generic_cmd6_time,
> +                                   false, true, MMC_BUSY_CMD6);
> +               err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                                  EXT_CSD_HS_TIMING, val,
> +                                  card->ext_csd.generic_cmd6_time, 0, false,
> +                                  true);
> +       }
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> +       /* Reduce frequency to HS */
> +       max_dtr = card->ext_csd.hs_max_dtr;
> +       mmc_set_clock(host, max_dtr);
> +
> +       if (err) {
> +               err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                                  EXT_CSD_HS_TIMING, val,
> +                                  card->ext_csd.generic_cmd6_time, 0, false,
> +                                  true);
> +       }
> +       if (err)
> +               goto out_err;
> +
>         err = mmc_switch_status(card, true);
>         if (err)
>                 goto out_err;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 6eb87833d478..54afee7c34ae 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -484,9 +484,9 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
>         return 0;
>  }
>
> -static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> -                              bool send_status, bool retry_crc_err,
> -                              enum mmc_busy_cmd busy_cmd)
> +int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> +                       bool send_status, bool retry_crc_err,
> +                       enum mmc_busy_cmd busy_cmd)
>  {
>         struct mmc_host *host = card->host;
>         int err;
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 38dcfeeaf6d5..649985507f87 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -36,6 +36,9 @@ int mmc_interrupt_hpi(struct mmc_card *card);
>  int mmc_can_ext_csd(struct mmc_card *card);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>  int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
> +int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> +                       bool send_status, bool retry_crc_err,
> +                       enum mmc_busy_cmd busy_cmd);
>  int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>                       enum mmc_busy_cmd busy_cmd);
>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>
