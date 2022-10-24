Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88309ECAAA1
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 18:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiJXSas (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiJXSaJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 14:30:09 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845ECE319B
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:11:47 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so3973224fac.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB0JKxp8MbZDKAWPrxwwA9Mz/79E9kT4EHntrssGmlw=;
        b=vqvczCPd3k4BU9YjEUbTUNkGMN9nO65F8OMWMQosSK/NDVlA74sR5lNmYYAW0Xiowe
         IETHHRS1JAJ2GcznbWX1VsIfgwnNoDZFTgo+v/A/FBI0PTKgIgFnJaND4km/zJC+tdRc
         7xQzLXOSvYwQ3MUWUM+w48XdZFov8EitOOFEnY2noEK2CNOie/yk5gwQwlf+dIlx0KW9
         LHklPZ7S20fgtiA+keQhYIYITRrGlGrXLeCQApTY0UR/cDOIPzqJMg5bX8fekjzudV3U
         XwZTYkfeNHys8g7q8w33RsUK+0NsBkRR856jMGyLTRasLVTmvBfzTjRmttTmsC9lcsE+
         fdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB0JKxp8MbZDKAWPrxwwA9Mz/79E9kT4EHntrssGmlw=;
        b=L7tgyTJH1kUuBDVTE0sTYfTiEPWpz2yvvJswp67yqpndJD22Vwm7p9S5tBWNYU/RG7
         OyhzUDEcoeCRxqjKZ7+uWLmKHvc3zLW+LDtQMQrof47JYCgV9BPtsjjT9oBOZmvW3YAs
         qF3B5Esv/IFmA+1kA/jJUOWmlpNIFWsmQeIAaw9Cxh0PK9HCFeA6xSm4RstUgw7sJuq7
         x0K2g4OFXD7K0pOVaJTD+7m9ckimv4+7KgPchux9NByA5SEJ0accREm+hIoGEwg2VB9b
         geVQT6q9pNVP7HHXtobVJG1/92vZ6KbVp8VUV1dt4sbdJFiHqJWVToG+UdZsTgKuycAy
         ODog==
X-Gm-Message-State: ACrzQf1DYLKwPSPk67ZHHpioSC3w6utIdetp2FGOpGvZsyWEGzAkSkjE
        WbitjSBa2xlGlB+3m+n/gPnqPV0dgZeeEmuQ3SKndI0DqIs=
X-Google-Smtp-Source: AMsMyM5IdGZEznurte475UxL4SZkfPR0gJyYr7xHsqwyYcINsAbfD5Fm0lgpbBoBHU7df0Z+em+ekTHqtdAh0H8ukvw=
X-Received: by 2002:a17:90b:1d8b:b0:20d:30a5:499e with SMTP id
 pf11-20020a17090b1d8b00b0020d30a5499emr75673316pjb.84.1666630943810; Mon, 24
 Oct 2022 10:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <0657285aa7c64cbe89f9275fd5598345@hyperstone.com>
In-Reply-To: <0657285aa7c64cbe89f9275fd5598345@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Oct 2022 19:01:46 +0200
Message-ID: <CAPDyKFrcx0ec=LuMctXugcYYp9KwsHTSbYGfMedHb5As-_F79g@mail.gmail.com>
Subject: Re: [PATCHv3] mmc-utils: Add CMD0 softreset and preidle command
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 18 Oct 2022 at 13:58, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> CMD0 may be used to see if the hardware can handle a UHS card
> that completed the voltage switch. If a UHS card has problems
> coming back up after CMD0 your hardware may not support a hard
> reset properly.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
> -v3: Make internal cmd0 helper static
> -v2: Use macro for cmd0 argument
> Note: A previous version has been discussed as
> mmc-utils: Add softreset command for issuing CMD0 but with the addition o=
f preidle I considered this to be a different patch
>  mmc.c      | 10 ++++++++++
>  mmc.h      |  5 +++++
>  mmc_cmds.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  2 ++
>  4 files changed, 68 insertions(+)
>
> diff --git a/mmc.c b/mmc.c
> index 6c56387..50493f3 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -245,6 +245,16 @@ static struct Command commands[] =3D {
>                 "be 1.",
>         NULL
>         },
> +       { do_softreset, -1,
> +         "softreset", "<device>\n"
> +         "Issues a CMD0 softreset, e.g. for testing if hardware reset fo=
r UHS works",
> +         NULL
> +       },
> +       { do_preidle, -1,
> +         "preidle", "<device>\n"
> +         "Issues a CMD0 GO_PRE_IDLE",
> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>
> diff --git a/mmc.h b/mmc.h
> index daff62c..6511dbc 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -21,6 +21,9 @@
>  #include <linux/mmc/ioctl.h>
>
>  /* From kernel linux/mmc/mmc.h */
> +#define MMC_GO_IDLE_STATE         0   /* bc                          */
> +#define MMC_GO_IDLE_STATE_ARG          0x0
> +#define MMC_GO_PRE_IDLE_STATE_ARG      0xF0F0F0F0
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R=
1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R=
1  */
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
> @@ -226,6 +229,7 @@
>
>
>  /* From kernel linux/mmc/core.h */
> +#define MMC_RSP_NONE   0                       /* no response */
>  #define MMC_RSP_PRESENT        (1 << 0)
>  #define MMC_RSP_136    (1 << 1)                /* 136 bit response */
>  #define MMC_RSP_CRC    (1 << 2)                /* expect valid crc */
> @@ -234,6 +238,7 @@
>
>  #define MMC_CMD_AC     (0 << 5)
>  #define MMC_CMD_ADTC   (1 << 5)
> +#define MMC_CMD_BC     (2 << 5)
>
>  #define MMC_RSP_SPI_S1 (1 << 7)                /* one status byte */
>  #define MMC_RSP_SPI_BUSY (1 << 10)             /* card may send busy */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 2957aa9..5fe7c2a 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3044,3 +3044,54 @@ out:
>         close(dev_fd);
>         return ret;
>  }
> +
> +static void issue_cmd0(char *device, __u32 arg)
> +{
> +       struct mmc_ioc_cmd idata;
> +       int fd;
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.opcode =3D MMC_GO_IDLE_STATE;
> +       idata.arg =3D arg;
> +       idata.flags =3D MMC_RSP_NONE | MMC_CMD_BC;
> +
> +       /* No need to check for error, it is expected */
> +       ioctl(fd, MMC_IOC_CMD, &idata);
> +       close(fd);
> +}
> +
> +int do_softreset(int nargs, char **argv)
> +{
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc softreset </path/to/mmcblkX>\=
n");
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +       issue_cmd0(device, MMC_GO_IDLE_STATE_ARG);
> +
> +       return 0;
> +}
> +
> +int do_preidle(int nargs, char **argv)
> +{
> +       char *device;
> +
> +       if (nargs !=3D 2) {
> +               fprintf(stderr, "Usage: mmc preidle </path/to/mmcblkX>\n"=
);
> +               exit(1);
> +       }
> +
> +       device =3D argv[1];
> +       issue_cmd0(device, MMC_GO_PRE_IDLE_STATE_ARG);
> +
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 0f7c004..faab362 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -47,3 +47,5 @@ int do_read_cid(int argc, char **argv);
>  int do_read_csd(int argc, char **argv);
>  int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);
> +int do_softreset(int nargs, char **argv);
> +int do_preidle(int nargs, char **argv);
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
