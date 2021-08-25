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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4DC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 05:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507B6610FD
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 05:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhHYFhk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 01:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhHYFhk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 01:37:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3BCC061757;
        Tue, 24 Aug 2021 22:36:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so21980849pgf.5;
        Tue, 24 Aug 2021 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/MqU0erBadK6WTzUD4+anbam3g4wT0ApTC5fiHceJE=;
        b=hNHWFAj0QuF4P8zQvHx7AzyTgD+WubCFaNo48O5eq/bq1N9pq0hTCOhIE8a8u+agFt
         I9obgm3NTtjySA/3EanVcDUQQ3vhdRZ0FkxaPRPvnzMdBiIWGbV80fs9YYISTXYpuDcp
         jc5YF7XebZIesjyZ1CEnll9i0sV4cLH5lE9TQvWSrXP6FoOUKHgaB3jZElWF7VpLATKA
         tGinbv5nMmhc7DaxcfDEA0tCKbm+w0HZKedZldrEuEUh7O5A7RqkLkDQ27q7NZmFELBv
         U46UpSJrpwE9hKyffPMIePQupJhbW1fOHN53oReiJ9FEy39JjcOf20D3Y6zzdIzRlYDk
         ocyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/MqU0erBadK6WTzUD4+anbam3g4wT0ApTC5fiHceJE=;
        b=A1fLXIFoAuCkZMQSdNdfPvJQUvHELWe2XPHAb5Q5e2Bk4Mu9dEA4HnqKM77NG7q3az
         CTO6G2pFFWojfAGsEw4hCa3WlzdA8vQW7b5IFtjM4RbqPGz0Y2uzZlly5gncH7bzVwl/
         fG9ZU+sExsoWwoCrO3nP6fuDicl6LLk9EMPnPYDhJr15sfTb6tYVUNSqw+vUtvlJX3mw
         /f3u0mLXSB/4XAoG3sCg+Rn/dPFTIjX8QLzp+Fv5wL2gaJnBp2CAb8REosEkmhHArVPw
         jbI29AA+QrIkBXLDJHOWw+QZHg1TXL67LLSOe4TAq58+FbesbJRaD/nrhrext/kAN1NH
         ABeg==
X-Gm-Message-State: AOAM531swbrtf7W+1QJo5YD8IOfNlX3iC/3M/X8wNYkbP5Euy3aeRHcy
        dB/va7jLtbMYOEmrH9c269c=
X-Google-Smtp-Source: ABdhPJxevBUFecuFr0DnnG96VDA8pCure0g/A0ZfVeo2z0LqQqus9soZOofU2MicOofnxnx9HaWiCw==
X-Received: by 2002:a63:5848:: with SMTP id i8mr18703030pgm.135.1629869814367;
        Tue, 24 Aug 2021 22:36:54 -0700 (PDT)
Received: from nishad ([106.51.233.109])
        by smtp.gmail.com with ESMTPSA id m28sm25186911pgl.9.2021.08.24.22.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Aug 2021 22:36:53 -0700 (PDT)
Date:   Wed, 25 Aug 2021 11:06:46 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: core: Return correct emmc response in case of
 ioctl error
Message-ID: <20210825053644.GA2869@nishad>
References: <20210808172448.4641-1-nishadkamdar@gmail.com>
 <DM6PR04MB6575FA52433A1A3C7F89453BFCF69@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6575FA52433A1A3C7F89453BFCF69@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 09, 2021 at 08:41:19AM +0000, Avri Altman wrote:
