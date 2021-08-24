Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DFEC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E650561248
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbhHXO5r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbhHXO5r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:57:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94BAC061757
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c12so38228808ljr.5
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2oblrlmjsR9NUU9dfVxmHTRoBpwqR6jaG552BggpAbE=;
        b=ZnXSCScSrf0kcQz7PCh0RxZjMfGZ7V5NPOp7e20NLR1to0ulH4e7uZm1Djt7UviHzV
         wptAAJovr5BJ6YikPaJ7G3keNBXrWXzBGZVcNJngcYLFK5pkzrCzbbQ3y6TG7FZe6v5n
         vywqTSwKY7XicP4H1hReq7p/UIG0pvcfek7AWwacIrxYzeLWamJhrZ1x+tRpKRj5UUdz
         Htq1gdA7dxis+romLHbmF0sfpKmNhhhZmz/OzEvQMS8FPJ7hylbeZOO1xsmmkXIt7ucr
         JVhO7qtAsF1UGswHuijaucRtmHVAP0fsN1BnaWJmIrMvO3BmAaczPeKQlKSPqUwy5ewi
         ZqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2oblrlmjsR9NUU9dfVxmHTRoBpwqR6jaG552BggpAbE=;
        b=GmMswIk5/mM6LNFqY1E8Usn9SIpCcf84slCo+ln6k/MwmgeyvSpAtrPrkhCnxdDqIK
         x/3DFHgf/M/GOC5EDQjLaHcDb9jibuUlanJB8pC4IQ9SAEg0gmSWNx5hSYtLgRix15wH
         CKzUSE6f70biUuL2gZYb52e/o33OLPHvPDmn5i0QKbLcqVEhQ8ukEzB3OCCYxqagnxZx
         q25gw1hlvkpLDdwq1j9zD8Hu3s2aBxlVoeUyaFoYcb4IGeT5vTHvhqYZjpIZsSdloe4k
         GpdL5yceHLdrLayo+vSkjZlQ3FCh2Q6SZOdImdv4OTNLAMAm2ogeOJ2wFeT3dcG38v3u
         869w==
X-Gm-Message-State: AOAM532fPyHUtfNmXY00kAJuCMcM4qiNhr0V9fQZjJi1NYYTBff9zx9s
        ireWrJyJLscQ8MwDJZS46jzfR+aWnws0utfJ0i1R3w==
X-Google-Smtp-Source: ABdhPJzQ86EdLGjD1o74c6cdmN+x984foxJXaDww3SV4fgc2uTSkHIoU7BD8eT9ZURxCNPoY4BND2iceLRll1uvenNQ=
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr32626391ljq.76.1629817021103;
 Tue, 24 Aug 2021 07:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210816153054.24082-1-marten.lindahl@axis.com>
In-Reply-To: <20210816153054.24082-1-marten.lindahl@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:23 +0200
Message-ID: <CAPDyKFq=uWkGUhVsp+eEDWV76M+b4_BvzE_ST6amnE4q6m9WpA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Update card_busy callback info
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     kernel <kernel@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2021 at 17:31, M=C3=A5rten Lindahl <marten.lindahl@axis.com>=
 wrote:
>
> According to SD specification checking state of DAT0 only is enough for
> polling card busy signal. Header file comment says DAT[0:3]. Fix this.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  include/linux/mmc/host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0abd47e9ef9b..ff1a251bb0bc 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -153,7 +153,7 @@ struct mmc_host_ops {
>
>         int     (*start_signal_voltage_switch)(struct mmc_host *host, str=
uct mmc_ios *ios);
>
> -       /* Check if the card is pulling dat[0:3] low */
> +       /* Check if the card is pulling dat[0] low */
>         int     (*card_busy)(struct mmc_host *host);
>
>         /* The tuning command opcode value is different for SD and eMMC c=
ards */
> --
> 2.20.1
>
