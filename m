Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE3C83F01
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Aug 2023 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbjH3Ung (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbjH3UnX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2023 16:43:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693763A9C
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 13:29:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26fc9e49859so111102a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693427277; x=1694032077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TmLk0fQBF61eW6D8ZlImNTOGih/aAgkyRTy6ROPKDY=;
        b=FQggWjyYeGIQv1Du4kp6n5qybxIkzpKMNVpKooum+YvitKfxcO9KetjPSe5kWWTpP1
         hAEYYPop5P/0Dgic3nkLeCrWjAzQ6+lre3pzf35ahzGvKU0ZgObfOGgg5bGH5K8CQgug
         4NmfcMp/M6jJ7WPHlck7Sw6qYiOFXs+CsPfwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427277; x=1694032077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TmLk0fQBF61eW6D8ZlImNTOGih/aAgkyRTy6ROPKDY=;
        b=WA6HMXMEHrfCGKdloO6L5idjmtizOJJBo4OECwIFbXWipb+VQkoGCUFR/3L8wXZYPR
         dSeoefbq2cYbriAbPdSyTsxMsrP5EPX0XVuH5o6QhEtGbl4J4rNzJ9ELM18QhrggvXFz
         YSNIXtaKekQH3HJDecbyQ97Bwwg41k1C9c24HXj9t+kywtwvhLyhSIUkRJQFyVns6hp4
         3zqJO9gjt19HbrkuHX4Jl2NObYfHPMwo6bJu0CDUIy9MwE9CAOmUp3NRDGC6T1aTP34v
         8Wqn8d/s79xpK+xWmOGRJaATh7MMBNc7mV3TBRQ4YJQiqa+E/D8b5+BRdROnKzz93rys
         42hA==
X-Gm-Message-State: AOJu0YxXmd06mwFqEwwNEif3rBmtqb/fJ23NbRLi3fLucB/mFgO4JuyC
        4aAlfRK4wSQitVK8MrrsVKWVAoEQqyVtPwcxsKn+Z9pZj1ReO8c/29A=
X-Google-Smtp-Source: AGHT+IEjRi05Wg22Qjjn/hflcI7CQBa5XMdC0mt0jO+fQBSO3iMmADiYtjmP70bxRwmPUSH03EeDMSyRdegww4AwyXw=
X-Received: by 2002:a4a:3416:0:b0:566:ec2f:36d0 with SMTP id
 b22-20020a4a3416000000b00566ec2f36d0mr3163656ooa.2.1693426449335; Wed, 30 Aug
 2023 13:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com> <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
In-Reply-To: <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Wed, 30 Aug 2023 16:13:58 -0400
Message-ID: <CAG-rBigLPfJ6u5LQZ4FwMMm_h3b5fQiRYFkwNjFHm4cDCN1VRw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        skardach@google.com, adrian.hunter@intel.com,
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

On Tue, Aug 29, 2023 at 10:27=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com=
> wrote:
>
> >
> > - if /sys/devices/.../power/control is "on", then:
> >   <snip>
> >
> In this cas, after gl9763e_resume(), it is LPM disabled.
> Is there no chance for gl9763e to enter L1.x again when the system is idl=
e?
>

AFAIK the only way to disable runtime_pm is to write:
  $ echo on > /sys/devices/.../power/control
where
  $ echo auto > /sys/devices/.../power/control
      means: runtime_pm is actively managing the device, device can be "act=
ive"
      or "suspended".
  $ echo on > /sys/devices/.../power/control
      means: runtime_pm is not managing the device, device is "active" only=
.

In the "auto" case, we know what should happen: LPM negotiation is enabled =
when
idle, disabled when active.

What should be the LPM negotiation state in the "on" case? We have to
make a choice:
a) LPM negotiation disabled: normal performance, high power consumption, OR
b) LPM negotiation  enabled: low    performance, low  power consumption

If userspace disables our device's runtime_pm by writing "on", it expects t=
he
device to be always-on. It should then expect a higher power consumption.
It should then also expect a performance that is not-worse than the "auto" =
case.

So my suggestion would be to use (a), which is what this patch does.

Appreciate your thoughts.