> > When a read/write command is sent via ioctl to the kernel,
> > and the command fails, the actual error response of the emmc
> > is not sent to the user.
> > 
> > Following are the tests carried out using commands
> > 17 (Single BLock Read),
> > 24 (Single Block Write),
> > 18 (Multi Block Read),
> > 25 (Multi Block Write)
> > 
> > The tests are carried out on a 64Gb emmc device. All of these
> > tests try to access an "out of range" sector address (0x09B2FFFF).
> > 
> > It is seen that without the patch the response received by the user
> > is not OUT_OF_RANGE error (R1 response 31st bit is not set) as per
> > JEDEC specification. After applying the patch proper response is seen.
> > 
> > The user level ioctl testcode for the above commands and their
> > respective outputs without and with the patch are shown below:
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
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17 09B2FFFF
> No need for arg 3 - you are hardcoded overriding it.
> 
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17,
> > 0x09B2FFF]
> > Forming CMD17
> > Sending CMD17: ARG[0x09b2ffff]
> > Error: Connection timed out
> > 
> > Response: 00000000  (Wrong response)
> > 
> > CMD17 (Output with patch):
> > ==========================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17 09B2FFFF
> > [sudo] password for test:
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 09B2FFFF]
> > Forming CMD17
> > Sending CMD17: ARG[0x09b2ffff]
> > Error: Connection timed out
> > 
> > Response: 80000900
> > (Correct OUT_OF_ERROR response as per JEDEC specification)
> 
> 
> > 
> > CMD24 (Test Code Snippet):
> > ==========================
> >         printf("Forming CMD%d\n", opt_idx);
> >         cmd.opcode = 24;
> >         //cmd.arg = atoi(argv[3]);
> >         cmd.arg = 0x09B2FFFF;
> >         cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> >         cmd.blksz = 512;
> >         cmd.blocks = 1;
> >         cmd.write_flag = 1;
> > 
> >         memset(data, 0xA5, sizeof(__u8) * 512);
> >         mmc_ioc_cmd_set_data(cmd, data);
> > 
> >         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
> >         if(ioctl(fd, MMC_IOC_CMD, &cmd))
> >                 perror("Error");
> > 
> >         printf("\nResponse: %08x\n", cmd.response[0]);
> > 
> > CMD24 (Output without patch):
> > =============================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 24 0x09B2FFF
> > [sudo] password for test:
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[24,
> > 0x09B2FFF]
> > Forming CMD24
> > Sending CMD24: ARG[0x09b2ffff]
> > Error: Connection timed out
> > 
> > Response: 00000000 (Incorrect response)
> > 
> > CMD24 (Output with patch):
> > ==========================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 24 09B2FFFF
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[24, 09B2FFFF]
> > Forming CMD24
> > Sending CMD24: ARG[0x09b2ffff]
> > Error: Connection timed out
> > 
> > Response: 80000900
> > (Correct OUT_OF_RANGE response as per JEDEC specification)
> > 
> > CMD18 (Test Code Snippet):
> > ==========================
> >         printf("Forming CMD%d\n", opt_idx);
> > 
> >         cmd.blksz = 512;
> >         cmd.blocks = 1;
> >         cmd.write_flag = 0;
> >         cmd.opcode = 18;
> >         //cmd.arg = atoi(argv[3]);
> >         cmd.arg = 0x09B2FFFF;
> > 
> >         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > 
> >         memset(data, 0, sizeof(__u8) * 512);
> >         mmc_ioc_cmd_set_data(cmd, data);
> > 
> >         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
> >         if(ioctl(fd, MMC_IOC_CMD, &cmd)) {
> >                 printf(" error ioctl \n");
> >                 perror("Error");
> >         }
> > 
> >         printf("\nResponse: %08x\n", cmd.response[0]);
> > 
> > CMD18 (Output without patch):
> > =============================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 18 0x09B2FFF
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[18,
> > 0x09B2FFF]
> > Forming CMD18
> > Sending CMD18: ARG[0x09b2ffff]
> >  error ioctl
> > Error: Connection timed out
> > 
> > Response: 00000000 (Incorrect response)
> > 
> > CMD18 (Output with patch):
> > ==========================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 18 09B2FFFF
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[18, 09B2FFFF]
> > Forming CMD18
> > Sending CMD18: ARG[0x09b2ffff]
> >  error ioctl
> > Error: Connection timed out
> > 
> > Response: 80000900
> > (Correct OUT_OF_RANGE response as per JEDEC specification)
> > 
> > CMD25 (Test Code Snippet):
> > ==========================
> >         printf("Forming CMD%d\n", opt_idx);
> >         cmd.opcode = 25;
> >         //cmd.arg = atoi(argv[3]);
> >         cmd.arg = 0x09B2FFFF;
> >         cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> > 
> >         cmd.blksz = 512;
> >         cmd.blocks = 1;
> >         cmd.write_flag = 1;
> > 
> >         memset(data, 0xA5, sizeof(__u8) * 512);
> >         mmc_ioc_cmd_set_data(cmd, data);
> > 
> >         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
> >         if(ioctl(fd, MMC_IOC_CMD, &cmd)) {
> >                 printf("\nerror ioctl\n");
> >                 perror("Error");
> >         }
> > 
> >         printf("\nResponse: %08x\n", cmd.response[0]);
> > 
> > CMD25 (Output without patch):
> > =============================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 25 0x09B2FFF
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[25,
> > 0x09B2FFF]
> > Forming CMD25
> > Sending CMD25: ARG[0x09b2ffff]
> > 
> > error ioctl
> > Error: Connection timed out
> > 
> > Response: 00000000 (Incorrect response)
> > 
> > CMD25 (Output with patch):
> > ==========================
> > test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 25 09B2FFFF
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> > Entering the do_mmc_commands:Device: /dev/mmcblk0 options[25, 09B2FFFF]
> > Forming CMD25
> > Sending CMD25: ARG[0x09b2ffff]
> > 
> > error ioctl
> > Error: Connection timed out
> > 
> > Response: 80000900
> > (Correct OUT_OF_RANGE response as per JEDEC specification)
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> 
> > ---
> > Changes in v2:
> >   - Make commit message clearer by adding test cases as outputs
> A little overwhelming IMO
> 
Ok, Thanks for the review and comments.

Regards,
Nishad
> > 
> >  drivers/mmc/core/block.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index a9ad9f5fa9491..efa92aa7e2368 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -522,11 +522,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > *card, struct mmc_blk_data *md,
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
> >                 return data.error;
> >         }
> > 
> > --
> > 2.17.1
> 
