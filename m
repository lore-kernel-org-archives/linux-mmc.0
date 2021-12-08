Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9FC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Dec 2021 10:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhLHKSM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Dec 2021 05:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhLHKSL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2021 05:18:11 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1ABC061746
        for <linux-mmc@vger.kernel.org>; Wed,  8 Dec 2021 02:14:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b1so4501527lfs.13
        for <linux-mmc@vger.kernel.org>; Wed, 08 Dec 2021 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g7Z5c7aKBZUUzga1QLAfT9e8HwYMJaeNWhpQsx7LGD8=;
        b=viPYo2dtN8sCnearjyag+x3flaK23RnbCWkekmwCQVC+jXEntgOyHp6W5BAhPuAJti
         QVc3Y4hU71q1oX33K9Ml80eKoDEgOTT+c4fwVvNoLRArmANYGwgycOfKumo3P+CgDTvF
         TiB8s89HwJUeaKmql52vs7Er8I1gnxVejYBs9ERMRUiV2BM7p1Q6VXJiWL342wK0NCLZ
         5BNZqNTjUoe3Idji5EhMNZchGbaTSbKNzL0spLR76s7QfmRDhRnirm6RkCAgxMcU9qYX
         4DZ/IpdMu3Nuwm3Y7BkHr6oZaPxjVcw98Ns/S+SuL8GgfIJ5T1F5lLvmj3Ln9toLQSmH
         FprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g7Z5c7aKBZUUzga1QLAfT9e8HwYMJaeNWhpQsx7LGD8=;
        b=z9TZX9BV0WSAAIVwxwezIoex2++8zY79orpOhYqAVfeFY2DKPSTfUkU10OU0VNfLYc
         y368fG3C8QNq65qklHjVzaNrffU2iKECxbRLkuNzWxNR96XMnYp6h8F4arQo7TOhX5Oz
         VE3W/lgYSW6hxTbWHyya4iZabWp1aw0YFLHzxGBqGh6E2y75apxOVlVJuULBdWDXEh0t
         H8nZJVbUBrEb5pa/lvNIy4l9Y2DtVOjwbCXqt70edYyWVRufnNFtbPb8CBRC3QeafyN8
         phkEcqHpWCiUdEBAfXD0n/62CcVqKLpn8VyuCwj/AQBa/B1LEbU+Uwu5Vthm0pBaF7a5
         qE/g==
X-Gm-Message-State: AOAM5318Y2i0zfUVzLenzpnvJVpLPxKI2iryO9Ir4qAE0ovM+xda/eI2
        RVlyIMzgXyUSXDWRA562gjXn6Y1V01f9Dl9dFhVaNw==
X-Google-Smtp-Source: ABdhPJzTHvcUYv6SqoQDTlr46wOIW5wwA3in3uWwt1y4o14KtU3b/Dn28K/7HNn/LRB9lzjW6jQGeUdGvJ/cCGBy07k=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr47078910lfg.184.1638958478064;
 Wed, 08 Dec 2021 02:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20211202161910.3944640-1-quentin.schulz@theobroma-systems.com>
In-Reply-To: <20211202161910.3944640-1-quentin.schulz@theobroma-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Dec 2021 11:14:01 +0100
Message-ID: <CAPDyKFoVyqR6h6oy7uhCfReQKk3_ErQF9iBG6bwDrxzSAY2HPg@mail.gmail.com>
Subject: Re: [PATCH] mmc_cmds: add HS400 data rates
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org, Quentin Schulz <foss+kernel@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Thu, 2 Dec 2021 at 17:19, Quentin Schulz
<quentin.schulz@theobroma-systems.com> wrote:
>
> JEDEC 5.1 JESD84-B50.1 DEVICE_TYPE [196] specifies that bit 6 is for
> "HS400 Dual Data Rate e=E2=80=A2MMC at 200 MHz =E2=80=93 1.8 V I/O" and b=
it 7 for
> "HS400 Dual Data Rate e=E2=80=A2MMC at 200 MHz =E2=80=93 1.2 V I/O" so le=
t's add those.
>
> Cc: Quentin Schulz <foss+kernel@0leil.net>

Future wise, please don't use this to cc yourself another email. No
need to resend this time.

> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Even if the patch is trivial and looks good to me, I have added Avri
who helps to maintain mmc-utils, to make sure there are no objections.

Kind regards
Uffe

> ---
>  mmc_cmds.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 73bd32a..769e317 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1613,6 +1613,8 @@ int do_read_extcsd(int nargs, char **argv)
>         /* DEVICE_TYPE in A45, CARD_TYPE in A441 */
>         reg =3D ext_csd[196];
>         printf("Card Type [CARD_TYPE: 0x%02x]\n", reg);
> +       if (reg & 0x80) printf(" HS400 Dual Data Rate eMMC @200MHz 1.2VI/=
O\n");
> +       if (reg & 0x40) printf(" HS400 Dual Data Rate eMMC @200MHz 1.8VI/=
O\n");
>         if (reg & 0x20) printf(" HS200 Single Data Rate eMMC @200MHz 1.2V=
I/O\n");
>         if (reg & 0x10) printf(" HS200 Single Data Rate eMMC @200MHz 1.8V=
I/O\n");
>         if (reg & 0x08) printf(" HS Dual Data Rate eMMC @52MHz 1.2VI/O\n"=
);
> --
> 2.33.1
>
