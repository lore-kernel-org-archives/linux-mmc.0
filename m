Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C44C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 13:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F86A20829
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 13:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0JX+yMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgESNzX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 09:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgESNzW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 09:55:22 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC9C08C5C0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 06:55:22 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id f9so2664555uaq.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uTwCBDDs4EthcdAW00VJw+6HTab5xcK1MQrTPFjNlY=;
        b=L0JX+yMIQUuJ9ARnYnhxf8wAwkfFqaJmwlk97rHMfOVOrDHtjRW+uWulM2og0dVNx8
         4Jp8a7DSAm4ye7UGZ3K9dLPcbUth+axEYs/MH6KSvC0NY239csAabHI/XU1ZaFP7z7e6
         oLHMxwGKMlhTno/+Ehea2uLq62RzOgud3GlN8BGu0t+T8dHEBplnlNH1iyH1Z50LK/hV
         LfZe6oM0agEGwZAOt97GlCSgE6WJoqvBt4KhRqQClpLbOflTC5thkuTGm6EQcBC6VBzA
         w4lk6JO1Ezb9tDTNJm5S6/Gilpb74kkNJUswA8AZbKATUM5AGSj/pgQ3RckKIaZw+TE+
         1xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uTwCBDDs4EthcdAW00VJw+6HTab5xcK1MQrTPFjNlY=;
        b=kBa66RnvDOCrc4hKJSZQQHR1BLfCR7vTxYdj6YX56aAqxSCcK+6TeqWTPmSuc70psL
         cK6CPEuc6EeeOPsPpKwnpK7N7q1fXdyNWdEJ3Wv23aB/WUhPCUqFZBI9JQ2jUsVmXNsL
         mxgeflq8DuAEVZC2d0cU/CNFkdfUne0qz+2AKlXF0VxhI5HzRpzqch6gE5rz2Qun+jns
         w3rb5ST+Hxc7npalK3X/3f1KfNyr5JUZp3KWrCQO8sM3IptLpp+dHGu+AI0xySuWQWnb
         8bXiHTrW9wAuqzPJyPLfFsSAp2C+ek+L5Z4pnnmNEIiCn5QJtFxysA8TN1aRiAT8lsAA
         w5lA==
X-Gm-Message-State: AOAM533vgDUel6u0rxXpu1osxVH4lK0A7T11WNFLwjPUXchQEwZKxq6v
        rvE3SBqV32yLizZ8MPOoUMn0nokpHWCevlMH4CFIEg==
X-Google-Smtp-Source: ABdhPJyfejL8MlbpYT/yUhtwfQIj82SAO54MnV6iUP0BbPafQvG55WOAJOyOFhPbas48pu8IvFbzpoAaCSTMIo+rNXg=
X-Received: by 2002:ab0:7293:: with SMTP id w19mr14983055uao.129.1589896521587;
 Tue, 19 May 2020 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato> <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
 <20200519084653.GF1094@ninjato> <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
 <CAPDyKFr0Pfge4tm5MQmnmjx7Pvjjf16tLr47wYiR-2ys69Ux2A@mail.gmail.com> <20200519113545.GK1094@ninjato>
In-Reply-To: <20200519113545.GK1094@ninjato>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 May 2020 15:54:45 +0200
Message-ID: <CAPDyKFpepDt5SyqLJ9-3HfutiW9TSP_jLg8zmqLn-O6LAy+RYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 13:35, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > This means dev_pm_domain_start() is needed only for the SDHI renesas
> > variants. But on the other hand, it doesn't hurt for the others (the
> > uniphier-sd variant doesn't even use runtime PM as confirmed by
> > Yamada-san).
> >
> > I don't have a strong opinion, but it looks like we can either apply
> > $subject patch as is, or modify it to make dev_pm_domain_start() be
> > called only for the SDHI renesas variants.
> >
> > What do you prefer?
>
> Dealing with PM is confusing often enough. To keep it simple, I'd
> suggest to avoid unneeded calls. It may take a while later to rediscover
> if this call is essential or not. So, for the uniphier case, we know it
> is not needed. If we agree on a best effort basis that it is also not
> needed for tmio_mmc, then I think we should keep it only for Renesas
> SDHI.

Alright, I re-spin the series taking into account what has been said.

Then I wait for your tested/reviewed-by tags before applying.

Kind regards
Uffe
