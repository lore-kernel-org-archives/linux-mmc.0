Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8CDCE7A88
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Sep 2023 08:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjIWING (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 23 Sep 2023 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIWING (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Sep 2023 04:13:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C23197
        for <linux-mmc@vger.kernel.org>; Sat, 23 Sep 2023 01:12:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50437c618b4so3212462e87.2
        for <linux-mmc@vger.kernel.org>; Sat, 23 Sep 2023 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695456777; x=1696061577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bi321A2drNy6nknQTf7dQWZFXj5dHMNZIqg1+SAX5s=;
        b=Eb6muA52t84np1PtJvHMCmyqpxUZXUNe5EBOLvbBqfSO/FjQ68Y7YWamoD/Azed3ka
         xDSLcdmEZkKx8UanBZV+hIVuYCX3nZ/NxQVBsJdrSrV6OXkwh4KsgG11tAsO+GwDYWq6
         9JD1VCPmS2F680El6cBO+cN8RHG06TDFNmc6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695456777; x=1696061577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bi321A2drNy6nknQTf7dQWZFXj5dHMNZIqg1+SAX5s=;
        b=kYr0BD8WPKAESRRkUNa///L4hkULue9OVh97Rt6aHgHbbtm9SaFBJSh5ATDtgm8rUe
         b/208EP42jmFsrrisdbgt9N46xT5c+5WIsOOz9meGO9AaH02q1NsbV1X7fcaQ4olO4Pt
         Nwj0MpY1o8cT1i0D+7ddDCf876n4ipWn8M1628hUe7PsZR32LYfwwtPiaIW6q1bIacVB
         tmZHyc8KJiEIPv9uGiQzjG+jKIIJnsVX44l7znPUdGmzjYH0360vYI7sgR/HAawcDD5S
         Ixo/hiaC5+JsNJjmb7FMV+zD5bz3ffja0OXK5OTJKUVhsDmwBQ101oBMcjykv7OCDn3w
         h17g==
X-Gm-Message-State: AOJu0YzFyUOiI/KbmPYqNn9D/meHogMvmqK6ic0nRCt76sSf0VqUVjC0
        YaQMRC1wAE0oG7rOT79bG6c6w4bs1WqleqfDvwF5Eg==
X-Google-Smtp-Source: AGHT+IECnxMKCUchTTGpBiZNHPiRxbAjTm5HGeILQHbyVOU3vKKeQJn06Lqp7XA7vJmj2YNE+ycen3IpeXS+HSyxN2o=
X-Received: by 2002:a19:5002:0:b0:4f8:77db:1d9e with SMTP id
 e2-20020a195002000000b004f877db1d9emr1402093lfb.12.1695456777524; Sat, 23 Sep
 2023 01:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230922095348.22182-1-pablo.sun@mediatek.com>
In-Reply-To: <20230922095348.22182-1-pablo.sun@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Sat, 23 Sep 2023 16:12:46 +0800
Message-ID: <CAGXv+5Hi2dem-d-EfAJjGkeb1aPnYBWjgVgyHdgp-RJAV=gRcQ@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw
To:     Pablo Sun <pablo.sun@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 22, 2023 at 6:05=E2=80=AFPM Pablo Sun <pablo.sun@mediatek.com> =
wrote:
>
> Use atomic readl_poll_timeout_atomic, because msdc_reset_hw
> may be invoked in IRQ handler in the following context:
>
>   msdc_irq() -> msdc_cmd_done() -> msdc_reset_hw()
>
> The following kernel BUG stack trace can be observed on
> Genio 1200 EVK after initializing MSDC1 hardware during kernel boot:
>
> [    1.187441] BUG: scheduling while atomic: swapper/0/0/0x00010002
> [    1.189157] Modules linked in:
> [    1.204633] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         =
5.15.42-mtk+modified #1
> [    1.205713] Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
> [    1.206484] Call trace:
> [    1.206796]  dump_backtrace+0x0/0x1ac
> [    1.207266]  show_stack+0x24/0x30
> [    1.207692]  dump_stack_lvl+0x68/0x84
> [    1.208162]  dump_stack+0x1c/0x38
> [    1.208587]  __schedule_bug+0x68/0x80
> [    1.209056]  __schedule+0x6ec/0x7c0
> [    1.209502]  schedule+0x7c/0x110
> [    1.209915]  schedule_hrtimeout_range_clock+0xc4/0x1f0
> [    1.210569]  schedule_hrtimeout_range+0x20/0x30
> [    1.211148]  usleep_range_state+0x84/0xc0
> [    1.211661]  msdc_reset_hw+0xc8/0x1b0
> [    1.212134]  msdc_cmd_done.isra.0+0x4ac/0x5f0
> [    1.212693]  msdc_irq+0x104/0x2d4
> [    1.213121]  __handle_irq_event_percpu+0x68/0x280
> [    1.213725]  handle_irq_event+0x70/0x15c
> [    1.214230]  handle_fasteoi_irq+0xb0/0x1a4
> [    1.214755]  handle_domain_irq+0x6c/0x9c
> [    1.215260]  gic_handle_irq+0xc4/0x180
> [    1.215741]  call_on_irq_stack+0x2c/0x54
> [    1.216245]  do_interrupt_handler+0x5c/0x70
> [    1.216782]  el1_interrupt+0x30/0x80
> [    1.217242]  el1h_64_irq_handler+0x1c/0x2c
> [    1.217769]  el1h_64_irq+0x78/0x7c
> [    1.218206]  cpuidle_enter_state+0xc8/0x600
> [    1.218744]  cpuidle_enter+0x44/0x5c
> [    1.219205]  do_idle+0x224/0x2d0
> [    1.219624]  cpu_startup_entry+0x30/0x80
> [    1.220129]  rest_init+0x108/0x134
> [    1.220568]  arch_call_rest_init+0x1c/0x28
> [    1.221094]  start_kernel+0x6c0/0x700
> [    1.221564]  __primary_switched+0xc0/0xc8
>
> Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open=
-coded polling")
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
