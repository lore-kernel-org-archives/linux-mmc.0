Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DCEC3B18B
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28272168B
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="am2Y+lTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgBMN4i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:56:38 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44961 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgBMN4i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 08:56:38 -0500
Received: by mail-vk1-f194.google.com with SMTP id y184so1579584vkc.11
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbEyJ21Wf9TmNm23pf1q3FJLQ8N1jweEBZj6TLt1LRE=;
        b=am2Y+lTIT9fwoz2AhrUHtsloqIktnGle3RujHx7lfx1vPOKl9bQkMAI3DbpljnNoHE
         JICRqh81kAup9Z0GEWuLxDfKXhqeyoPr5NBCfkZqUTE15OXoKyn6hl1xWiufbfwDHt/F
         1oTyqR/807K+rpYHTOG24XoIjHMgCtYrr9av8w06OOynflcyMmLDX/N553GT38QxUZ3q
         NFK7uxSXb8g/YufF3ZVjhJcVOIOeNrOtLX33w+XCM6stolptSA6GVgoS6KRw6DsGraX3
         z9NHKwWK6gyTF8GRgDWO7MxK99qOFdwHWQCBEHGyLE4xHAC1G+pp2UqN2k7Y7dWVMeOv
         7fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbEyJ21Wf9TmNm23pf1q3FJLQ8N1jweEBZj6TLt1LRE=;
        b=PFIB23RD/hJL5r+Ila9xRi4EqafuCNxOAQPq9M+aZmg0tK+EG59gnfe2oyXwrMvOwU
         dFRXt56LMKT+fEsqX69EbnVuZBfqnAQwdH7Tb6a0qQXwR/g79eMaDkHZW6M83DQY+y1l
         r/ih7tgDLSuYEDVsYCQ1JV14JOUzZug7sJmgE50ghGRskcZB+Hj7KFUzR/vfgsGLlJYH
         uqkikQDtqKUgzDXDI3HVd7P98Ib3Vsf+kRPio16Iu4JuCxAhyQjJ1hX5lN2NasUehtvf
         AtgZsv4JPZclXK96dqjDrUZsgrFETxA94cQuFc1FWPQ9a2pqE6wmVvEn9eFyRPDBsWYZ
         xdyA==
X-Gm-Message-State: APjAAAURNIAaSA2d9XTW1sriEP46h4G6jvXkMZTpM5W89FhAHL5hsPGG
        FrVbBf9VJzpS0zlXZ6YQ55tujFXFdV7LeGfeAF3PbA==
X-Google-Smtp-Source: APXvYqzRxbW4HihWBIY06dzcLa0pS5WJr+ORNm3BtPDYcpkgz9cVn3dIAPYdWtjINrqQDBEjNzagjjCBL7mmkrHcZhQ=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr10527889vka.59.1581602195953;
 Thu, 13 Feb 2020 05:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20191217114034.13290-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20191217114034.13290-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Feb 2020 14:55:59 +0100
Message-ID: <CAPDyKFraxLHHRDbumxWUo9bh-Qq_xuQMerdpZfjmkYp5ai_kAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mmc: renesas_sdhi: add manual correction
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Dec 2019 at 12:40, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Add manual tap correction because the automatic one fails for HS400 on
> Gen3.
>
> Changes since RFC v1:
>
> * rebased to mmc/next
> * added review tags from Shimoda-san
> * fixed "enforce" in one commit message (Thanks Geert!)
> * new patch 3/5: I think it makes sense to incorporate this patch from
>   the BSP here already because it enhances manual correction. It could
>   be argued if it should be merged with 2/5, yet for easier review I
>   left it seperate for now
> * new patch 5/5: a cleanup I came up with while working on 3/5.
>
> I kept all tap_related variables 'unsigned long' for now. Geert has a
> point that some of them could be changed to 'unsigned int'. I'd like to
> leave this as a seperate issue, though, once we dealt with the other
> HS400 issues. (Yes, more patches coming...)
>
> I did some more testing but with my environment here, I hardly see taps
> changing. What I see is that with HS400 RVSERR is regularly set but
> SMPCMP is all cleared. So, this series maybe saves some unneeded tuning
> for me. But I think the relevant cases are created in a lab, so some
> more testing would be much appreciated. We definately want to wait for
> Shimoda-san's comments before applying this.
>
> This series depends on mmc/next because of this other series:
> [PATCH 0/5] mmc: renesas_sdhi: prepare for recent HS400 updates
>
> A branch is here:
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib
>
> Kind regards,
>
>    Wolfram
>
>
> Takeshi Saito (2):
>   mmc: renesas_sdhi: Add manual correction
>   mmc: renesas_sdhi: only check CMD status for HS400 manual correction
>
> Wolfram Sang (3):
>   mmc: renesas_sdhi: remove double clear of automatic correction
>   mmc: renesas_sdhi: enforce manual correction for Gen3
>   mmc: renesas_sdhi: cleanup SCC defines
>
>  drivers/mmc/host/renesas_sdhi.h      |   1 +
>  drivers/mmc/host/renesas_sdhi_core.c | 104 ++++++++++++++++++++++-----
>  2 files changed, 86 insertions(+), 19 deletions(-)
>
> --
> 2.20.1
>

Applied for next, thanks!

Kind regards
Uffe
