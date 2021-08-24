Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA96C4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FF061357
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 12:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhHXMqE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhHXMqE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 08:46:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A9EC061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 05:45:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o10so45259101lfr.11
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gie8TKzTCG88PuowyLmmMIyp13AaJq23WJtnBAiVf8=;
        b=c1FoAnPy8qFssF63uF/85NZ1Lv496397sCBGP+/crIbuU01fSuEAe6UsJMYa4FiyT0
         rFtlT5NmPUyPHOP6+WbSGFDe/Jtx+6P2/cdAcsNxhcoFbKWiPOVmHH43yGR5W3+4kfee
         D7oH8gCaLgJ6htGsubwDtiHkpFm8NTnxVymBr/R/yoAoQGFLr86NAbN1bXRgbSfrmJal
         M7HYt0U2r2M6T+lMEFxsHRaa3AOYYiwosidVgSA15OGkpWmkwWFF8EF9iL0qGb1gR7R6
         XvVERuGbxXP3RwWPLL/Aplt9BNTtyWi2MbtuTlbBr/fvKvC9V/Mf9hbFDzaXuybD13J+
         fdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gie8TKzTCG88PuowyLmmMIyp13AaJq23WJtnBAiVf8=;
        b=ptg+2eomzXzMIbLIArcNcyc3i9C9ueGT0JEa6uEEgG9gl7hmsoSHyDLlgqLgvOaeQL
         XaXCGcMGzT3GE6YkuCH9acCv6PH9ReuAG/E4UkqzjVFkzDrnGDbKlu1juV2n1plcEKly
         mogL1663FH3YpIq7kjjZyhF1tSM2JJTVXSeuf4jqdl6ZAiLKakp8veKLuECg6ayEUK3a
         9i1uXZft9se8Mg37TW7ueGgCqncV3ROKjNwBwopCc7VDasAtjVtmb6Ei1PFzhxSwr2Nn
         g8F7zraVz+TzF/8rWKT7htNMMcWRC96+YkICsTLjWX1eiQzfx7qMjqP2KN/++SRrWyjW
         RnPA==
X-Gm-Message-State: AOAM532bi32AonL6Xt/7XYC5kp56/OxiC/PQDr4uaCpdK11mWumzc/ML
        SLo1ouT/5tqv7bwtLxu7ehZ5e6e6VzULBn6hSU2CXg==
X-Google-Smtp-Source: ABdhPJxyj7ety9g6PGkwH7WZePRsUrUZjKH7kE2GjMwJxsb9Eh60l+DuERnR6VMKEl5nju/iLWgbb+Ic3lz/d5nzLlU=
X-Received: by 2002:a05:6512:e99:: with SMTP id bi25mr2885410lfb.486.1629809118189;
 Tue, 24 Aug 2021 05:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210812065730.3986-1-nishadkamdar@gmail.com>
In-Reply-To: <20210812065730.3986-1-nishadkamdar@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 14:44:42 +0200
Message-ID: <CAPDyKFoaXdNDvO91n3rUsqe2JMg5E7YObYDnkAW4jqzVV+GLtw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Return correct emmc response in case of
 ioctl error
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Aug 2021 at 08:57, Nishad Kamdar <nishadkamdar@gmail.com> wrote:
>
> When a read/write command is sent via ioctl to the kernel,
> and the command fails, the actual error response of the emmc
> is not sent to the user.
>
> IOCTL read/write tests are carried out using commands
> 17 (Single BLock Read), 24 (Single Block Write),
> 18 (Multi Block Read), 25 (Multi Block Write)
>
> The tests are carried out on a 64Gb emmc device. All of these
> tests try to access an "out of range" sector address (0x09B2FFFF).
>
> It is seen that without the patch the response received by the user
> is not OUT_OF_RANGE error (R1 response 31st bit is not set) as per
> JEDEC specification. After applying the patch proper response is seen.
> This is because the function returns without copying the response to
> the user in case of failure. This patch fixes the issue.
>
> The test code and the output of only the CMD17 is included in the
> commit to limit the message length.
>
> CMD17 (Test Code Snippet):
> ==========================
>         printf("Forming CMD%d\n", opt_idx);
>         /*  single block read */
>         cmd.blksz = 512;
>         cmd.blocks = 1;
>         cmd.write_flag = 0;
>         cmd.opcode = 17;
>         //cmd.arg = atoi(argv[3]);
>         cmd.arg = 0x09B2FFFF;
>         /* Expecting response R1B */
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>
>         memset(data, 0, sizeof(__u8) * 512);
>         mmc_ioc_cmd_set_data(cmd, data);
>
>         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
>         if(ioctl(fd, MMC_IOC_CMD, &cmd))
>                 perror("Error");
>
>         printf("\nResponse: %08x\n", cmd.response[0]);
>
> CMD17 (Output without patch):
> =============================
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 0x09B2FFF]
> Forming CMD17
> Sending CMD17: ARG[0x09b2ffff]
> Error: Connection timed out
>
> Response: 00000000
> (Incorrect response)
>
> CMD17 (Output with patch):
> ==========================
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
> [sudo] password for test:
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 09B2FFFF]
> Forming CMD17
> Sending CMD17: ARG[0x09b2ffff]
> Error: Connection timed out
>
> Response: 80000900
> (Correct OUT_OF_ERROR response as per JEDEC specification)
>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> ---
> Changes in v2:
>   - Make commit message clearer by adding test cases as outputs.
> Changes in v3:
>   - Shorten the commit message to include only CMD17 related
>     code and test.
>
>  drivers/mmc/core/block.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index a9ad9f5fa9491..efa92aa7e2368 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -522,11 +522,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         if (cmd.error) {
>                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
>                                                 __func__, cmd.error);
> +               memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>                 return cmd.error;
>         }
>         if (data.error) {
>                 dev_err(mmc_dev(card->host), "%s: data error %d\n",
>                                                 __func__, data.error);
> +               memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));

It looks like we should do this memcpy, no matter whether we get an
error response or not.

In other words, I suggest you move the existing
"memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));" from a
couple of lines further done in the code, up to immediately after we
have called mmc_wait_for_req(). That should make it more clear as
well, I think.

>                 return data.error;
>         }
>
> --
> 2.17.1
>

Kind regards
Uffe
