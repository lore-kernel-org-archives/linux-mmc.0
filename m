Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A828C3DA7A
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjABNG6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 08:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjABNGx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 08:06:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483342AE3
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 05:06:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v23so29953098pju.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 05:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxZQpBhQF37lnCWIWuGMGwyxu2RKmPUq3gD5Qr21VfE=;
        b=g8qvWhY+ibYmcc9r5hJEyxidLnw6U9kmB1x6PMxBPAXCHMGeiRlhnPwE445Cen+R+5
         7vXAhIRX3WX0ipunljsvvpxBmcg6QvQ7xW+DFaXikjMIqvn3TvLcZTeHE2/NX6GBKXnS
         CmkpgQUkMIRP/QKj/AP3rFQqEUwzmb1rb3eUtS6AeCCuEG6XUdB3q2WD+oEt6ccVidYq
         930Aa/OLNMJIW2yKnsiVtIX+c1Uc6MmOYmr+z0KNraHYXFnHLpjzcdOuARl0quAc0suq
         +u+gQfuqZdh45VeI1MQ4YezqXcenHZ43YHANQ14Rvg+4lyPNQV8hWVTG+F/ExNC+QvOV
         Gosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxZQpBhQF37lnCWIWuGMGwyxu2RKmPUq3gD5Qr21VfE=;
        b=QmbyMQM0Ic94fmgZ4E1kaJ1lZNlhdwyjJUpnKCXUKtCgDLzFHKoZxnOUWGnYM7nzfa
         Q/t014QQjh1jcpopyweSZca4GkwG+U8Q/GEDhZdtzjlu5QdyaISXNxmurIcMS3H+prvz
         C2zJTZQjPU5aAbRnfVRZkxal7Ji0Kml3Q4BPcgZ/pvoijtOFa6RUAmey4B//YFgL49Rd
         Hn/sSNEiXyeQuwpMb8GBqNSJmclrYIayPPDgwAZYXwXXU/ihvdl6bTVOKODZjKhDvKJ7
         19q1hpdouZCxliI/iNgwqGVA1GAkVYs8vZpW5skqKJJ7Ic8XwDl9WIviMRE4/FP6yifL
         JqlA==
X-Gm-Message-State: AFqh2kqQOgMKe2U4z74JZV1ICYuZfWCWgE2/uV/+SQ88iTWhEt/Xrv/j
        AFnv4bv6QMFj6DOePrqUfKuDJPOXbzKwyDZZg+giWg==
X-Google-Smtp-Source: AMrXdXtuDb8u+5jRmok/u0z3ZaW1wcnDBrrluCgIHi8ue76rxMUB45n1+m5smff5Ma8SL70/Pbct7MTkc7m7pi2o5As=
X-Received: by 2002:a17:902:e053:b0:192:8d55:4599 with SMTP id
 x19-20020a170902e05300b001928d554599mr1241899plx.165.1672664810710; Mon, 02
 Jan 2023 05:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20221216161625.2924013-1-sean.anderson@seco.com>
In-Reply-To: <20221216161625.2924013-1-sean.anderson@seco.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 14:06:14 +0100
Message-ID: <CAPDyKFoKZ165m1Fy5FJAv1WWPLT488LyRHhCdzw2mLOotSaPuA@mail.gmail.com>
Subject: Re: [PATCH] Add a command to write extcsd registers
To:     Avri Altman <avri.altman@wdc.com>,
        Sean Anderson <sean.anderson@seco.com>
Cc:     linux-mmc@vger.kernel.org,
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

In a way this seems reasonable to me, while I am also a bit reluctant
to provide a too easy interface to allow the user to write any extcsd
value to the device. Note that, if these changes affect the behaviour
of the device, the kernel will not be aware of it.

Anyway, I will defer to Avri to make the call.

>
> Signed-off-by: Philippe Reynes <philippe.reynes@sagemcom.com>
> [ rebased onto latest master and updated commit message ]
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

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
