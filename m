Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E74EFA373F
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 18:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJXS7b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiJXS6w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 14:58:52 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1A23AB4E
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:38:50 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id h4so8579344vsr.11
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmVzJz2iuMqGVIX00EiVrFTp5oE+uGzL9P9jj0WqgNM=;
        b=HOgKlBHNIS9dujmRmtPbyPzJo4mvKVDa2twiynhGfPnUmslNhv1vo9x2enLMupRF3e
         rkV9WWPJKhekfQWiaGdmEituKCp0ZYUyxBMk9WPNls9G0KpaAKs656B6kzqGe5EakqmX
         bCk+7YCcgzG2P4/9adCV+hMTq262aGh1k+UKaVTaDTozkNkTJnuAiCk7+HgirVG/0jmJ
         aJQpQyK/lV4hSi8FyG847CdAfXgOx/xxfpwAEmHfAbsbVm7KMKWKpqGpd+Rc3jgqRsFB
         h/zKuVWtihEEXYlF+P6GgZZTYtYitMKBus90bB4mj9mwBtZ8ETmgBpVNSobduX7JVpho
         wEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmVzJz2iuMqGVIX00EiVrFTp5oE+uGzL9P9jj0WqgNM=;
        b=sxAlIuHlLPrnsjrAEAJapNSo5nioP8PlNmBdqWrKz9BJEM4YodK4826SnehERPrEMc
         3lzdW01qMn8dDv3PjY0Hk9WYTCpfG5wLEZ0leLRSMv8C2IOSU0YCmPuOFzaabScjEDY/
         o61cPaZDvsxwuMCEOR4xPqeQbY+9uhZKuouB+A6wo1dsrRjIFw1ODipBRB/JHvahBN4D
         ZCc08pwnTGdIw3r48DFHKNYm2e64L5YElJKI1vupgqoIUMhZ5dOoxi6P+vO5xcwkA4/7
         MBkuu8/xFWGvMyTrU50VdiGJuhhnrK7Iu14T124zPqW8uDHiAqJeP3/bLqeglCPnTKUP
         9wGA==
X-Gm-Message-State: ACrzQf2w4U67e+bBIBT/fCnWdzzjlOgJrrMJJXRJTym1SKaF+htIZV9Z
        Y63Q8AwjJq7LdduJ1CzWMhX8ra+l0goku5mJ+sWcg0e66Lg=
X-Google-Smtp-Source: AMsMyM4VFUaDUhrqcQVL74OUgV4BRzisUsdH2raGf7cucZRPj850SJ1Razn+eoO5DdqbX3+39GY6AEEL51/gLa1U8gM=
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id
 j6-20020a170903024600b0017996b51ad2mr34001300plh.37.1666630940147; Mon, 24
 Oct 2022 10:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <4ddb5a5510d74645b2724d274c96ab02@hyperstone.com>
In-Reply-To: <4ddb5a5510d74645b2724d274c96ab02@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Oct 2022 19:01:43 +0200
Message-ID: <CAPDyKFryCjYu+RCeNyQs0moaZjzCH5nQYQd7QV2NeLAJzQTX5A@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] mmc-utils: Allow for custom sanitize timeout
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 15 Oct 2022 at 13:19, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Some cards with certain preconditioning require a higher timeout
> when sanitizing. Let the user set the maximum timeout.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
> -v4: Fix argument order in help text
>  mmc.c      |  2 +-
>  mmc_cmds.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mmc.c b/mmc.c
> index 6c56387..4c09b79 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -150,7 +150,7 @@ static struct Command commands[] =3D {
>           NULL
>         },
>         { do_sanitize, -1,
> -         "sanitize", "<device>\n"
> +         "sanitize", "<device> [timeout_ms]\n"
>                 "Send Sanitize command to the <device>.\nThis will delete=
 the unmapped memory region of the device.",
>           NULL
>         },
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3337ded..9e0571f 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1986,12 +1986,16 @@ int do_sanitize(int nargs, char **argv)
>  {
>         int fd, ret;
>         char *device;
> +       unsigned int timeout =3D 0;
>
> -       if (nargs !=3D 2) {
> -               fprintf(stderr, "Usage: mmc sanitize </path/to/mmcblkX>\n=
");
> +       if (nargs !=3D 2 && nargs !=3D 3) {
> +               fprintf(stderr, "Usage: mmc sanitize </path/to/mmcblkX> [=
timeout_in_ms]\n");
>                 exit(1);
>         }
>
> +       if (nargs =3D=3D 3)
> +               timeout =3D strtol(argv[2], NULL, 10);
> +
>         device =3D argv[1];
>
>         fd =3D open(device, O_RDWR);
> @@ -2000,7 +2004,7 @@ int do_sanitize(int nargs, char **argv)
>                 exit(1);
>         }
>
> -       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, 0);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, timeout=
);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         1, EXT_CSD_SANITIZE_START, device);
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
