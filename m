Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887CFC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 05:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF4E61100
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 05:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhHYF1e (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 01:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHYF1d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 01:27:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D1C061757;
        Tue, 24 Aug 2021 22:26:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g14so20290424pfm.1;
        Tue, 24 Aug 2021 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iaQAPMmQexM8qUaFvKcBt7l35a6FSlIF1HUBknxyn8c=;
        b=iQIk/FKsS1v5Df4/QgoRDTwNvX5zfAkgazKhIBUkyo+ynBgvSO9aaKAFHe7c2c1pDX
         jxwzCrDj2AHZPLm/eG8M9U/wkc7Vkr5GBdBP6MtRiyH8EfjK3D6kJb3zjs3/0QprDp3F
         wdsiJLpwqkDS0NdR5t8o0ABHwx7KQUv5cggAj0TAuwBqd533tH8Be8gPEEIvlEm0B0n0
         w2k5czuKynTMGPs7IFLEufbezk6vwlJfiPq+c76ANmJo4eoitCfG3TcnoeebX8fKLJ1H
         /Q2KLwo2NLP41RrQVIkKibifAHu9QDDAlKz3jMwtzE48KYEMTb96V1KTh7/Czu78kFRF
         VbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iaQAPMmQexM8qUaFvKcBt7l35a6FSlIF1HUBknxyn8c=;
        b=BGW6zOhe692zzPBNNVoi1n1kNbBLQBlNxbNfyk2/5EjTV+vD3Z7mtctv4Zl0dnnF4S
         DXTKK5CcwQ27L7WVkc32qTEWTMjFvEwaFm7tH8SO7HWCaCjobvYKI3P6AK1JA+ygWjOE
         iU12+AImEXh4CtxHX6ia/P5PTfzFL4PDVNUEwuqMlTRvwBx+W95ilZxdwGE7vbJ6r51j
         ZSOrAeVkin4tP0KyXWx9mcr447AJMk7bBCW7YD5f6NjnmntucE//EwBmoImkO6SSkafw
         A0SW+GEBOZa6v3K5iThR3dIK2ABnDIv9IhrLJhSv3RQ2Riq4ioSMej5/zmxZpywTW1gX
         AvBw==
X-Gm-Message-State: AOAM530Q7QuyAxfSCdmgXsUrjANtc3QBaHp/jYwHpRuR8ZcAvUGOUDPM
        boL3GQ49tPyZiS/p8C/fD5I=
X-Google-Smtp-Source: ABdhPJxAOLcf9r5WGGXViQ1Bt8/msrXUFccwuCdoSBbau7tvY9bZxDbChsN4cU28HJI0sux+1qWUqg==
X-Received: by 2002:a65:47c9:: with SMTP id f9mr23291308pgs.292.1629869208299;
        Tue, 24 Aug 2021 22:26:48 -0700 (PDT)
Received: from nishad ([106.51.233.109])
        by smtp.gmail.com with ESMTPSA id 132sm583216pfy.190.2021.08.24.22.26.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Aug 2021 22:26:47 -0700 (PDT)
Date:   Wed, 25 Aug 2021 10:56:40 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mmc: core: Return correct emmc response in case of
 ioctl error
Message-ID: <20210825052638.GB2773@nishad>
References: <20210812065730.3986-1-nishadkamdar@gmail.com>
 <CAPDyKFoaXdNDvO91n3rUsqe2JMg5E7YObYDnkAW4jqzVV+GLtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoaXdNDvO91n3rUsqe2JMg5E7YObYDnkAW4jqzVV+GLtw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 24, 2021 at 02:44:42PM +0200, Ulf Hansson wrote:
> On Thu, 12 Aug 2021 at 08:57, Nishad Kamdar <nishadkamdar@gmail.com> wrote:
> >
> > When a read/write command is sent via ioctl to the kernel,
> > and the command fails, the actual error response of the emmc
> > is not sent to the user.
> >
> > IOCTL read/write tests are carried out using commands
> > 17 (Single BLock Read), 24 (Single Block Write),
> > 18 (Multi Block Read), 25 (Multi Block Write)
> >
> > The tests are carried out on a 64Gb emmc device. All of these
> > tests try to access an "out of range" sector address (0x09B2FFFF).
> >
> > It is seen that without the patch the response received by the user
> > is not OUT_OF_RANGE error (R1 response 31st bit is not set) as per
> > JEDEC specification. After applying the patch proper response is seen.
> > This is because the function returns without copying the response to
> > the user in case of failure. This patch fixes the issue.
> >
> > The test code and the output of only the CMD17 is included in the
> > commit to limit the message length.
> >
> > CMD17 (Test Code Snippet):
> > ==========================
> >         printf("Forming CMD%d\n", opt_idx);
> >         /*  single block read */
> >         cmd.blksz = 512;
> >         cmd.blocks = 1;
> >         cmd.write_flag = 0;
> >         cmd.opcode = 17;
> >         //cmd.arg = atoi(argv[3]);
> >         cmd.arg = 0x09B2FFFF;
> >         /* Expecting response R1B */
> >         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> >
> >         memset(data, 0, sizeof(__u8) * 512);
> >         mmc_ioc_cmd_set_data(cmd, data);
> >
> >         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
> >         if(ioctl(fd, MMC_IOC_CMD, &cmd))
> >                 perror("Error");
> >
> >         printf("\nResponse: %08x\n", cmd.response[0]);
> >
> > CMD17 (Output without patch):
> > =============================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 0x09B2FFF]
> > Forming CMD17
> > Sending CMD17: ARG[0x09b2ffff]
> > Error: Connection timed out
> >
> > Response: 00000000
> > (Incorrect response)
> >
> > CMD17 (Output with patch):
> > ==========================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
> > [sudo] password for test:
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 09B2FFFF]
> > Forming CMD17
> > Sending CMD17: ARG[0x09b2ffff]
> > Error: Connection timed out
> >
> > Response: 80000900
> > (Correct OUT_OF_ERROR response as per JEDEC specification)
> >
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> > ---
> > Changes in v2:
> >   - Make commit message clearer by adding test cases as outputs.
> > Changes in v3:
> >   - Shorten the commit message to include only CMD17 related
> >     code and test.
> >
> >  drivers/mmc/core/block.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index a9ad9f5fa9491..efa92aa7e2368 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -522,11 +522,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> >         if (cmd.error) {
> >                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
> >                                                 __func__, cmd.error);
> > +               memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> >                 return cmd.error;
> >         }
> >         if (data.error) {
> >                 dev_err(mmc_dev(card->host), "%s: data error %d\n",
> >                                                 __func__, data.error);
> > +               memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> 
> It looks like we should do this memcpy, no matter whether we get an
> error response or not.
> 
> In other words, I suggest you move the existing
> "memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));" from a
> couple of lines further done in the code, up to immediately after we
> have called mmc_wait_for_req(). That should make it more clear as
> well, I think.
> 
I agree. I Have sent the updated version of the patch with this change.
Kindly review the same as well.

Thanks for the comment and review.

Regards,
Nishad
> >                 return data.error;
> >         }
> >
> > --
> > 2.17.1
> >
> 
> Kind regards
> Uffe
