Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74207C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527C320724
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIZFcuyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgGFOti (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgGFOti (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:49:38 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8547C061794
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:49:37 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e15so20732965vsc.7
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThoUX3D4D7XYDMfUPpe8rFPmFr4x1le4oAww+2aOLQU=;
        b=oIZFcuyhuJq7rKyk7cftCjXUqUaBvDJaEJUs98RkIVgptfVcm/lspLDAISpPcK2olh
         aDnh2aIPV8ltxg6nQ7tXVXzSycX9oyYp7cWpwTSxfkSMwtDEfAuK09HHF3iiscYRSX+l
         AsPwcMjtUglgdCpgrR2J98ajL9A6gmsKMdAgCwqry8uIY7GDZy/f8/WjG+sk4YfdTwKc
         FmPd2ND5N6QdpqI36kM7ddceAEgNI6aNj7vKrvsMA4XKcTE1tnh4IZwCZiD/KoD1N7Lo
         6urgQ3ziTlhMBzG5FlPDJFLxG5UM9Bc7d0ZknkfMNnYnIx4fCHUv4V6a24NHxOK7n7uv
         l7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThoUX3D4D7XYDMfUPpe8rFPmFr4x1le4oAww+2aOLQU=;
        b=aHOCdCXkLL4Va+oqba50OY895DmyrQ9YMP/R5bU0cNCUbuR/q1D8I0fIekvdk4N/qQ
         0v0oX2GxpKQcFETQ4ijI24cI+lE9ZeHCza6ZIOrl6oKELRqew2YHcP+Q73wni9t0ETqV
         5D2sxeFEFZ3HRPunBnLpbMKqQjq2dFeAbhIT1Evuk0MNBtznCRGGIq4yzWawoaQrO7S+
         nOggk0ylHTIV7QjvOzU+vNOu1iThjUSMwkPP8K2zv9a4ZhhC9sRaAz3caFKPvtYGYq6a
         bsz+3v3K7Y8sJQBTQtY77Nor3f1GQmyA0Y47L9lciZlSmn0D3CVqBFcxt7F/iYeF+l/C
         OzdA==
X-Gm-Message-State: AOAM531+pUubJ8EmbVhV5fnsQXzt09vw/bA2ASC4nNYveNuB30eqVYnp
        H0iIhafE13YYe4ngn+Yvmns5KPI/4V1zv3BZmGvRw3I7g+Q=
X-Google-Smtp-Source: ABdhPJzIeo+wEv+tl+o7ithHrJO/3zOmz+2jDe9x99k5Ft/dAWm8KTIGDp1o3RWzP9h9tcgJ8W/bjkuSbtljJB16s6c=
X-Received: by 2002:a67:f888:: with SMTP id h8mr15842779vso.165.1594046977165;
 Mon, 06 Jul 2020 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200621025330.10561-1-mani@kernel.org>
In-Reply-To: <20200621025330.10561-1-mani@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:00 +0200
Message-ID: <CAPDyKFp3njgxgt0p2vFueC+6c4UDsaCfF9udXyRb-Juz4=G1=Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: owl-mmc: Get rid of of_match_ptr() macro
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 21 Jun 2020 at 04:54, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> Remove the 'of_match_ptr()' macro to fix the warning when CONFIG_OF is
> not selected.
>
> drivers/mmc/host/owl-mmc.c:677:34: warning: unused variable 'owl_mmc_of_match'
> [-Wunused-const-variable]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/owl-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 5e20c099fe03..df43f42855e2 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -689,7 +689,7 @@ MODULE_DEVICE_TABLE(of, owl_mmc_of_match);
>  static struct platform_driver owl_mmc_driver = {
>         .driver = {
>                 .name   = "owl_mmc",
> -               .of_match_table = of_match_ptr(owl_mmc_of_match),
> +               .of_match_table = owl_mmc_of_match,
>         },
>         .probe          = owl_mmc_probe,
>         .remove         = owl_mmc_remove,
> --
> 2.17.1
>
