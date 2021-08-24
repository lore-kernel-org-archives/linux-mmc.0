Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D209C4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48004613BD
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 11:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhHXLbH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbhHXLay (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 07:30:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA3C0613D9
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 04:30:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f2so37079152ljn.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FreLuXtpPO5M0wpQU/au7ZiAqtijlcsGc59gKKgk/cE=;
        b=CSa5G9X9T10H39Cf/4WsJMIxldeEYSZf5kx/O07w10fZxVPEumBmJD1Kf2LVpJKp+g
         8iS5NXOGRh+fdG+c2yAcHS6cf2m6CK/Am3BaWXW/hjiMg6RW/DTv4Qb9ykuxIwhE4mSO
         tYrJumdu2IGkMZwbAFIdJCTZhunSMPu/qf9L5JBmLd3rEAomkKZ2ysTC/ESmnWk+uoLH
         dhTdigaeNI3a7Ibl2b/f+kWgNubmfACJ6CgL5aC4vWMEvCJQZnMQpI2GgQ5Ggf5PYrLD
         B/T4J+orYR8TXEg7Gl9rtKcV/bhxs/Qfzg1ja7iPm4UNCSG/8xr5MSxG++9UDXW47kET
         aUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FreLuXtpPO5M0wpQU/au7ZiAqtijlcsGc59gKKgk/cE=;
        b=jfGV1k/UPuLG6tfdPWHqt35fS5L5XMfh3tSfC9F28cJzMLaoEZO0i3hSmXGoAZSfwj
         ALllWJWssjtCTX+8oqR9/UBUREDEdsoJlJ+3y1xFcIjIYEK5EfXKge84JYQ+OUKzb8+t
         ZDPZ315hGtHknpwa3imuDYWLx/66cwQRtI1PhqdCaRdUsM5ZQXCDo43U+hVhAkXhvmY9
         6O6yMkfCVJWNjUSZNTYA/NDnDxPVQmZB9L9wYBv0bhAk/ZVt4Rc3/4afYyMXS5xeikLO
         7lI643aB668x98TW69WP5rYwV5cUdSni3/DsRIdHn7hY+BI6rVDKCjSw+FA5qX2X36q2
         NHFA==
X-Gm-Message-State: AOAM530YEO2AXDbCF1hztm922yNyEW0DZBBCNaFd0o4geZj0QCG0wwSK
        Pz6gibOElqJ+M2B05neCT9IdI3Vg+9pRtW/keaJLng==
X-Google-Smtp-Source: ABdhPJxQH8k8XULO0z2A31EiJpmeQRdAX6jY9QPJ8haOSv/5nXSkOoXHLu6IrdzQGyKAfdrldcuInPU7bxrN6lLg18c=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr31894238ljq.341.1629804608413;
 Tue, 24 Aug 2021 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210713053458.1441-1-oracleks043021@gmail.com> <DM6PR04MB65754DC90E423A79D80263C1FC149@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65754DC90E423A79D80263C1FC149@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 13:29:32 +0200
Message-ID: <CAPDyKFp_HGSfm_ZR6=CSzNAK9jXZ+hNBh4=9Ld67-fSkKPJ_4A@mail.gmail.com>
Subject: Re: [PATCH v1] mmc-utils: Fix for Firmware Version string printing
To:     Avri Altman <Avri.Altman@wdc.com>,
        "oracleks043021@gmail.com" <oracleks043021@gmail.com>
Cc:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Jul 2021 at 10:00, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> >
> > From: Kimito Sakata <kimito.sakata@oracle.com>
> >
> > Added a local buffer to create a NULL terminated string to print the
> > Firmware Version instead of attempting to print directly from
> > ext_csd buffer. The last byte of the Firmware Version field may not
> > be NULL and the next field may also not be which may cause it to
> > print garbage.
> >
> > Tested on x86 platform.
> Fixes: 89cd01ed865a (mmc_utils: add ffu support)
>
> Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Applied for master at git.kernel.org/pub/scm/utils/mmc/mmc-utils.git, thanks!

Kind regards
Uffe


>
> > ---
> >  mmc_cmds.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index afa85b7..205e6e5 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -1392,6 +1392,7 @@ int do_read_extcsd(int nargs, char **argv)
> >         __u32 regl;
> >         int fd, ret;
> >         char *device;
> > +       char lbuf[10];
> >         const char *str;
> >
> >         if (nargs != 2) {
> > @@ -1833,8 +1834,9 @@ int do_read_extcsd(int nargs, char **argv)
> >         }
> >
> >         if (ext_csd_rev >= 7) {
> > -               printf("eMMC Firmware Version: %s\n",
> > -                       (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> > +                memset(lbuf, 0, sizeof(lbuf));
> > +               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> > +               printf("eMMC Firmware Version: %s\n", lbuf);
> >                 printf("eMMC Life Time Estimation A
> > [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
> >                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
> >                 printf("eMMC Life Time Estimation B
> > [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
> > --
> > 2.31.1
>
