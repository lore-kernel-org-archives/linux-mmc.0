Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F3FC61DA4
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Mar 2023 14:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjCIOzg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjCIOy7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 09:54:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F1F4B56
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 06:51:56 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t22so1790755oiw.12
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678373516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpqy2UwJbTsT8CSlsBkekwaizPbfI6waBJSct+QDKo8=;
        b=7VnZ8eoq8JCRR9LWSoq6SXSKIYIRedzcewZzSE9gKx6AQQB2Ax7dwKBcAYwJrjlsWs
         4TCezR69X8MwfD4+CKaz/SObaltdvIIieLVdJ+BWlplOPFiALrUJwDgjMU47Vf51qRDl
         xdFrwA1rnPNMA0GVzeDnkpXSGfyag6vAi04knNO8VIXj+D5n+705no78/qGHcnD2tLqc
         nohnomuGXgF8COo7QbluFk8QfItIs5fLy7I2ZnAC1v81iSP6Ds1uiOBx5oP32kgrJXPW
         yTtqYLrIVGryvFjGoykGRd0Kl8dTZeGhvhFDQoCSZrB7mIPyeb5SEOWrMbUnxfz7JmgZ
         oQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gpqy2UwJbTsT8CSlsBkekwaizPbfI6waBJSct+QDKo8=;
        b=eei8xALeu9FvfgrUwAxo+tQPy7wMWnTTv/kqvEbufF2L7P3BUA97DCwsp+OK0sUU/Q
         op26+Pd3ASIm9sCqeTClYvh+a7mt43HZFIceodJ+m2NBggOfUhlutSxV+7VAttJsi0Iu
         5b9qv89g/SwckwQ06M/8Jhfl96YqzeX4dKQaxb3baDjLq+K0INvXkU84dDeJH7zdNHpq
         VBzS673arTX/do4EPSPWk8QEFXqVDmJ2yqi024gDAf2oJcZcoQweZYrlVhgtQ3Z2K9yw
         7iopzQW5feIERbfkFSEFp6gI36iWMAzjY4ON4rRogKwQWWLt1HeLiKNspKwxyHkTahs/
         8p3g==
X-Gm-Message-State: AO0yUKXdm9EwC5zb7AQr1Hq8ZDrmIJKuf6DkUSd/RyTzfxVwf8xYdB6C
        SA7w8ISE1YduoxgFAA1OZxBr8rP01ET/lrYSKPZUcg==
X-Google-Smtp-Source: AK7set8A8FpW9dqaR73G09blcvv/Ti7DIE1vGNLlncw0hLE8FnQCoXHRSlvX0YUqfVCqYXdazGxGSi3CnqOThNIO2y8=
X-Received: by 2002:a05:6808:2208:b0:37a:2bed:5756 with SMTP id
 bd8-20020a056808220800b0037a2bed5756mr12243997oib.0.1678373515531; Thu, 09
 Mar 2023 06:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com>
 <20230203-evk-board-support-v2-17-6ec7cdb10ccf@baylibre.com> <0fb37a8f-f284-76f2-e2f3-ff0f23eaa200@collabora.com>
In-Reply-To: <0fb37a8f-f284-76f2-e2f3-ff0f23eaa200@collabora.com>
From:   =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Date:   Thu, 9 Mar 2023 15:51:44 +0100
Message-ID: <CAP2ifjOtORrGKEBMw-CzPR4B8CPDaRKnqKHyKL7mC_8qH08=iA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] arm64: dts: mediatek: fix systimer properties
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 9, 2023 at 2:32=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/03/23 14:17, Alexandre Mergnat ha scritto:
> > From: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> >
> > MT8365 has a SYST timer (System Timer), therefore the compatible node
> > should be "mediatek,mt6765-timer" instead of "mediatek,mt6795-systimer"
> > (which corresponds to ARM/ARM64 System Timer).
>
> So this is not a CPUXGPT, not a GPT, but a SYST?
>
> At this point, this should not be even introduced because commit [1] is
> not in linux-next yet.
>
> [1]: https://lore.kernel.org/all/20230125143503.1015424-10-bero@baylibre.=
com/

I've posted a new revision of this patchset containing the systimer fix.

https://lore.kernel.org/linux-mediatek/20230309143459.401783-1-bero@baylibr=
e.com/

ttyl
bero
