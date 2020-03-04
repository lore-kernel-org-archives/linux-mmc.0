Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630FDC3F2D1
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9BF2467F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IviQc9iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgCDPex (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:34:53 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46370 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCDPev (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:34:51 -0500
Received: by mail-vk1-f195.google.com with SMTP id a76so662522vki.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIJVEAVVaV8+1KTQ4VSxAJV6cC1N0MZepqVqzZDRzz0=;
        b=IviQc9iq4hefPyctoluYF6imwJrLeOsKMTTMkb7fQwxpTRrY2OM9RRExAv6iZdToeO
         hRSWvEkObNO3dMg3mqbmOYRHtK/yBt/TQg64bL1Ua5+4b0VdstGBLRXCfu1+gSmwJYQW
         3sI+XOlVY69iAuSRd08Wl8KKJs3mOOTlH+g7eUGPLJGK8VdKBL6acXXHhoQ3QdGOBErb
         bcwpLWtF3gQFi3mNRZ5sfyMQEHxHTo+jN4F5aY8THFoswDnM9aHVqn+TzWH/34UVQSo8
         5dGGAbJHDGiRUw9F76H555r7F123oOdHITs2XtLMvBwa4DEh/t3RGveW8kekF2Dd/Wk3
         7LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIJVEAVVaV8+1KTQ4VSxAJV6cC1N0MZepqVqzZDRzz0=;
        b=RZStoTG74hNjWpEhlnYjYP/AgBkZRMQGzg72MeZvMmrQnWwX/+x7w3eVcwLkO3t4pV
         WsKX7btegpX3mITVIfbcOf8ZjB8BPr+WbSjFMVFh5Wb0ZFU5z2iLX061lKa6HaidiL8k
         zal2X4bfIZvBUuSlEtwhZn5ZjHr/hlK9WAhN1OTBdd/9Rsw1hf+5+kTmAW39HEVQ3zVs
         Oeg/vjxfPAmJ9KtWhO6lT4fkrxOS0iifwFRzl4bu+yt1x6P7UlSE3dRHwHmLVYBeAm9T
         9dUvxErl/q0R/3Ikeavj/opIiWsgod+vH8DesI0bTKV48rria6x+389U3NaZV74i7O0C
         XyMg==
X-Gm-Message-State: ANhLgQ2C/gjPE/FSW2AvcUnTt/9FQwvrSDfwvUC+/YleO6ltNee4mhF3
        T/zBFU4VVrkMR/8Xn9r04640nuMtDaMjCrTBv8P3Aw==
X-Google-Smtp-Source: ADFU+vuSliPnQWMxFtDiOJdiWUdv7l0GqaMSjN4n/lYfyMirS9Qnruhwqrv0AxIelaoc9scRZorUVPFJ14Wu1OeT35M=
X-Received: by 2002:a1f:78c5:: with SMTP id t188mr1798337vkc.43.1583336089860;
 Wed, 04 Mar 2020 07:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20200108150920.14547-1-faiz_abbas@ti.com> <7edb2c28-11fd-e282-a8d7-e61aad8cace2@ti.com>
 <CAPDyKFpxVXqtcTC1oRfHxNy=mBHhR-jhOu9VrT86-_5NV2dv9A@mail.gmail.com>
In-Reply-To: <CAPDyKFpxVXqtcTC1oRfHxNy=mBHhR-jhOu9VrT86-_5NV2dv9A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:13 +0100
Message-ID: <CAPDyKFqPDDe9+1e7E4F+J3eCq2JefJFKYYB2xtQFQFb3ERvaFw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update phy configuration for AM65x
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 3 Mar 2020 at 21:53, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 2 Mar 2020 at 20:11, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >
> > Uffe,
> >
> > On 08/01/20 8:39 pm, Faiz Abbas wrote:
> > > The following patches update phy configurations for AM65x as given in
> > > the latest data manual.
> > >
> > > The patches depend on my fixes series posted just before this:
> > > https://patchwork.kernel.org/project/linux-mmc/list/?series=225425
> > >
> > > Device tree patch updating the actual otap values will be posted
> > > separately.
> > >
> > > Tested with Am65x-evm and J721e-evm.
> > >
> > > Faiz Abbas (3):
> > >   dt-bindings: mmc: sdhci-am654: Update Output tap delay binding
> > >   mmc: sdhci_am654: Update OTAPDLY writes
> > >   mmc: sdhci_am654: Enable DLL only for some speed modes
> > >
> > >  .../devicetree/bindings/mmc/sdhci-am654.txt   |  21 +-
> > >  drivers/mmc/host/sdhci_am654.c                | 247 ++++++++++++------
> > >  include/linux/mmc/host.h                      |   2 +
> > >  3 files changed, 192 insertions(+), 78 deletions(-)
> > >
> >
> > Can you help merge this?
>
> Apologize with the delay, still focused on fixing various regressions in v5.6.
>
> I start catching up on my mmc backlog as of tomorrow. Thanks for pinging me.

Applied for next, thanks!

Kind regards
Uffe
