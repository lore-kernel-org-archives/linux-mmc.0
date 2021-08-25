Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF6C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F22610E9
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhHYJYD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhHYJYD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 05:24:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8BBC061757
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 02:23:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so51520249lfu.5
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mBOqCYg27C+Q3PwzWEuLJVfKyp+8yvqYMrIfXGs11Y=;
        b=Q3dBHeTYIwOwbucgFfK8d9ASkbm5rUi/+Q3HIhoDBdZRxgxwcl5DQYHiRyEw0yz+L9
         xDjG4W7m4tyF94ME495jyig90RGY9HyGZbM08EiWsZgTBht3FbFFLQyu1+sJmJvDiI/v
         YRivpud8KxHvJujh0IanKUwf29KCOXOSCUbJMqUkyF5Qbm9kAfKtUQAv8KmT02TqLwGk
         35TPQazsrUZrgUVeHOTdMST9/IaRPkqVe4OvRigevo/msDJlDTDp+GfkXFciJLzJ3D81
         D6EZxKoewbjY7Iwd6wUY37M3GdoAyQo69W2Czf6YTNlmzWRfM5cOd81PUCjHzVBd8Ln3
         Pfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mBOqCYg27C+Q3PwzWEuLJVfKyp+8yvqYMrIfXGs11Y=;
        b=k5NEfRk3JEmlaU1B6kdnK77EMutNcBEm6r2MWs1gs82nNjm28fthK5OarNxORQTkf9
         k16/UJK4/PMsND1eJnGm9epvNKXxvWgVjyI3nnWWZM688ccQbFscVYweeWj1hj/ZIkzx
         5ZOTySr6C/Yqx++8I6e125vNup8+IusR1oOP/QljogCwDGte5CxU75v1S4W300TGSO6r
         QQJhXWcBYJb53jIzUBzaamzOrEwTGKEyNjvAuue005vwebOFWAEp6FmfQpcuOGn4/hVt
         s+/16yHaZsccqXvkHFzksLjP4vgBL8O8In/f4imQg9d8PQ7zoibwUgl3zLjd9BSpGcPg
         gxEw==
X-Gm-Message-State: AOAM530zlEEEAFLmo+nTTfB2o315dEXJOKvLBPPypHukbJh+mfyNOwV+
        N/qRMdLuqquF7xJD8yuvw5q2YUh/XB5l2WwHE4w4/Q==
X-Google-Smtp-Source: ABdhPJwtIrWET1bt7B4ArznEl9kTzyGS0PiR0P8t0Ut+6kLg1OrcDqwcMQk5ozsVErbwqUuSMbO8oPb3K62k4CjlIho=
X-Received: by 2002:a19:655e:: with SMTP id c30mr4982752lfj.142.1629883396160;
 Wed, 25 Aug 2021 02:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210824191726.8296-1-nishadkamdar@gmail.com>
In-Reply-To: <20210824191726.8296-1-nishadkamdar@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Aug 2021 11:22:40 +0200
Message-ID: <CAPDyKFq0+FBpa+VrQm+Q511EPrDvK8cwhi3xFsxpbS4Opn0G8A@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: Return correct emmc response in case of
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

On Tue, 24 Aug 2021 at 21:17, Nishad Kamdar <nishadkamdar@gmail.com> wrote:
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
> Hence, this memcpy is required whether we get an error response or not.
> Therefor it is moved up from the current position up to immediately
> after we have called mmc_wait_for_req().
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

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
>   - Moved the existing
>     "memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));"
>     from a couple of lines further down in the code, up to
>     immediately after we have called mmc_wait_for_req().
>   - Modified the commit message to explain this change
> Changes in v3:
>   - Shorten the commit message to include only CMD17 related
>     code and test.
> Changes in v2:
>   - Make commit message clearer by adding test cases as outputs.
>
>  drivers/mmc/core/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672cc505ce378..94bb8b4cd6a4e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -557,6 +557,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                 return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
>
>         mmc_wait_for_req(card->host, &mrq);
> +       memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>
>         if (cmd.error) {
>                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
> @@ -606,8 +607,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
>
> -       memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
> -
>         if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
>                 /*
>                  * Ensure RPMB/R1B command has completed by polling CMD13
> --
> 2.17.1
>
