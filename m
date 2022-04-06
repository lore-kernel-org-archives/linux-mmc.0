Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AA6C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiDFQkt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiDFQkd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 12:40:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE57A25FD6F
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 06:59:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so4246608lfg.7
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1+/9uGNU/c0SUbZVyjyQElYWMN/Sm+TEsoVZ+LA9Dwg=;
        b=sznZSgTKnvb3REJi+cKW4bbvW2SCuFJQeNMNdl1UK7abPOiMjmtBnyzm3jiH38FVML
         VSaVoJ5E6zEvkyXLndR+PxA6JfqZOwO6KtDnV3hez/Arx1Wtr4A25zH315UtaVoxDi5P
         qFcS703uo8+eCkYtqLlPLafWcmeP+ifwLeVAe03BNOLF4H9lxO5ZZe/Xf4Bpls+X/DMu
         SShkA7IapxBRcfJHuqFR9okeFEiN4BDX3egCL6iDe31BuBf0v17dtMD/P7kpjJ+Y20yR
         kJplnuy3A6Uz2FV4BzeDv41iVYc/oyvyhoZWTayKoXIDk9gF2f/VcI5GAXVJ06lwcs26
         fryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1+/9uGNU/c0SUbZVyjyQElYWMN/Sm+TEsoVZ+LA9Dwg=;
        b=cJXExESXp3XfBBHn+1pGnF5xEBo8IWi/ZoxRZedm9Jlk/wMewQW0Iz1UkzYh+N6UrS
         wAWsQnSoDqt4bsVHTyMksqzL81epr/lV9mcBiuOriQncEtzjY3BEU+YbEL22yH1dyo6C
         m4/5hvnreaNt72nV8sESjWF+tWb2oXC5bY9GEi+Rfri9pyiHh81xuRBVHLdr+wY7tU+y
         ZY5HguInHC7QkQ+LPMcZhYHF2gKT3E73JN6w+dafV3wXazQsiAhGZOV/zy11oU+tNaph
         /U05OWjrl6aia0PBZtqQAjY3ReOC9LzjvR5ZAJktQS9LgskqhXsYvTNwiAL2MrHRtROs
         1g+A==
X-Gm-Message-State: AOAM533KI+9X/lUPkyssteAeEfMIlyXY/GrW1eRt5V4h4uw73Lwm/Uzn
        1J+u+ETB5JGbbr0wtBKWt7V8h4my6Q6gKSOIw0i8kIHY5G0=
X-Google-Smtp-Source: ABdhPJy+0n1cWazIOvM6G43K7umQC1gfmdgukS3y10rRQbQb5twaDBgVfSuwfuLHCtMeQCgHu4RbYXGpEVOB3q64a7Q=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr6407391lfr.233.1649253576150; Wed, 06
 Apr 2022 06:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
 <20220321115059.21803-9-wsa+renesas@sang-engineering.com> <CAPDyKFqwgxhRPBabxfUTC+8UVegWrTg3F0nRn3PoToiO2DWtvQ@mail.gmail.com>
 <Yk1JA4TWO9bTt0kb@ninjato>
In-Reply-To: <Yk1JA4TWO9bTt0kb@ninjato>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 15:58:59 +0200
Message-ID: <CAPDyKFpMAE9mYXUBEsVSm-9EHAC-o5hTxgKNUjYYvo0dzqfEZg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] mmc: core: improve API to make clear hw_reset
 from bus_ops is for cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 Apr 2022 at 10:02, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > To make it unambiguous that bus_ops->hw_reset() is for cards and not for
> > > controllers, we a) add 'card' to the function name and b) make the
> > > function argument mmc_card instead of mmc_host. All users are converted,
> > > too.
> >
> > Again b) is sufficient in my opinion. All bus_ops are for cards, while
> > host_ops are for hosts.
>
> Okay, this argument I buy right away.
>
> > Also, there may be some corner cases where b) can't be done, like the
> > ->remove() bus_ops for example. In that case, we either have to make
> > more re-structuring of the code of simply live with that there may be
> > some special cases.
>
> With the above argument, I could even imaging to simply drop this patch?
> That keeps 'host' consistently as the default argument? All given that
> 'bus_ops' are for cards anyway.

I have no strong opinion around this.

Perhaps one simply needs to make a patch to convert them (most of
them) to take a "card" as an in-parameter to really see if that
improves the understanding of code.

Kind regards
Uffe
