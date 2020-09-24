Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF9C2D0E2
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA2A2311A
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OGaeaq59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgIXRBn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRBn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 13:01:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F57C0613D4
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 10:01:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j7so37406plk.11
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wai6nrMcHMtaGESKTBMiyp6BzMJao/GERxFZZ1c+mrw=;
        b=OGaeaq59Tt/XijT63cFNXsWFUc7pRwS0n/R2QRbOGJnV7bvG3CXlKdq5J2kzaa78ME
         jbn6h+cKePv+nZUfj0dYZ/naRD1fpMeky67EjyNkTg//e+k2ICFEfpU8OpvLHodqmlsc
         e6Ly9/IjuYRLIh38hb9NRmaTWGZNwKnUqdSJcvhAoqJ+bkDsOq9MIKX2VARxrCjwg0q4
         3ou7RuM3Gjr8Xlz90Nu7tGCgohzhEADNN4nastiusrywUCf0Vc2eGX41ssiAock84bPQ
         FN7QmWmVC1S0RrKu5AL4uq0oDrScIks1DNrv6FZkIz5O5Zw4cWRsea78whS2daP/WxbN
         ZByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wai6nrMcHMtaGESKTBMiyp6BzMJao/GERxFZZ1c+mrw=;
        b=CHm+ejvjvuYOfY1693Wlzk4iQK6l7bpjHjs7T5fmVon+m8nIuHMRZ9PcKag5teyopS
         RrF7ZrZcT44nSTzwUlnYiorjTAnT8NRK3WSHFnyBXW0wmrMqlWqnbqdEPDArUoZmaNeo
         6v3/WQ0i5+D3WI0alJR0kARc5X2OIjTe7kQoMfFIGykjHO40zbIAdaJL59Z8ItdYZ/31
         L5owHBqiWaUUyA5bOmldxxM/BRIgQoaTBgfCxjGbY+2WXlSPTsxBMleoUwXQTosyr0ic
         CIDzP/biaiuLh2K97SUWoubjbJuJH6nM3jTAnyTitiNfkQ7wf5wEwLmTKVvqLsWxtRT3
         xjuQ==
X-Gm-Message-State: AOAM530saCD+mMm+gJLDtZIu2xFWVVVgwIRS7qDHaZVYWJIiY85dKTpm
        IZA+CLC+ARDRm+to0PXgpd+s9w==
X-Google-Smtp-Source: ABdhPJyB4E6oTZ+1qw0qVBGbrUxEy2hRIRjCoD2OsburrUv+ugcG2SoS9sHIe6Pl0ettoc5fKwLfFg==
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr102859pjt.163.1600966902382;
        Thu, 24 Sep 2020 10:01:42 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y13sm51996pfr.141.2020.09.24.10.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 10:01:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition for preempt_rt
In-Reply-To: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com>
References: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com>
Date:   Thu, 24 Sep 2020 10:01:41 -0700
Message-ID: <7hk0wj9ki2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Brad,

Brad Harper <bjharper@gmail.com> writes:

> Force threaded interrupts for meson_mmc_irq to prevent possible deadlock=
=20
> condition
> during mmc operations when using preempt_rt with 5.9.0-rc3-rt3 patches=20
> on arm64.
>
> Using meson-gx-mmc with an emmc device on Hardkernel Odroid N2+=20
> configured with
> preempt_rt resulted in the soc becoming unresponsive.=C2=A0 With lock=20
> checking enabled
> the below inconsistent lock state was observed during boot.
>
> After some discussions with tglx in IRC #linux-rt the attached patch was=
=20
> suggested
> to remove IRQF_ONESHOT from request_threaded_irq.
> This has been tested and confirmed by me to resolve both the=20
> unresponsive soc and
> the inconsistent lock state warning when using 5.9.0-rc3-rt3 on arm64=20
> Odroid N2+.
>
> Further review and testing is required to ensure there are no adverse=20
> impacts or
> concerns and that is the correct method to resolve the problem.=C2=A0 I w=
ill=20
> continue
> to test on various amlogic devices with both standard mainline low=20
> latency kernel
> and preempt_rt kernel with -rt patches.

This looks right to me, thanks for sending a fix.

For broader testing, I can add this to my testing branch so it gets
booted on a bunch more platform in KernelCI also.

However...

[...]

> Signed-off-by: Brad Harper <bjharper@gmail.com>
> ---
>  =C2=A0drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c=20
> b/drivers/mmc/host/meson-gx-mmc.c
> index 08a3b1c05..130ac134d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1139,7 +1139,7 @@ static int meson_mmc_probe(struct platform_device=20
> *pdev)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 host->regs + SD_EMMC_IRQ_EN);
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D request_threaded_irq(=
host->irq, meson_mmc_irq,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_mmc_irq_thread, I=
RQF_ONESHOT,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_mmc_irq_thread, 0,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&pdev->d=
ev), host);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err_init_clk;

This patch has been mangled by your mailer, so it doesn't apply cleanly.
If you're using the gmail web UI, this is a common problem.

I strongly recommend using git-send-email to send directly via gmail
SMTP.  The git-send-email docs[1] give some examples on how to set this
up.

Kevin

[1] https://git-scm.com/docs/git-send-email#_examples
