Return-Path: <SRS0=wlIT=6I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA81C2BA1A
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 07:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885BA20700
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 07:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/kCdDql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgDXHYY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXHYX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2020 03:24:23 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D84C09B045
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2020 00:24:23 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y10so8499331uao.8
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2020 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwU7oZ/XAAyY4lpunUIkqcm1gubUdFQTG9en47Gx4nM=;
        b=U/kCdDqlJOd1t2vRuAJazeRN4kJyJhL8c20e2AZyQiNSeFyDxg2MRNpxtdeYhO5rIK
         vtqkEpxvw0a89RGYgOoRh+8DAkWYm7/eXrn4gibrW9zZJa9pyD1eWp61ZZRKn8RNsP2X
         CjOTQp0QBUXXW949H4Ni8j5Coze/J/jGKFIfNNwsd14oo3lmjqeq3sMPtBxY8beJ6os2
         lulqpVkbj/zD2vMaHKK/ec+bwX2xHA0sCYxK0JpPcUO4oCzVVQ2KSaQup9KfiNrnv2Nv
         2nM+QjPvXA+mXqoHYXzbjvzTHSiurIpJ2MWASURG+6mdwNC3Ruah2gL3Xbv9fCx1vbiZ
         e2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwU7oZ/XAAyY4lpunUIkqcm1gubUdFQTG9en47Gx4nM=;
        b=RrhgnQa8fAOST5zClvxlmEcZmChH4mdnjWrBVEJGVglHSzkN9RsjWy+2u016v5FWFG
         MX70AVEvNla8EXIyjRve/pwKHJHFM0Os7GmZ41YlXW8s4K/ZnLUA5/ThCcOFxXiiki48
         +10f4u6nIY6ZoyWW8dN+u7eM4YWZ35ixmMEJI8GGnQAgOP1x1/90CpbQrNCVCMNxLomP
         uF8zzcKoD9RfxSLrEYOUeC9LdrMGv2M8FYv2MbO41+yKK47hXwKqCp9JFYgxRHoentjx
         oPpffOgeDbnHqPAhfriLJG48uVO98PD83kmp1gbNx+iwGr1H80JjFJ2e3TONlDWB+NCx
         diog==
X-Gm-Message-State: AGi0PuZt1OrHT/7q+2+9OZhIKcVcst20rKflGxTNKCqShJdzdl8qRd/6
        KfC6u2x14pxT5lDCC8K8Zfem71irTTMTrNiKzBKWFQ==
X-Google-Smtp-Source: APiQypL6qzCRDuV/VbVYnPK5EVP2CZUDyh3ce3Agw5OQpvjytHoi9RN5IqoljEP2WZVNlu7rsy4mEAMRNQyRya+68vI=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr6618953uam.100.1587713062734;
 Fri, 24 Apr 2020 00:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
 <20200423064755.GA3491005@kroah.com> <fe49d36f-65c9-736f-791c-27c602cc3bb8@nvidia.com>
In-Reply-To: <fe49d36f-65c9-736f-791c-27c602cc3bb8@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Apr 2020 09:23:46 +0200
Message-ID: <CAPDyKFo0vx1=_j5M-X068n8Xp3wU9JVrXkADCDcGX0Q1oRBzRg@mail.gmail.com>
Subject: Re: [PATCH 5.4.33 0/2] Fix for long operation cmds busy detection
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Apr 2020 at 17:38, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
>
> On 4/22/20 11:47 PM, Greg KH wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Wed, Apr 22, 2020 at 09:32:27AM -0700, Sowjanya Komatineni wrote:
> >> This series is to backport the upstream patches that fixes busy detection
> >> for long operation mmc commands by implementing Tegra specific timeout
> >> callback to switch between finite and infinite HW busy detection wait
> >> modes.
> >>
> >>
> >> Sowjanya Komatineni (2):
> >>    sdhci: tegra: Implement Tegra specific set_timeout callback
> >>    sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
> >>
> >>   drivers/mmc/host/sdhci-tegra.c | 33 +++++++++++++++++++++++++++++++++
> >>   1 file changed, 33 insertions(+)
> > Any specific reason you did not cc: the stable@vger list when asking for
> > stable patches to be merged?
>
> I added Cc: <stable@vger.kernel.org> in Signed-off area of patches

I think Greg meant you actually need to send manually backported
patches to stable@vger.kernel.org. This helps Greg and Sasha to pick
them up.

Kind regards
Uffe
