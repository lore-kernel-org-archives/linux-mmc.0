Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E0C388F9
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 10:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0C82063A
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGYXz/W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKKKru (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKKru (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2020 05:47:50 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8563DC0613D1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2020 02:47:48 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id l22so902053vsa.4
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2020 02:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgkXzU9/4gZgqTvAIagsY0SyNaXdwtJ+4SDO4OHtkpw=;
        b=jGYXz/W/9Xbn9CKQMNVGDOtpA4doGrtKtb4BOVOmGhgM0dzctntTNxl6iAmRqjND5F
         xecYDYR2ycG2D84rpCTuwmtx4WhLvy2+gcxQmWzUPAJ2C2iRPPNkeIfFUgsLlUMnaimM
         EM10wfaJrA7T16AuUEzYQqnrR4rg8g6ZWERekmh9F4oprY0BvAk9UtCX7FeplKXDr0Dp
         6D2ETw/aw6Bb80TiaVQ02N1/1r0PP2pp6p98+1sy0ajS+DlXm6pMkXhtgJ+pnClgpP5h
         le51d0O58VGkBT6FdPLSl3507Gzbfdbbra4sNQ30WKUDwuVgKSka+R5JLUByBXZpTIVy
         PfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgkXzU9/4gZgqTvAIagsY0SyNaXdwtJ+4SDO4OHtkpw=;
        b=XjD0mkiXicl0kf7WfUvC8cT0X5rM0Tj+8KSiNTIocVSvOmhsrO+uysaD8ZantaN1u3
         BKTUuZiuvoHKeoF2NnmVoqdyvGG9ZAcabxUsR/7Coe9zlOFL1vdvaNLHQiOCysQFCXU/
         FabwocWzwLvb4rh4BaT+DiwFEg0QnGriH90X9jABpXxLuuiFV3pqnnBAO3WXDGpSssuu
         5O94XHESKNbpMV90GzLPpQ5EOt/w8tZmkMfqTkPSbaFQn6L0SZQgerYPABIcWJupt0JC
         J6UiUn8DzUNU71dW6aUPDC2wMMN8Z8isPos+i5lcj4VriWbN3tqXmn4tF4IJd4Rp/zXj
         UOsA==
X-Gm-Message-State: AOAM532KXXMn1IwrrewTJeX3wjAgz/svq6N5ZGbITtNqWK94SUIfFtkO
        eqvwtn8ZFIjvcc8bBl5ji4iGqb61cnkyEy7bnGurng==
X-Google-Smtp-Source: ABdhPJxUM+6o+Ztc41vzfoV1T1XEqMiTB2AsemlLbtndzb34v3lhdhghjD321/DmrcfjSikdz3NFTviA88YwazaoRhI=
X-Received: by 2002:a67:3256:: with SMTP id y83mr15817866vsy.48.1605091667748;
 Wed, 11 Nov 2020 02:47:47 -0800 (PST)
MIME-Version: 1.0
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com>
 <87o8lf74j5.fsf@nanos.tec.linutronix.de> <CAPDyKFosR2wd=jqADBF_dNd3kCMbM4oDAHyxiYC-5RF=SZ_E5A@mail.gmail.com>
 <1jzh3p9rs6.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jzh3p9rs6.fsf@starbuckisacylon.baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Nov 2020 11:47:11 +0100
Message-ID: <CAPDyKFq8dM7Z48uUWHai83avwdhOOGU2NEefM7ifaOUcfW+BsA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Brad Harper <bjharper@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Nov 2020 at 16:05, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Thu 08 Oct 2020 at 11:08, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Thomas, thanks a lot for helping out and looking at this!
> >
> > It looks like the testing of the patch below went well. Are you
> > intending to queue up the patch via your tip tree?
> >
> > If you need any help, just tell us!
> >
> > Kind regards
> > Uffe
> >
>
> Hi everyone,
>
> Do we have a plan for this issue ?
> I've had Thomas's change in my tree for a month, so far, so good.

Instead of waiting for Thomas, perhaps you can pick up his patch and
re-submit it?

From my side, I can of course apply your original fix to the mmc
driver, as an intermediate step. Is there a hurry?

Kind regards
Uffe
