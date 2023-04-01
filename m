Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B75C76196
	for <linux-mmc@archiver.kernel.org>; Sat,  1 Apr 2023 06:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjDAGjn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 1 Apr 2023 02:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjDAGj1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Apr 2023 02:39:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DB022E90
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 23:39:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e18so24468108wra.9
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680331138; x=1682923138;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IP3YZrItzmO15YSK/r35tLw8WrQL+MKYAPSOOfcq8I=;
        b=ifFse0nNfp5BRz3tR9TkNPjGRfn6HsRbd15NY4U2tKcwKFw74sQF8YPnpPCd6mTzAx
         I1CJUKdsVcyDkCyxAhTtdaCg+TihCvi/WZIHG000TN0SbG1Wc3vigI4G3DNKNpDeWEq5
         6zQ0iNk5t0W8i5vvq6GwXKwxtM/Puvb6My7JC8zpDsUbmr/W97D4qciqalGxsrBq6e0g
         EE/Ea7KLLre9+ggsOp/3r14rxdIsD8Brigc5KnJ2MU6IQPZEUuRN1ITZZsJbDNU/atjn
         t2EzuU0q9Twc7ApPjn/u8xoX3w4xQ1uHs44r7rqO/HoDtiMtUox01/K5FFAGUDKwVEwD
         x2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680331138; x=1682923138;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IP3YZrItzmO15YSK/r35tLw8WrQL+MKYAPSOOfcq8I=;
        b=6aiPFxUyTahbdIZWxGauKp7X6Xe5Zx1A2L70PWN0pCXl5h64a9f0ENEl0cysdF1Oir
         xvk8bOC3MXGbGCK6/8L3xw43K8vf83YX/xoRmA1NJOhk28FmCV2hKWEJmcxbPCimgcs+
         vvA3wDNpMT1z57SWyXnTmUI6nr8ZFmBFvvUYAtQM1CEQeGPpLMMcpDKU67csv+LNqrvT
         x5Ak7M06P1utis/52aNZP9DkbZRjhHtqdk3ZdT1r/JbtJZhjRB+/sH81rYbOJQ262A30
         dP0V1vk6u61lx4SW3akBiCXVL2BhfwsVib+fedk+35aifwUmpUtHnD9WPYR/NHK8DuCT
         +5Qw==
X-Gm-Message-State: AAQBX9fnJj5mfB/NSWe1jWxlK+8x4SIHplc+PbTjPt7UP9NPllPgMv+p
        Wd55IKDZQ6/IKWUqmDZB0BJrucZyFHvtC5a+
X-Google-Smtp-Source: AKy350bIMAlwzPoXE4zO1lQXdaXdXNtPM0DmXuw8VPTqJVBpTH3cca8zm64MOog5BajlDwS55hxvPA==
X-Received: by 2002:a5d:4d03:0:b0:2da:f0b5:2595 with SMTP id z3-20020a5d4d03000000b002daf0b52595mr22627795wrt.0.1680331137643;
        Fri, 31 Mar 2023 23:38:57 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bca52000000b003ee44b2effasm4984994wml.12.2023.03.31.23.38.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Mar 2023 23:38:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH RFC 02/13] mmc: meson-gx: fix deferred probing
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20211223171202.8224-3-s.shtylyov@omp.ru>
Date:   Sat, 1 Apr 2023 10:38:53 +0400
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        MMC <linux-mmc@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        AML <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E930ABF-DA2A-4BB0-A2A2-56495305118D@gmail.com>
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-3-s.shtylyov@omp.ru>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> On 23 Dec 2021, at 9:11 pm, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>=20
> The driver overrides the error codes and IRQ0 returned by =
platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the =
probe
> permanently instead of the deferred probing. Switch to propagating the =
error
> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so =
we now
> can safely ignore it...
>=20
> Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error =
checking
> ")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> drivers/mmc/host/meson-gx-mmc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/meson-gx-mmc.c =
b/drivers/mmc/host/meson-gx-mmc.c
> index 8f36536cb1b6..c765653ee4d0 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1182,8 +1182,8 @@ static int meson_mmc_probe(struct =
platform_device *pdev)
> 	}
>=20
> 	host->irq =3D platform_get_irq(pdev, 0);
> -	if (host->irq <=3D 0) {
> -		ret =3D -EINVAL;
> +	if (host->irq < 0) {
> +		ret =3D host->irq;
> 		goto free_host;
> 	}
>=20

Can I ask if this patch/series [0] has been superseded or forgotten or =
??

The series it depended upon [1] appears to have been merged a year ago =
as I
can see ce753ad1549c ("platform: finally disallow IRQ0 in =
platform_get_irq()
and its ilk=E2=80=9D) in upstream code. I=E2=80=99ve had this patch in =
my testing kernel for
12+ months now with no observable negative impacts so am wondering if it =
can
be resent and merged or I should drop the patch from my tree?

Thx. Christian

[0] https://www.spinics.net/lists/linux-mmc/msg68102.html
[1] https://marc.info/?l=3Dlinux-kernel&m=3D163623041902285

