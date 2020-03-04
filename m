Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D282C3F2CD
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8FA2467F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCiMaYRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgCDPfY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:35:24 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43464 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbgCDPfU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:35:20 -0500
Received: by mail-vs1-f65.google.com with SMTP id 7so1402904vsr.10
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00Rmwnfg0e8r9SY74u4uZcoPfhjgx61DXTReZJdbiIk=;
        b=nCiMaYREzujENq6r9s3oF6FobXuqD+FjnzxchAvr0xEXY3BDosEUmf0+KT3MiYXaJE
         u6FRN2vn3Gag82PCLB6dOe/67ac8j6AYYwYH/FJHy6IX/AxlXrWSPtmLfjHuIAR4s0dv
         fGGG7ByifG5zUY+D0jTOjIhUOVQO+vp8wk6GBYytGWwtLUTZ4pY9f8/2gbkZLks8cG7d
         AmPheQioOaLxCiKBCB9Y0U79GQXzhXDKLz6y8RMUSEbmwDNWLZzVBOHFve/MsqFc4ZX9
         jAQPleE++XM4XCrTKuEN5jE/ipg/CDvvhpI4y2TgGv3PweP86DhQS9/JUyYiCleXy5nP
         saYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00Rmwnfg0e8r9SY74u4uZcoPfhjgx61DXTReZJdbiIk=;
        b=AlDQX9OMQVkHwWgbOaSdnbcI0GQFC4mzwDYuueK7yyK10GHA+KcjTXeTIZDNSVrEyN
         MykxaJE2exCjiO0TyA1aF/Aid7U38CKOO8AOGPsWzXX19gHphfty/pNTLeLRQpEhHbre
         uB57oyy7dyez/dHtyTOi9ggrWObeHm3yDG9Jnsu8Z3H8nLZfQhgW1jrzyET+4Sh24zaH
         Hy7KlJPQpZpiGL4kFc9kTKcZrMUMk04/sbYIzZOvLd2qwMjcTdHfX1rslSToyCvQiDnk
         j1OhwoTyAslJ+Va8Hc+LIx4rb/igEzOcMN9Xq8MBgOTIi0JeotPcYZK0uDUhes+U5J8a
         rhow==
X-Gm-Message-State: ANhLgQ3zPeh5DeGJ+THwr4vw0U4i7cMBoDL/P3TNjTEBaZW+WY1WOe1Z
        V0yem8Di9NDu6sYFUGe6ow67z1R/H2GRlqZve7Zavg==
X-Google-Smtp-Source: ADFU+vs9hDVln8eSdHw8W62ASMunkWacXNAeeWvHb8JN1bWM8m+X51t4UiXom4UigR9Y6SsrcdqmR8ZMgpiqOySQX6s=
X-Received: by 2002:a67:f4cf:: with SMTP id s15mr2024818vsn.165.1583336119283;
 Wed, 04 Mar 2020 07:35:19 -0800 (PST)
MIME-Version: 1.0
References: <1581434955-11087-1-git-send-email-vbadigan@codeaurora.org> <1582545470-11530-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1582545470-11530-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:43 +0100
Message-ID: <CAPDyKFok8p+yuokLBZX3RF5U6SQYMKKeDf=co1-WzotBQzprQg@mail.gmail.com>
Subject: Re: [PATCH V3] dt-bindings: mmc: sdhci-msm: Add CQE reg map
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Doug Anderson <dianders@google.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Feb 2020 at 12:58, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> CQE feature has been enabled on sdhci-msm. Add CQE reg map
> and reg names that need to be supplied for supporting CQE feature.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since V2:
>         - Dropped _mem suffix to reg names.
>
> Changes since V1:
>         - Updated description for more clarity & Fixed typos.
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 7ee639b..5445931 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -26,7 +26,13 @@ Required properties:
>
>  - reg: Base address and length of the register in the following order:
>         - Host controller register map (required)
> -       - SD Core register map (required for msm-v4 and below)
> +       - SD Core register map (required for controllers earlier than msm-v5)
> +       - CQE register map (Optional, CQE support is present on SDHC instance meant
> +                           for eMMC and version v4.2 and above)
> +- reg-names: When CQE register map is supplied, below reg-names are required
> +       - "hc" for Host controller register map
> +       - "core" for SD core register map
> +       - "cqhci" for CQE register map
>  - interrupts: Should contain an interrupt-specifiers for the interrupts:
>         - Host controller interrupt (required)
>  - pinctrl-names: Should contain only one value - "default".
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
