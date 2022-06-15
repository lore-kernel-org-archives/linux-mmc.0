Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD9C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 22:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbiFOWso (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiFOWsn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 18:48:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB936B7F
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 15:48:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c2so21167116lfk.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42g8IFLodr5G+mXemIufY8nNh/UNIcbK1ku75HLKQ5w=;
        b=Y5JDp07Ctph2K+sXWBkHvHDnuGFyqUKKVfCLxfsNUpapcMCl5HkiDnX0abyAs2EWZE
         IcKHu7tHLMIo5FavjMglrapQAAkAEqz+cEU1oh4RmtDN6hrHnuin1gOdVYc4y3BFKHfT
         jJ7wXv8nOSG5LP8+3L6NxcMB8fqHRNDEItteTIFWyZiLjXFg7pDpHVJCK7Rf/2IA+1Ob
         vaJYpbAY2MPrVPo+HR/yOwLYFsHI/W6n9kWvPGZxJqjQ02kg9J2IoANbR6IQThvGglkK
         Fef6eHZihjT7ornSp/mG9yuv2auQ7xjbttB6NDrrr+xUvONrnCDxOTpidYEV1lqOtZBb
         CYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42g8IFLodr5G+mXemIufY8nNh/UNIcbK1ku75HLKQ5w=;
        b=mpccLWW934guDsdE0pSs6jjqAnunI5j5qpS0JMKpGVrQvE1eynKD/AlSIG+mob+lvY
         1ROJaDO7XN5LT1di25JNHgKCFdDPBlnb9zSzv4gjzBj1Fc3bYFfH7mzYIL1GUzddPxib
         HoG9mMl8hhFKGfsOg7NcO94DMtn+TCwRDLgbVnI1YlMcmr1b5zyYCXqK5VanpVnTYveH
         kLopXvUvLNGhu+uBwj7yAq3psagbHQFNtKcIdoZR7UUbtIRjpANkOnbSD+xP12QfXNqz
         1r4QhCsu6WoHOldWnMyqrfm+eMDQ170DAWidD/2rR5g06P27igRUorBUAhYylCklKz7p
         cAOg==
X-Gm-Message-State: AJIora9LGTgRS0qtE2IHV7Vv7H7uk3lKVmAsclcCe/Jo7K3sJlVsVbN/
        ClfnqAcux2vB109T0NSwsVA5p5K88uiqJB7gbRXK5g==
X-Google-Smtp-Source: AGRyM1uqktRFwXLRGh8UNfnGFqAGqpZBn4pxI9CZ65tJiItaPSC0RQdT5gXMc9hhO+fQU/jdojC8S37efQk2eE1kvCg=
X-Received: by 2002:a05:6512:303:b0:479:1baf:7e5b with SMTP id
 t3-20020a056512030300b004791baf7e5bmr992290lfp.184.1655333320836; Wed, 15 Jun
 2022 15:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com>
 <MWHPR0201MB3466C629ECABC8FD6B009276E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
 <ea318551ec0b43429ce47bfac9ebf285@quicinc.com>
In-Reply-To: <ea318551ec0b43429ce47bfac9ebf285@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 15:48:03 -0700
Message-ID: <CAPDyKFq2-Jwii_aMbsqYNM_Dq0-MMEEtUYnNKGbQgvDL+M-wdw@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
To:     "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
Cc:     "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "huijin.park@samsung.com" <huijin.park@samsung.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        "quic_spathi@quicinc.com" <quic_spathi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 24 May 2022 at 07:37, Sarthak Garg (QUIC)
<quic_sartgarg@quicinc.com> wrote:
>
> Hi Ulf,
>
> Please find the gains seen on micron and kingston eMMC parts below with partial initialization feature (These are the averaged numbers) :
>
> 1) Micron eMMC (ManfID 0x13)
>
> Partial init                            Full Init
>
> a) _mmc_resume:                         _mmc_resume :
>
> Total time : 62ms                       Total time : 84ms
> (Decrease % from full init = ~26%)

Alright, so we gained around 22ms. Not too bad.

>
> Breakup :
> mmc_claim_host_time: 0.2ms              mmc_claim_host_time: 0.1ms
> mmc_power_up_time: 33ms         mmc_power_up_time: 33ms
> mmc_sleepawake_time: 28ms               mmc_init_card_time: 50ms
> mmc_partial_init_time: 1ms
>
> b) _mmc_suspend:                        _mmc_suspend:
>
> Total time: 5ms                         Total time: 7.5ms
> mmc_claim_host_time: 0.5ms              mmc_claim_host_time: 1ms
> mmc_flush_cache_time : 1.5 ms   mmc_flush_cache_time : 2.5 ms
> mmc_sleep_time: 1.5ms           mmc_sleep_time: 2ms
> mmc_power_off_time: 1.5ms               mmc_power_off_time: 1.5ms

The suspend time shouldn't really differ. Or is there a reason for this?

>
>
> 2) Kingston eMMC (ManfID 0x70)
>
> Partial init                            Full Init
>
> a) _mmc_resume:                 _mmc_resume :
> Total time : 46ms                       Total time : 62ms
> (Decrease % from full init = ~25%)
>
> Breakup :
> mmc_claim_host_time: 0.2ms              mmc_claim_host_time: 0.2ms
> mmc_power_up_time: 30ms         mmc_power_up_time: 30ms
> mmc_sleepawake_time: 14ms               mmc_init_card_time: 31ms
> mmc_partial_init_time: 2ms
>
>
> b) _mmc_suspend:                        _mmc_suspend:
> Total time : 5ms                        Total: 5ms
>
> Breakup :
> mmc_claim_host_time: 0.5ms              mmc_claim_host_time: 0.5ms
> mmc_flush_cache_time : 1.5 ms   mmc_flush_cache_time : 1.5 ms
> mmc_sleep_time: 1.5ms           mmc_sleep_time: 1ms
> mmc_power_off_time: 1.5ms               mmc_power_off_time: 1.5ms
>
> Did some minor modifications as well to this patchset as per avri's comment which I'll post as V2.
> Please let me know your inputs about these numbers.

Thanks for posting these numbers, much appreciated! Please try to
include some of the data as part of the commit message as I think it's
valuable information.

When it comes to reviewing the code, I am awaiting your v2 then.

[...]

Kind regards
Uffe
