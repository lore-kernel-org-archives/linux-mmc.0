Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B79C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 07:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C37C2082E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 07:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f73+xuTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLQHKK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:10:10 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45192 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLQHKK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 02:10:10 -0500
Received: by mail-vs1-f67.google.com with SMTP id l24so5814605vsr.12
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2019 23:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KU8CAPtvuhse06hr90b9dQyZJ0RcLzLLBYygDj7RpYE=;
        b=f73+xuTLOhYg447Etp1UGvz0Nw5QbYQTmtQjGZVxXslopSHUazONjxi7qkIDEoiuMa
         sI1WVlVPh2MDC5kEHokvVPJR+B+6gKELl9tClD+ZL3un5yJtW6VIoF2J0PVVVzMLOH5J
         /+hT7Kr1xmmaEHBuvGayiJ+ztJuvD4TFMt/Sl1+EMovL/0g1t6a8ymNQbq1w+X57IIbq
         ik8NtbSobnAYH9ro/5FV3IBRNTNB9nQ3Fi7XnuzYMMFjulS4pJ5GxZ1rBsch30pygzqa
         kvncc1eHKpGisFK/vXwDBacao6TLpXTgpMwqV2+3CkdD/inBZ1+K8gYulqHAbN8Aq6af
         6WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KU8CAPtvuhse06hr90b9dQyZJ0RcLzLLBYygDj7RpYE=;
        b=EYyog1TdekIdd1z5lXcRFIs6RBSPEYZT6BETruKPSNAnCHXBSkaepdpMWzYO2NJMus
         XpSYq0gPn4X3+rtyYUwRZ/+sCGs+d9UgiN6hh9mBKwQnU4U4iGEtY7aTkvFUxwJIrVrw
         x/mfwm7+o/xGbxh3PKOBgd4Pj8MqX14hJn/Nzdo1cRpaUjiiKsggD70TxgwIt8gjIr3/
         KDFgi8OoV6PXgS8FM8gmczY7ey/Kk6PZz8on5tOwPjhxoSYn6+/glhtXPqeWTOmIHTzL
         shOx+bu5mcRlf2xHXnP+Le7A85aticyrz6WMeR5lguVCEfOrC7WAgR3gfq1b2pAtT98l
         VnJg==
X-Gm-Message-State: APjAAAX96UqB84qn7oPSSLNCoX36Lq9SwHnVNcs2yT2fNlaIV5Tfk0gW
        D7OI23mFyDWoRwmK++kvayeLLS7xoh2E27+YpMMvnQ==
X-Google-Smtp-Source: APXvYqyZdb+OyBuwMDMu5mBCc6jbO6f6HiU3/QineNXIDOYt6E1TcRXbLb7c9SLxhJNoOdqpcKIR5USqSW1I0wElePM=
X-Received: by 2002:a67:ff82:: with SMTP id v2mr1965241vsq.35.1576566609452;
 Mon, 16 Dec 2019 23:10:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576540906.git.nguyenb@codeaurora.org> <628141610bd44235b0cea04ff110dd4c67027aba.1576540907.git.nguyenb@codeaurora.org>
In-Reply-To: <628141610bd44235b0cea04ff110dd4c67027aba.1576540907.git.nguyenb@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Dec 2019 08:09:32 +0100
Message-ID: <CAPDyKFo3sbq1awpiAr4unYadeYnw04eV54P2UA9k0po-0kWpjQ@mail.gmail.com>
Subject: Re: [<PATCH v1> 1/9] mmc: core: Add a cap to use long discard size
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Dec 2019 at 03:52, Bao D. Nguyen <nguyenb@codeaurora.org> wrote:
>
> Add MMC_CAP2_MAX_DISCARD_SIZE cap which allows setting the max
> discard size value if needed.
> Setting a high value for the max discard size is to fix an issue where
> some SD cards take a long time to perform the card format.

Can you please explain elaborate on why the SD card takes a long time
to "format"? What goes on and what takes time, etc.

In any case, it looks wrong to add a host cap to solve this problem.

Kind regards
Uffe


>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  include/linux/mmc/host.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba70338..f1a767d 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -348,6 +348,7 @@ struct mmc_host {
>  #define MMC_CAP2_FULL_PWR_CYCLE        (1 << 2)        /* Can do full power cycle */
>  #define MMC_CAP2_HS200_1_8V_SDR        (1 << 5)        /* can support */
>  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can support */
> +#define MMC_CAP2_MAX_DISCARD_SIZE (1 << 8)      /* use max discard, ignoring max_busy_timeout parameter */
>  #define MMC_CAP2_HS200         (MMC_CAP2_HS200_1_8V_SDR | \
>                                  MMC_CAP2_HS200_1_2V_SDR)
>  #define MMC_CAP2_CD_ACTIVE_HIGH        (1 << 10)       /* Card-detect signal active high */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
