Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB9EC61DA4
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Feb 2023 14:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjBIOUH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjBIOUG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2023 09:20:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72818D52C
        for <linux-mmc@vger.kernel.org>; Thu,  9 Feb 2023 06:20:05 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso6431043pju.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2023 06:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYxLu340buDorPsnl43T9otOxhgPq97W7VjPZKGZ/u8=;
        b=Rh5AjpMoSBz0DdXj0euUeVu/fR++6R0wMIaakn0Qp5gdt8OHVnrPYwdfgjfHFUGavc
         3N+n/TyRUXIMtxU1m12nnWa9ikR/bpKeY0/OvSpS2vaMVVnmLnRTAFP+3YnWkX7qrgcV
         kCJ+WgGKg42/+ebjLRlME1S6wKQ6XN9Q4bsdedCGLYucaY5j3ffcD5ljdxwZrAGOad/l
         XNKrHWgcwiDw7b9YRedaueLCQXq40FzRVjcTgo/08cLQWHi4jCtktElsdlZpC5z0AZSA
         Gw2VLkyna6O+L8hFUkQe4F782ygZmVhFum7IapD5DnXLLDm4BqjOeBomQNQv2r9A9/sM
         jjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYxLu340buDorPsnl43T9otOxhgPq97W7VjPZKGZ/u8=;
        b=hXGTP6BJigJplv0gUILbt1vx/HKhK/AgdHWdU1ooRwQJhRwLheRblh7fS4aV7VVDdf
         eiA0bHeUqK9xLOWW9soHDnIyv8+O7qsxmfLPM5OYAavcQ+a0klxfA8Sow8/MatgAKBDM
         Y05j6i9mJrjP8YnlPvyWuWgX2SKVSeRtH9228xHdpwET+ANJDohuQC/ZcMA15HzCJvLU
         XQJ0wihlYKCHCr8mmYsP0h1Aoyj+KLc6psTPcRVGk80T4/I1h2yvEZ8bqczv9QDlU6Uk
         n9469FcAmHnST0MNQvxBMIC2VlkCGTLo/+qTAT9G8AW150lKr7ELMO3NtEMEG8IleGyC
         WBbg==
X-Gm-Message-State: AO0yUKVhvzN+CrGx2S03JltFqRScWXyilfqtSO11Bs5vKJPgVueM+3V1
        zpyUD98jESPOE41V1i4mJlqW7Mf1ElAnl7RSvmGTpA==
X-Google-Smtp-Source: AK7set85JKFXYS5OVrZOHnhlsF+UlNYz+NBQNJLlOqK8A5eLbbcJpNUPRLbWB7cN0D4oqya5Kak4Vvu9a57zgrGdooc=
X-Received: by 2002:a17:90a:ad85:b0:230:d1d5:2041 with SMTP id
 s5-20020a17090aad8500b00230d1d52041mr1823137pjq.109.1675952404960; Thu, 09
 Feb 2023 06:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20221216161625.2924013-1-sean.anderson@seco.com>
In-Reply-To: <20221216161625.2924013-1-sean.anderson@seco.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Feb 2023 15:19:28 +0100
Message-ID: <CAPDyKFpz8Cwo5XnDzj6RAaqwSWGg-OER_44DKUO+kABaXcJWiQ@mail.gmail.com>
Subject: Re: [PATCH] Add a command to write extcsd registers
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org,
        Philippe Reynes <philippe.reynes@sagemcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Dec 2022 at 17:16, Sean Anderson <sean.anderson@seco.com> wrote:
>
> There is a command to read the extcsd and some commands to configure
> particular features, but no generic write extcsd command. Such a command
> may be useful for not-yet-supported features and manufacturer-specific
> registers.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@sagemcom.com>
> [ rebased onto latest master and updated commit message ]
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>
>  mmc.c      |  5 +++++
>  mmc_cmds.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/mmc.c b/mmc.c
> index adcd814..b9aa478 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -58,6 +58,11 @@ static struct Command commands[] = {
>                 "Print extcsd data from <device>.",
>           NULL
>         },
> +       { do_write_extcsd, 3,
> +         "extcsd write", "<offset> <value> <device>\n"
> +                 "Write <value> at offset <offset> to <device>'s extcsd.",
> +         NULL
> +       },
>         { do_writeprotect_boot_get, -1,
>           "writeprotect boot get", "<device>\n"
>                 "Print the boot partitions write protect status for <device>.",
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index e6d3273..33b9e43 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1982,6 +1982,38 @@ out_free:
>         return ret;
>  }
>
> +int do_write_extcsd(int nargs, char **argv)
> +{
> +       int fd, ret;
> +       int offset, value;
> +       char *device;
> +
> +       if (nargs != 4) {
> +               fprintf(stderr, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +
> +       offset = strtol(argv[1], NULL, 0);
> +       value  = strtol(argv[2], NULL, 0);
> +       device = argv[3];
> +
> +       fd = open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret = write_extcsd_value(fd, offset, value, 0);
> +       if (ret) {
> +               fprintf(stderr,
> +                       "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
> +                       value, offset, device);
> +               exit(1);
> +       }
> +
> +       return ret;
> +}
> +
>  int do_sanitize(int nargs, char **argv)
>  {
>         int fd, ret;
> --
> 2.35.1.1320.gc452695387.dirty
>
