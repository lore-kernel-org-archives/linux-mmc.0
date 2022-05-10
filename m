Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD57CC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 10 May 2022 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiEJKBP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 May 2022 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiEJKBN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2022 06:01:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820EF68BC
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2022 02:57:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu29so28386174lfb.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2022 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m3iAFIP4OMSq8KQP1j7SVBKWO8n8BXwTBCZYgtGpfJA=;
        b=XOD7CIe6QugAPdXy/D2qzQ5VXi+F6iYQdFliexYWfpHfAYJDAUSnbDQbscvnT4GGK6
         Re07x2ZupXs1kMpVXVwuOYHGNJpYf3Q+Jup4+CPzthqLCgX04CdkGLgduw+yf2en6zA7
         0IxxQwWRCtQa1CAz/CvK6IWdFHR1BeCzgSFFXF/DRmLF05DOp/zKnwVd8VpUi5Imvmvr
         XQMt4QLUsDI//XK7Ot/uI+9d3l3k1fIizTaUzsZ6PxjP7bU94s46R19FYs2mXWQ6auM1
         G9plVmfpa0aCToSvaQKVihswo4QH3Jd4iZnnHkI0y/rVZyzFnE2o1td4eGaA77KDeynC
         PyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3iAFIP4OMSq8KQP1j7SVBKWO8n8BXwTBCZYgtGpfJA=;
        b=uDHEU35xHbY2WWumaVRM4hS1VL0dK8bUPFXx29q5Y9dtvyMGewMx7MeemybNsu9x0S
         fsfwEXHbqY4z1jbyeZDsJuleaqWVZkn39MyQvM9icJV4n+h8kh38xKDy3zZuYuuPKUAs
         jgwJCvHq42ixtjsjRdmQ4tMilroQnY0TZZLk3dLwHUeI5rcgEWuVHmbvy+gHM1R0XacE
         T+BbK52peiPvJ7jj5sRMb1HW1SuB0lybPAobVkWeqr3JVUY8mkwOfQ36g+pSNoQ3GgCn
         KTO1mu4m8YZAYzUSzveRzjTCgsrsSHwFqEyeFF0OkMbEjusu4MCP/G1cd8Ac6Ao7G//2
         ysAQ==
X-Gm-Message-State: AOAM5338B3DCk0HIMgNEP5O9ismCKisxYyCS5ZyxzYn5gEOzN90y8pXY
        d1P+P6LkmW55SLlMgmM2+BlV3z96rzcFpHtvRcGyrXdyH1e96w==
X-Google-Smtp-Source: ABdhPJxL4NKh539TGVeg+05mFm/Hb3XS/hD+s1HzPp85CNXNX/uhcWbw2ohXqvPy/MEwQ1plCcnOwdrzkrItgvgf78U=
X-Received: by 2002:ac2:4646:0:b0:472:108e:51af with SMTP id
 s6-20020ac24646000000b00472108e51afmr16072941lfo.184.1652176634708; Tue, 10
 May 2022 02:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com> <CAPDyKFrYWgCbwk6-hNZjtx4mdn7Sx1NJLie+f8wEjS==_HXR5Q@mail.gmail.com>
 <add6c326a5b04525965ffa1e9e96ea41@hyperstone.com> <YnjjR8pouD4KtHtT@kroah.com>
 <050affc68f7f4861b35a1ab96e228fec@hyperstone.com>
In-Reply-To: <050affc68f7f4861b35a1ab96e228fec@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 May 2022 11:56:38 +0200
Message-ID: <CAPDyKFqh15PFKza8vQpaq7HK_DH3w4q8AvpskZv=vzNYfSdqJQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Ricky WU <ricky_wu@realtek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 9 May 2022 at 12:12, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> >> Can we get 1f311c94aabdb419c28e3147bcc8ab89269f1a7e merged into the st=
able tree?
> >
> >Which stable branches do you want this added to?
> >
> >thanks,
> >
> >greg k-h
>
> From what I can tell the issue is present since the addition of the drive=
r in ff984e57d36e8
> So I would suggest adding them to all? Maybe Ricky and Ulf could comment?

That seems correct.

Although, it's likely that 1f311c94aabd doesn't apply to older stable
trees, but I guess we can try and see how it goes.

Perhaps an even better option is that you submit a backported patch to
Greg for those stable kernels you want it to be applied to.

Kind regards
Uffe
