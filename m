Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A465C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 10:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141006198A
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 10:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhCaKbr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbhCaKbq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 06:31:46 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1DAC061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 03:31:45 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id a23so9637918vsd.1
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F0Bwm0H4K+KoMh/mSTXGIFpAMYfN5fl8UyfaIwUMZ6o=;
        b=hUvkQcMglz1zsm5XnW1LuxH6wKb6S9gNINGSkXylfQYyA+0n9vkfZgLlaoMnRwnBp5
         te5FIsblM1KXggTs+7jhS1wfWy4wtUFoR/IEvtPIqt3wslOBlKeb1MSAcRBFXQq7W9tV
         C5zwBmD+eT2lRuDGdhcHjBzaSxpww40+0RfJ3SvAsKNhP5QjhOsnG4O5JkrTHGUsLN5U
         DHGSWytlvrzRZSbt3AU3WIIun91vCSFJXikPPXXqRWKnEMYVWIOJWTdlVE06Qr04PKEK
         F/LJ2ZRJLEr94yy9z0Vm9tU8S12PjAZITTDtwmHP1usrz/LthUGUTzbEREE+MOx0IYSp
         gI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F0Bwm0H4K+KoMh/mSTXGIFpAMYfN5fl8UyfaIwUMZ6o=;
        b=MnWje3beibbPwuG/vHTK8/98c129DAV24CwtyqupXnGp++No35e00g9nZ4H3BZ7V9w
         FQDlsh+APBct77C9LHzwzRdTUsNQEY4R+d7veH3J0VQ2tEFY3ThPTeaciKpVxfi44eXZ
         6fhkTz0wblXoLvM0ZlbRESYjDU7vx96DYkxnhhSJqgFlEAl3QPzl6XxtpD1htoAMWASq
         K9LuIbzyDAWcR7mc8wi2txAbEmEl/NSUFoKOSh3NOyMuKxJcI3y8kGHRJ4bSvC9xLbUB
         R4UDOoXcj+desymhlS+0+QSDENfxpzNmT4N4J+cB11Xhk4n0ynL/a4miocsrnZ2iyWXr
         ObQQ==
X-Gm-Message-State: AOAM530AK4Ig360nsvtjmTTrcmnqxdBt5bypg8W3lockPNfP9PFM5e3T
        vyHGLfN+R8G2dZclkgW7PsJ/jShd2ty2ui0Fj4sulivW7yxMAw==
X-Google-Smtp-Source: ABdhPJxVPJcNvvVTUiyZ4bUOwYIW4YjPOyPOivb+ghmbDHjaDnsbOBJkCD6XebDjNyTrpuu0vc4ZcdPoe4lMQPbC8Tw=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr988500vsc.55.1617186705059;
 Wed, 31 Mar 2021 03:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210225170352.76872-1-ulf.hansson@linaro.org>
 <CAPDyKFp0+jBDcJnxbvdkZWo6jmSa-CdT6RNbH2hmrWnXEqU0=w@mail.gmail.com> <FDA815A8963C6B43ABF06E8A34984F99F9B709BB@Gli-MBX02.genesyslogic.com.tw>
In-Reply-To: <FDA815A8963C6B43ABF06E8A34984F99F9B709BB@Gli-MBX02.genesyslogic.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 12:31:08 +0200
Message-ID: <CAPDyKFp0SnjPu5FFBznzif-=LFeBy8XeShG3zvtaPzNCRuOD-Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: core: Preparations to support SD UHS-II cards
To:     =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <Renius.Chen@genesyslogic.com.tw>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <Greg.Tu@genesyslogic.com.tw>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?= 
        <Ben.Chuang@genesyslogic.com.tw>,
        Renius Chen <reniuschengl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 31 Mar 2021 at 12:26, ReniusChen[=E9=99=B3=E5=BB=BA=E5=AE=8F]
<Renius.Chen@genesyslogic.com.tw> wrote:
>
> Hi Ulf,
>
>
> I'm currently trying to take over and refactor the task refer to your ser=
ies.
> And there hasn't been much progress recently because I'm busy with other =
work.

Alright, thanks for sharing the update.

Don't hesitate to ping me if there is anything you need my help on
around the UHS-II support.

[...]

Kind regards
Uffe
