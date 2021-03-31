Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C97C433C1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925F2619BD
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhCaJmd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbhCaJlv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:41:51 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFACC06174A
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:51 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id q18so5924968uas.11
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKe3IgKQ1DyHwWEmeyynFwG3j1ESWshkgj42VJBCW9g=;
        b=bXtuCwlhJ1Zlobw/ajgZAQjX2St2EoM6EArGxmk/B5gazdKGKDyXYbLpOwrJpFPMg4
         K3lI8helKiyyoOZoOxFqaeOwfHd6YFTtIfhsv7ER1zpX/0uJluKdfNoN1r3Ayk68peRP
         ato4/279FjYRu3N7sSLE/hMYxhZYgsFqac2KaV+APP4de6+79+XieTxXMqJP2BU025pW
         afbL+/nFUJY8/tY4IDojHROZq9YILAE52o0hPBS7phZZsq2/1RFiWEY0sUfULrRoRz1h
         ojwSIfyQk/ISouEmCdWgSbeXTfQU4B3jG5JzoAVbZcO0ptNa7HdY9YM4osOqSQ0/O5ye
         IXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKe3IgKQ1DyHwWEmeyynFwG3j1ESWshkgj42VJBCW9g=;
        b=mRJFRS91zaXGjiiBSO0ww++pG1utVdWtL77F6dnEsxDVQwm9t7Z2cj/uRSxClg2sEA
         a8IYODlxYPzrCa9rz396eTjF98YxQAnoEUBkyebKYDCGJrm1QN0+KYGgSW2s4GPXOtXy
         +ZCVeu8TEuxBoonKG85M/olu+ciefmakxwab/or7WhLJXt/4AIHcAOKIWQN9dvmWYYe9
         8yAMTzslwg8wF9tYhumZrNDU2JZBmEMjOHYDpQhyJZ2bTy3NJbuybZ3oFy/igHZaqdag
         fhLQmbUUu1h9BUlN0IEquYx69JIUtFgM2lkjL7TC0FiyAPmURUMyFBzG3dvtnw76hUf9
         /8MA==
X-Gm-Message-State: AOAM531PRfWMW2WmMsn/dEhHy4PF2ao9ZcDKkhVi6ZnbhYQNdDkPtNRz
        8gHjfwNZ/ttGZLx+tbAjc74hNI8RFhmZnMnsdLyu1GAge9/1LQ==
X-Google-Smtp-Source: ABdhPJzLaMiQ9oeEbPJ0xGEaNeaEoTNPkMRL0SciRWxlCafZrhcU6tDzxDRbSwrqShPH2Y+XFxnbnUdyDaViKW/aFvI=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr766022uak.19.1617183710525;
 Wed, 31 Mar 2021 02:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <761908730.16636212.1547560102824.JavaMail.root@zimbra64-e11.priv.proxad.net>
 <886907785.16708970.1547560575203.JavaMail.root@zimbra64-e11.priv.proxad.net>
In-Reply-To: <886907785.16708970.1547560575203.JavaMail.root@zimbra64-e11.priv.proxad.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:41:13 +0200
Message-ID: <CAPDyKFp5MM8m7DtH2REgsf83S9r5P56_JNToX2b-w2G1VVtE7w@mail.gmail.com>
Subject: Re: [PATCH mmc-utils] Add various SD/eMMC vendors to table
To:     Stephane Fillod <f8cfe@free.fr>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Luca Porzio <porzio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri, Luca


On Tue, 15 Jan 2019 at 14:56, Stephane Fillod <f8cfe@free.fr> wrote:
>
> Part if this list update comes from a compilation of this web site[1].
>
> [1] https://www.cameramemoryspeed.com/sd-memory-card-faq/reading-sd-card-cid-serial-psn-internal-numbers/
>
> Signed-off-by: Stephane Fillod <f8cfe@free.fr>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>
> Apparently, the list of Manufacturer ID's (MID) is kind of "not public".
> To make things confusing, one MID may be used by several manufacturer's
> (unless reading oid, etc. ?).
> Hence the table has to be compiled manually.
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 9737b37..98c0c4d 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -112,7 +112,7 @@ struct ids_database database[] = {
>         {
>                 .type = "sd",
>                 .id = 0x1b,
> -               .manufacturer = "Transcend",
> +               .manufacturer = "Transcend/Samsung",
>         },
>         {
>                 .type = "sd",
> @@ -122,7 +122,7 @@ struct ids_database database[] = {
>         {
>                 .type = "sd",
>                 .id = 0x1d,
> -               .manufacturer = "Corsair",
> +               .manufacturer = "Corsair/AData",
>         },
>         {
>                 .type = "sd",
> @@ -134,6 +134,11 @@ struct ids_database database[] = {
>                 .id = 0x1f,
>                 .manufacturer = "Kingston",
>         },
> +       {
> +               .type = "sd",
> +               .id = 0x27,
> +               .manufacturer = "Delkin/Phison",
> +       },
>         {
>                 .type = "sd",
>                 .id = 0x28,
> @@ -144,6 +149,11 @@ struct ids_database database[] = {
>                 .id = 0x30,
>                 .manufacturer = "SanDisk",
>         },
> +       {
> +               .type = "sd",
> +               .id = 0x31,
> +               .manufacturer = "Silicon Power",
> +       },
>         {
>                 .type = "sd",
>                 .id = 0x33,
> @@ -159,6 +169,21 @@ struct ids_database database[] = {
>                 .id = 0x6f,
>                 .manufacturer = "STMicroelectronics",
>         },
> +       {
> +               .type = "sd",
> +               .id = 0x74,
> +               .manufacturer = "Transcend",
> +       },
> +       {
> +               .type = "sd",
> +               .id = 0x76,
> +               .manufacturer = "Patriot",
> +       },
> +       {
> +               .type = "sd",
> +               .id = 0x82,
> +               .manufacturer = "Gobe/Sony",
> +       },
>         {
>                 .type = "sd",
>                 .id = 0x89,
> @@ -219,6 +244,11 @@ struct ids_database database[] = {
>                 .id = 0x70,
>                 .manufacturer = "Kingston",
>         },
> +       {
> +               .type = "mmc",
> +               .id = 0xfe,
> +               .manufacturer = "Micron",
> +       },
>  };
>
>  /* Command line parsing functions */
