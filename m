Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D81C32771
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Sep 2022 12:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIUM6X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUM6W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 08:58:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485382CE0E
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:58:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bq9so9774320wrb.4
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ivMXteJD1kasjSdEQtDDWLzezvmG+yDgYxIPwASPR6Y=;
        b=Iypg8hGgoEV01gMlkPLB7U7knV9JpM68f1Ks2yC/PEaz0zqd6yNUJf5mIcDi17JQYF
         44VPnpyXU61io4RPdRZOr24wSUFSdjpJMqC6NgfPJfSME3Ygf27poEiPR4mk/cX8fgvS
         cIb1YgSKYgEB7x0WQAL5y0PsRBb+Di5OixURKx12w/rbLzckpJK3F7/p/XYbocKm0eN1
         QA3aHVImAgS2vqi1txGS+3hf3XeI57kRNjSwRjuoNFNEB7R0LP+LaOytxYtKWSkrXs3x
         SLohovUwgC8p63b4oJ+ZoZ4YZDmuVjaixtBDwIm8rziaP5IK9KtcYhSC6SYUP61Y3wM5
         7AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ivMXteJD1kasjSdEQtDDWLzezvmG+yDgYxIPwASPR6Y=;
        b=jsl8zlcizHtLA+jypuHGbT5PGr3f4Y4gAbM+XfR7CkwMAjnLuQMK3yIE8d4wEOEW2Z
         jtTaFDwgM9TjVTHR3i24c8Kvp1xo7IDeI6IkeNrH+/owcz7jXBcrs7JwQMwIpRnIMQKM
         nm5dw3L5vYI3rcU+kleuKCaGj6b5e40JPis23cFrJ9DrChg/H2F4TVcpjPrTCp6WoZP8
         HCZKCkmTruZMgPkPnIAtD+6ZAGnBiVtgkkRELnL/9kBZZ/XewlZM1E3DXJVgVJFNUtZs
         gCgFm3/bNag4YOts9cDGdVyhzAx0QfDHxNl9kX+LyPKrycrAs7qHnVAnpwmWflBN7lVW
         Zkdg==
X-Gm-Message-State: ACrzQf2yTzlmvnJnUXa623bZxgPtXichQbX6Fk4KfigUhMpFqJ/ve4Eu
        NhvWrUtQTsDPO5z4xNHhPN2/Cz+sZcahvNb+CTFRcw==
X-Google-Smtp-Source: AMsMyM77TPJJ2iqVklEf7ChJ3YmqwG5rryg/didaA/YVnn8Vy7ReT7ikWwxC97YoCVWaVd4F6xTyn8XF8NGh/atioTE=
X-Received: by 2002:a5d:6d8e:0:b0:22a:4831:e0e with SMTP id
 l14-20020a5d6d8e000000b0022a48310e0emr16235406wrs.442.1663765099785; Wed, 21
 Sep 2022 05:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR04MB65750F5EE2E1C9D2CC103A64FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20220920124749.24073-1-bruno.matic@nokia.com> <DM6PR04MB657522EA8E6540BC77D19E15FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657522EA8E6540BC77D19E15FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:57:43 +0200
Message-ID: <CAPDyKFoyem6eYTA3qH2H3dnoYiA=eVF8_VJQR4Ec8Suswupw6g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Fix ffu in case of unsupported MODE_OPERATION_CODES
To:     Bruno Matic <bruno.matic@nokia.com>,
        Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "jakob.rossler@nokia.com" <jakob.rossler@nokia.com>,
        "aarne.heinonen@nokia.com" <aarne.heinonen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Sept 2022 at 14:54, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> >
> > Move up the return in case MODE_OPERATION_CODES is not supported.
> > According to the specification when MODE_OPERATION_CODES is not
> > supported no checks should be done against NUM_OF_FW_SEC_PROG.
> >
> > Changes in v2:
> >   - better explanation in the comment
> Fixes: 89cd01ed865a (mmc_utils: add ffu support)
>
> Thanks,
> Avri
>
> >
> > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Avri, I assume you are happy with the partch, but just forgot to add
your reviewed-by-tag? I added it, but please tell me if I should drop
it.

Kind regards
Uffe

