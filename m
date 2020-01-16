Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F1EC33CB3
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD2B246B2
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195159;
	bh=yeSp0fGwJ/dgY0fFHiYhsov/EbuVK+ryQi59MzAqvno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RCz0BvA6qrMcUDH2lV7jmHhwVSRIRLIsRHkxkwU+LyIRXeENXCuhhp/IYw62frYaQ
	 zpNef0wTFTul6USPFdGJo/SE6LLHsl8lu+Mhbu9DFDd1k9c+7ONpfLbtcKzucEnlzy
	 GGswTn8WCveQWDk/nuBquxHCQ0SxtGgBvQM/oGaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbgAPRTO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390022AbgAPRSa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jan 2020 12:18:30 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBBB9246CC;
        Thu, 16 Jan 2020 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195109;
        bh=yeSp0fGwJ/dgY0fFHiYhsov/EbuVK+ryQi59MzAqvno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qN99BKR4uuYvaV0p7EkeJpD0n1G7OxycmMcmdYmyiwnqsT3GBQWRzT3SZeWjAUYn7
         53YsrY1f4tOvKorJAq2KHbUBpxpwMPWFai4XnmBwLslwSXR201rnGSwV/ZRtnEoIJB
         Ue/ErdA7tyXwktsjcmnKzM04KsD+AiEsFYg8kEIs=
Received: by mail-qk1-f171.google.com with SMTP id d71so19861933qkc.0;
        Thu, 16 Jan 2020 09:18:29 -0800 (PST)
X-Gm-Message-State: APjAAAVTmKll/6bSKHZ5sqCaw3eQYKGmUEvxd7ZsGCLeeBnoZdIbr499
        wrRZxDVWMH2/V1kfjqix5+W0/FIp5W7KR7wiwA==
X-Google-Smtp-Source: APXvYqwFGJOr8mcO10BEbC3XUTOrgXEnY5Gd03lvreXKQUpv+wwI5MMwTMEmeMNDEkHT1VsOrGSSi3n3CwzN8ewQfCQ=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr34765113qkd.223.1579195108958;
 Thu, 16 Jan 2020 09:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20191219145843.3823-1-jbx6244@gmail.com> <20191228093059.2817-1-jbx6244@gmail.com>
 <20200104215524.GA28188@bogus> <CAPDyKFp5BvA7tKpBUh-bpn5X4xvg8b9HuMO7+fZVJEp78=ToRw@mail.gmail.com>
In-Reply-To: <CAPDyKFp5BvA7tKpBUh-bpn5X4xvg8b9HuMO7+fZVJEp78=ToRw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Jan 2020 11:18:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9w2wjwoOfnnKUBk9kOkZFcU6aWwyaw05ye-p3_WDcaQ@mail.gmail.com>
Message-ID: <CAL_Jsq+9w2wjwoOfnnKUBk9kOkZFcU6aWwyaw05ye-p3_WDcaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: remove identical phrase in
 disable-wp text
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 16, 2020 at 5:17 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sat, 4 Jan 2020 at 22:55, Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, 28 Dec 2019 10:30:58 +0100, Johan Jonker wrote:
> > > There are two identical phrases in the disable-wp text,
> > > so remove one of them.
> > >
> > > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> >
> > Applied, thanks.
> >
> > Rob
>
> Rob,
>
> Normally I pick up the DT doc changes for mmc whenever you have acked
> them (at least more non-trivial changes). I regards to the
> mmc-controller.yaml file, I have no queued changes in my tree for this
> cycle so this should be fine in regards to conflicts.
>
> Going forward, do you prefer to pick the DT doc changes for mmc, or
> can I consider this as a single occasion thingy?

I usually only pick up small changes if they are a binding only series
and if they haven't been picked up already.

Though I've been picking up a few schema conversions primarily so I
can check that they validate. Hopefully that's temporary.

Rob
