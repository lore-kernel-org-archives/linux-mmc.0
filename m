Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB4C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD38623A23
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 16:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbhAUQ2D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387750AbhAUQ0a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 11:26:30 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865A3C0613D6
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 08:25:37 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id o125so1352665vsc.6
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rL3ud9Vf/X+++k4tiy/q4pzVuK3HWoXCz/1tF4KhcLQ=;
        b=afJkIrxDnrv2GPISJA76WpVyiOOIp4mwv+9wCXGWPBK7gOODZcE0eVNEtc2u1JJ0kC
         ZTOjRj23JaI05nIKkdc507H0iX8M2Qe6eARVYJzw7rHSTTkK3GloLQyZhzy9TgRsoTTh
         cpVETAaEyxkTDSWolKIchsUKMbeu/iUDPge21LJkKZZuQzgogezpRSmtAibMrbUYt4+i
         J2gKjN6GK2MDmJWjsvJ1npSBuz6M0gfI4XdDO6SPvrYlan0eD2kdSYMhRURaYclJMRjS
         Hbj5o3SCpafEQb9xXLd2mvbNtRF9QjYoCVRm+hkTj2at5BXtYySkhcQBuBf+Z014g01u
         O9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rL3ud9Vf/X+++k4tiy/q4pzVuK3HWoXCz/1tF4KhcLQ=;
        b=rpwSbV+qPkUSl9b081UJbvn18ER73K/fH6nNL9jvC3U9CBmqwh2DlCxM0vxwvQ65ib
         e8XcsYj8ACSdFTNQvDSOLU7/P/01q7watSBKOP1vDQNHQZXFiyMsfUZelMfezZIa1dU6
         qfayouDdq3GvZZ1W6IPQe7DjTTRAP+QI5j/Z2O1FdQYOVWL7oDUR4SIuREQ2Vn+wOUmj
         WcGvRVqht0GAgfaGafx+x7LHoVXGfdpHNkf+k/6+6kR5MERQxnepGN5F1nr6LHrG1CKZ
         xpGuZDAlkjU4zbilU5Kwuo3rZZfsY2tM2cRe5/nznMcPp7ztaLHI4ioJHV6Xl3gNQeCz
         EjYQ==
X-Gm-Message-State: AOAM532tOvOvHAhw8c8oidWx5DOTrBYD1As+SfHrQacqeDaK5b/oouX6
        dwAPYD8v/SWSqGhh67Jd7DfFrL51wMd8TayVb9jzaYjlXudZow==
X-Google-Smtp-Source: ABdhPJzJvTkIcNEdg8zsT0LPClur5FXw3BifEhr402K54ugCLYzcHRX+pZ6qEJBCYmXu/6zaakvHU4157/HX5lQWWJU=
X-Received: by 2002:a67:facb:: with SMTP id g11mr247740vsq.19.1611246336783;
 Thu, 21 Jan 2021 08:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20210121090140.326380-1-ebiggers@kernel.org> <20210121090140.326380-7-ebiggers@kernel.org>
 <CAPDyKFoOL2Dsqb=nKw5hF5hiVLn-TDHWH4Th9icvoLY4aJtpSA@mail.gmail.com> <YAmd/b2y7vvp7udE@builder.lan>
In-Reply-To: <YAmd/b2y7vvp7udE@builder.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jan 2021 17:25:00 +0100
Message-ID: <CAPDyKFpzwj=hrOLCbWcoVd9ZNM5-BtgPP7Y2L-78SpC2OsB8Bg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] firmware: qcom_scm: update comment for ICE-related functions
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Jan 2021 at 16:30, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 21 Jan 08:42 CST 2021, Ulf Hansson wrote:
>
> > - trimmed cc-list
> >
> > On Thu, 21 Jan 2021 at 10:03, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > The SCM calls QCOM_SCM_ES_INVALIDATE_ICE_KEY and
> > > QCOM_SCM_ES_CONFIG_SET_ICE_KEY are also needed for eMMC inline
> > > encryption support, not just for UFS.  Update the comments accordingl=
y.
> > >
> > > Reviewed-by: Satya Tangirala <satyat@google.com>
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> >
> > Bj=C3=B6rn, may I have your ack on this one? I intend to queue this via=
 my mmc tree.
> >
>
> Certainly, sorry for not paying attention.
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks!

>
>
> And I presume I'll take the dts patch (8/9) through the Qcom tree...

Yep, I leave that for you.

[...]

Kind regards
Uffe
