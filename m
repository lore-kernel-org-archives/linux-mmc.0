Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA8C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B9F2311D
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403768AbhAZMp5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391769AbhAZJ7L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 04:59:11 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72809C061793
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:28 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id m13so3576989vsr.2
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cMqmP92ckJOWxLFOub/+kXkPVPFprM8AhWxx6VtR/qI=;
        b=SDN9LSS4iSoL4PcI8w/6y9Vexfzx5c8cqZ18zzCYRrsk2rznZrPPtIzEGxIvY/1+CZ
         s9tQPtdSmVsVsGaBNLcdSI26raqrQLsY8Dg39gtKd6e/voK4/lyMgqR553LqdTdeL4Rm
         U1kkzfcBT0OwpVmHG4eDd/InWTU+jncR9ousiqhcNRiPgAPAOksMr+T8FyQ4lWRKjfT+
         0ncXeu7AJTQvYi8+faDFrw9MBJCjxBVIl33NXfgzdjYVTsmAJGTAp4r4kUU2V9rSNxMs
         8uYQguQ17/3rb7A7DiWO+j2XeNzIMTmQnbMLT6XCPl/zI6gLyQSV6EthY8oEbnWMADfF
         11uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cMqmP92ckJOWxLFOub/+kXkPVPFprM8AhWxx6VtR/qI=;
        b=ODeo35tmRNM/WeD12s2NRG3RZ4mlNblcQcFfkN/VnZMFeP6tfXdOlezwHVlavk8yju
         2lg4Yx9WamX29zuAZpivxXztde9oRx/cdMsvYDHiql1GZdsmXJD1U/CnMiZcXWDlV+vd
         gjjODvuMKaom+elbPC0KecSDJ7fHt8aXQELoSjINSoKek951RUyV9yZ1o/FfHZTTKkW0
         1QAm7hNyLTpen4yjFR3NNnWjHkhvk9qNRPhsbKDIEXoiBI1QDNzRUUX7EACzIMpNHRtl
         b57+0Agd/xz4bQUpF25b15z2opCnyC0R4GmZCpFZpNP+CzBDP3q+8sOUkOZdBrvOofJS
         //bg==
X-Gm-Message-State: AOAM531jp+IZxvd/AzpcpdC6FogoWrbvFAtLAGC4cfbvwXhdp9bPoxSx
        6qTpIhHwkQ5vywl3wVUGOWD+0b2nx6LeeAmLYmXV2z+3p+bX4A==
X-Google-Smtp-Source: ABdhPJy5nF+IJ+Cb5EK/VNlwIRItJcbtubjXDncYomMeI1pg1LOsvK6RTLry9ROPhlpAS3hijJ889BcE2aNH6stJuJ4=
X-Received: by 2002:a05:6102:48a:: with SMTP id n10mr3763060vsa.42.1611655107693;
 Tue, 26 Jan 2021 01:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20210123033230.36442-1-fengnanchang@gmail.com>
In-Reply-To: <20210123033230.36442-1-fengnanchang@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:57:51 +0100
Message-ID: <CAPDyKFrAVP4jstB79wJhO5LCGn1EFQKtPRkck8+QYoA8eQV9CQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: limit the number of retries when analyse tuples failed
To:     Fengnan Chang <fengnanchang@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 23 Jan 2021 at 04:32, Fengnan Chang <fengnanchang@gmail.com> wrote:
>
> when analyse tuples failed, may enter an endless loop=EF=BC=8Cso limit th=
e time of retries.
>
> Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_cis.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index dcb3dee59fa5..b8d8b6df9961 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -24,6 +24,8 @@
>  #include "sdio_cis.h"
>  #include "sdio_ops.h"
>
> +#define SDIO_READ_CIS_TIMEOUT_MS  (10 * 1000) /* 10s */
> +
>  static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
>                          const unsigned char *buf, unsigned size)
>  {
> @@ -266,6 +268,8 @@ static int sdio_read_cis(struct mmc_card *card, struc=
t sdio_func *func)
>
>         do {
>                 unsigned char tpl_code, tpl_link;
> +               unsigned long timeout =3D jiffies +
> +                       msecs_to_jiffies(SDIO_READ_CIS_TIMEOUT_MS);
>
>                 ret =3D mmc_io_rw_direct(card, 0, 0, ptr++, 0, &tpl_code)=
;
>                 if (ret)
> @@ -318,6 +322,8 @@ static int sdio_read_cis(struct mmc_card *card, struc=
t sdio_func *func)
>                         prev =3D &this->next;
>
>                         if (ret =3D=3D -ENOENT) {
> +                               if (time_after(jiffies, timeout))
> +                                       break;
>                                 /* warn about unknown tuples */
>                                 pr_warn_ratelimited("%s: queuing unknown"
>                                        " CIS tuple 0x%02x (%u bytes)\n",
> --
> 2.25.1
>