> > ---
> >  mmc_cmds.c | 85 +++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 45 insertions(+), 40 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index ef1d8c6..a3740ab 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2897,6 +2897,16 @@ do_retry:
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * By spec - check if mode operation codes are supported in ffu
> > features,
> > +        * if not then skip checking number of sectors programmed after install
> > +        */
> > +       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> > +               fprintf(stderr, "Please reboot to complete firmware installation on
> > %s\n", device);
> > +               ret = 0;
> > +               goto out;
> > +       }
> > +
> >         ret = read_extcsd(dev_fd, ext_csd);
> >         if (ret) {
> >                 fprintf(stderr, "Could not read EXT_CSD from %s\n", device); @@ -
> > 2927,49 +2937,44 @@ do_retry:
> >                 goto out;
> >         }
> >
> > -       /* check mode operation for ffu install*/
> > -       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> > -               fprintf(stderr, "Please reboot to complete firmware installation on
> > %s\n", device);
> > -       } else {
> > -               fprintf(stderr, "Installing firmware on %s...\n", device);
> > -               /* Re-enter ffu mode and install the firmware */
> > -               multi_cmd->num_of_cmds = 2;
> > -
> > -               /* set ext_csd to install mode */
> > -               multi_cmd->cmds[1].opcode = MMC_SWITCH;
> > -               multi_cmd->cmds[1].blksz = 0;
> > -               multi_cmd->cmds[1].blocks = 0;
> > -               multi_cmd->cmds[1].arg = (MMC_SWITCH_MODE_WRITE_BYTE <<
> > 24) |
> > -                               (EXT_CSD_MODE_OPERATION_CODES << 16) |
> > -                               (EXT_CSD_FFU_INSTALL << 8) |
> > -                               EXT_CSD_CMD_SET_NORMAL;
> > -               multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> > -               multi_cmd->cmds[1].write_flag = 1;
> > -
> > -               /* send ioctl with multi-cmd */
> > -               ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > +       fprintf(stderr, "Installing firmware on %s...\n", device);
> > +       /* Re-enter ffu mode and install the firmware */
> > +       multi_cmd->num_of_cmds = 2;
> >
> > -               if (ret) {
> > -                       perror("Multi-cmd ioctl failed setting install mode");
> > -                       /* In case multi-cmd ioctl failed before exiting from ffu mode */
> > -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> > -                       goto out;
> > -               }
> > +       /* set ext_csd to install mode */
> > +       multi_cmd->cmds[1].opcode = MMC_SWITCH;
> > +       multi_cmd->cmds[1].blksz = 0;
> > +       multi_cmd->cmds[1].blocks = 0;
> > +       multi_cmd->cmds[1].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> > +                       (EXT_CSD_MODE_OPERATION_CODES << 16) |
> > +                       (EXT_CSD_FFU_INSTALL << 8) |
> > +                       EXT_CSD_CMD_SET_NORMAL;
> > +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> > +       multi_cmd->cmds[1].write_flag = 1;
> >
> > -               ret = read_extcsd(dev_fd, ext_csd);
> > -               if (ret) {
> > -                       fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> > -                       goto out;
> > -               }
> > +       /* send ioctl with multi-cmd */
> > +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >
> > -               /* return status */
> > -               ret = ext_csd[EXT_CSD_FFU_STATUS];
> > -               if (ret) {
> > -                       fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
> > -                       goto out;
> > -               } else {
> > -                       fprintf(stderr, "FFU finished successfully\n");
> > -               }
> > +       if (ret) {
> > +               perror("Multi-cmd ioctl failed setting install mode");
> > +               /* In case multi-cmd ioctl failed before exiting from ffu mode */
> > +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> > +               goto out;
> > +       }
> > +
> > +       ret = read_extcsd(dev_fd, ext_csd);
> > +       if (ret) {
> > +               fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> > +               goto out;
> > +       }
> > +
> > +       /* return status */
> > +       ret = ext_csd[EXT_CSD_FFU_STATUS];
> > +       if (ret) {
> > +               fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
> > +               goto out;
> > +       } else {
> > +               fprintf(stderr, "FFU finished successfully\n");
> >         }
> >
> >  out:
> > --
> > 2.29.0
>
