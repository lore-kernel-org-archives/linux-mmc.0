Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECBC71153
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Aug 2023 16:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjH2Qf3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjH2QfW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2023 12:35:22 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A160198
        for <linux-mmc@vger.kernel.org>; Tue, 29 Aug 2023 09:35:20 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-573675e6b43so2121571eaf.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Aug 2023 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693326918; x=1693931718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0pWbpInDstIHBeP/BS4VOTRMTkNBmu1VJYzwpZwV48=;
        b=mfRZRWbghdgh0zjCP5AmsjeyhQDj/khco0H/tA3gxDMc0QrOgFq/kvqlvs+R9YQDuP
         XAkfzfLzsKH+qlyoeeORg3tnPEYuSLDN+OuUD5STnwjIhHlG7uFZv0EJcV7nJxpSfPYV
         4GMH/NhgRY2yaAqGR5DD7PmxJwAVgrcf66RY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693326918; x=1693931718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0pWbpInDstIHBeP/BS4VOTRMTkNBmu1VJYzwpZwV48=;
        b=Z8YHsrXUaeL5Zm8+xqF2/9VREs+SgP0Iw1f5s3DGJHeeV/3QvcjIxQL/1V56AkPHw/
         MdItcjFirwgC/w4dQXEphqAcTdGwmdD0sj3nQCPxv5y8xWDy/WVKg+hbHHx8DFaM4yQw
         bL9X7mMm4HMuWTTILTRLNZ3OlN2AUvSBHjAc/gPQKwUE7Y2BdYu/33XT+L0R4ryRXEEA
         GOkXYMhbppJiLA9AG2B72a5NmPSk1peZp8CTAQpHcGELa6qE8HGlbutAFjsyW9yj/Tqj
         K1fH60h2po8o+0IsaynF0yE+vJ+SXrkrw5A2+juwzVtWQnFVw1zEv8WuzBxCiTlzHy4P
         +JMA==
X-Gm-Message-State: AOJu0YxXrDbXBzvUxuPC6v0v2WWkrg1lcBEnDJlXPkEMH9OYfw3Psks8
        SDSwCBDf6oi1HgzeZYZAkLdWXMQqkIYaLP7BsF6cgQ==
X-Google-Smtp-Source: AGHT+IGc5a3RHIDC903KhYAdCNp4NhyszcvbVEQ3ozZ1UJetLD8jl2bwSLKwJYPtWPl7FhSb4DGeiiI4ID14JE+nfzg=
X-Received: by 2002:a4a:765b:0:b0:571:28d5:2c72 with SMTP id
 w27-20020a4a765b000000b0057128d52c72mr15448838ooe.7.1693326918612; Tue, 29
 Aug 2023 09:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
In-Reply-To: <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 29 Aug 2023 12:35:07 -0400
Message-ID: <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     skardach@google.com, adrian.hunter@intel.com,
        SeanHY.chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, reniuschengl@gmail.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Rafael for advice on runtime_pm corner cases.

On Mon, Aug 28, 2023 at 10:48=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com=
> wrote:
>
>
> My concern is that when runtime_pm is false, gl9763e is disabled LPM
> negotiation, gl9763e can't enter L1.x and s0ix may fail.
> It seems that runtime_pm will always exist and that's ok.
>

Thank you. I believe we can address your concern.

- XXX_suspend/XXX_resume (i.e. classic suspend/resume) depends on
  CONFIG_PM_SLEEP. This always selects CONFIG_PM. This always includes
  the runtime_pm framework. So, if XXX_suspend/XXX_resume gets called,
  the runtime_pm framework is always present, but may not be actively
  managing the device.

- "when runtime_pm is false" AFAIK the only way to disable runtime_pm
  when CONFIG_PM is set, is to write "on" to /sys/devices/.../power/control=
.
  See https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-po=
wer
  In that case, the runtime_pm framework will activate the device, calling
  XXX_runtime_resume() if necessary. Are there other ways of disabling it?

- if /sys/devices/.../power/control is "on", then:
  gl9763e_runtime_resume() always called -> LPM always disabled
  gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled
  In between "classic" XXX_suspend and XXX_resume, LPM will be enabled,
  so the device can enter L1.x and S0ix.

And the LPM negotiation flags look correct.
Does that address your concerns?
