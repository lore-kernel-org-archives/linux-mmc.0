Return-Path: <SRS0=VXdQ=EF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D1C4741F
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D10F206E3
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 14:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWB5OC0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgJ3OlU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3OlU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Oct 2020 10:41:20 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35FC0613CF
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2020 07:41:19 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id q20so1783794uar.7
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2020 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72WYhmHhRIUV7VxzEgGJ4A6OwqvnvgelCtR0uWkddiY=;
        b=iWB5OC0LnRRLwty1Km5QQriQoOHJ3pYb3ZVR+sAdW8IayhXLPGMDO+04BcWlQ2NSNa
         u1K1H9cLDj8aLljJzpGLoaOJMHohXRTMPkho+c1Hlqh6Fp+QXe9dN8DnfATK3pHw9vmv
         XPe0L/RolpCVdUwQKDeuGdcec2gziQ+L3ynn7up+v8+FTkYI3guPm9dVcNvrUwkuZkY8
         PGJWUcY5WEDofxPTj5BZ1rOxwXwoUHi2540hU5saRwgaqnYbpKS+ZLeLIrWfjIpifp73
         xJmJff0tJ2EOF0tN9636y7nkr/4msjJjCFJw9mIOgZg7SypDMYz9PHaQ6PuM0T3vLsXv
         sA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72WYhmHhRIUV7VxzEgGJ4A6OwqvnvgelCtR0uWkddiY=;
        b=BKEDgnJJXXpP9hjZzPhM1TC3S3aqorAW+AOmVqKskiFoLnmLkeNOkkoNMlMr47YvYb
         k+69QizLrLPUlnyo5izsa4PtrC96BBJNRXQAWm6BJBwc0i7gn8BTBu/038IB7jUcH7Lg
         +ODjnE3dVk4S5yU5KoJP03X+rnX8W2H3xJrFeE9aS9IhN5f9kGAh1svbv6qVjNcGoq77
         qiyJ014rob87gs7gzXOShGwW7jxpgOMGgwNGe5eaqZWQbVADIsa+wdiu34i4qvu7y6Zz
         NKj6AO5zhK2/YVrIPZmnm4pKfAfbO9yhmfq9yhIeRCfQWt8ShRkus9n3qM8D9FTUoSmk
         GWWg==
X-Gm-Message-State: AOAM531rQGGe3xVj0902IzdVBD4oWWKI4fFa97ZqAxwd7qKd9z1uMrTT
        4VyF2ThJdYw6W0q87huTVfMI7Zy2sk9Wzqjye52uxQ==
X-Google-Smtp-Source: ABdhPJwxe9C7rytQC1jfTIUBghGvjFItUZsLZn+oUlGSeWhSxxP9UPZSyvqyaaFYLux6B1upb8uRKC+oOgnA1kSuDjE=
X-Received: by 2002:ab0:140e:: with SMTP id b14mr1668835uae.100.1604068878220;
 Fri, 30 Oct 2020 07:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <1602581312-23607-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <TY2PR01MB3692EB14470C517E771746E0D8150@TY2PR01MB3692.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB3692EB14470C517E771746E0D8150@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Oct 2020 15:40:41 +0100
Message-ID: <CAPDyKFoSd6+i9Od1tmodNjPVG_4GU2YAnyLMs9a7C36SBzn+rQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] mmc: core: disable power off notification when host
 is removed
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Oct 2020 at 14:02, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Ulf,
>
> > From: Yoshihiro Shimoda, Sent: Tuesday, October 13, 2020 6:29 PM
> >
> > User is possible to turn the power off after a host was removed.
> > So, disable the power off notification when a host is removed.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  This topic was discussed in a few month ago [1], and now I could make
> >  a patch for unbinding the mmc host. I'm not sure this is a correct way
> >  so that I marked RFC.
>
> I would like to drop this patch because my colleague found an issue after
> he applied this patch. The issue is the following timeout happened if
> we unbind a host controller right after system suspend because
> the _mmc_resume() was not called.

In principle we would like to run the similar operations at "remove"
as during "system suspend".

>
>         mmc0: Power Off Notification timed out, 100
>
> I'll make v2 patch in next week.

I will have a closer look at your v2, apologies for the delay in review.

Kind regards
Uffe
