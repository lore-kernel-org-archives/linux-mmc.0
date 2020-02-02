Return-Path: <SRS0=Q3VJ=3W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE7C35249
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Feb 2020 22:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187282067C
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Feb 2020 22:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="HdW1c905"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgBBWMb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 2 Feb 2020 17:12:31 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54748 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBWMb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Feb 2020 17:12:31 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so5421836pjb.4
        for <linux-mmc@vger.kernel.org>; Sun, 02 Feb 2020 14:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGQujRAgaDCf8lJCNDZ0S36AK7TctHowW4/wCL3R4dg=;
        b=HdW1c905Bz2Z2DS7cOn6zroCHdRDeXojwk2e0seH6xlDO6tAO/ri7zZXE05NUITROg
         Z0hQillklyLwxAGFOpERzghSqwKkauHgA+4Av4o/iPU0AqgIhKXz28b+QbG2x+xgDX2k
         1I4s4eVPpmwb3MM1g227jrjnSGC+TqxZztqafuxzulfIHmyQ4ULJFwcr1VRp1C1MRpLz
         grrksSmJ2IQ5hRIQ7uc2ikk7Ni4Ra+n0Z7dPLMXR4+CdyZexJeDgRjMh36aUYT8RlHhv
         N75ylMhjuKI8nWiUL+JWvt4AfUCewSsMCddecKx90xuOs2Fzs99zKDzYZf6dfC2nDcoB
         n3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGQujRAgaDCf8lJCNDZ0S36AK7TctHowW4/wCL3R4dg=;
        b=lVKiQEJdY+hvonuQAQmm41v5BEcYXT/LtmlozyVfwXRuioa4oHJpLAI16mhr8+Mh24
         tDTT50PSLHRcGpGOkZIfIQMFTyJV6HtUTAJcVZl1WAfH882cVxunZalNdEuGZTY5OOu9
         Ne6OACUVHEkE6VJA+EwYnbFYy54rX4tEdRYXcdTYYRbZE2PCcAPar+/HJb/WRFmTuOju
         XRWqV1KUg9AWPBRnXwoJljDxTaTRlN/RjzUhNpo830ERx7+tjb2nEtgSn42a6sNthRAK
         UPm9Pv0jfkfTJZsGdH93aiCWez+6RbXovSQhWrb3LiUsVI0kJocEsqvfpejduPF0Oo4Q
         3qfA==
X-Gm-Message-State: APjAAAUu2AuNXE5VfvOHWhnYH46qqjAYJrb2McR4UShzrZY5riJqw1t/
        6tFWhnXTyCsW7Q8PUxJOMjVfod9u/gD0DIE7JKvSPjvnhrYXLDk0
X-Google-Smtp-Source: APXvYqwuZRX0UT3wa8X9jm8Y4XzaTT+3vbqhAk3UY+ZiY+WRi8fgQ9CSG7DUjsBa092FHDeMrmIfiHnwsfzyyiw1TWQ=
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr20319259plb.202.1580681550270;
 Sun, 02 Feb 2020 14:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20200202150049.677553-1-jonas@threetimestwo.org>
In-Reply-To: <20200202150049.677553-1-jonas@threetimestwo.org>
From:   Jonas Danielsson <jonas@orbital-systems.com>
Date:   Sun, 2 Feb 2020 23:12:19 +0100
Message-ID: <CALDOjzjf9NwcYwSRbHo4SpFhgCt+Y2r_UnWJQcLqNrRZ3UDdug@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Add error injection via debugfs
To:     linux-mmc@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Feb 2, 2020 at 4:01 PM Jonas Danielsson
<jonas@orbital-systems.com> wrote:
>
> From: Jonas Danielsson <jonas@orbital-systems.com>
>
> This functionality was useful for us while debugging issues with
> a vendor wifi-driver that misbehaved on the SDIO bus.
>
> This will allow you to check how SDIO clients handle mmc
> command and data errors.
>
> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index a9dad641c..11289c8e5 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -328,6 +328,8 @@ struct atmel_mci {
>         u32                     data_status;
>         u32                     stop_cmdr;
>
> +       bool force_cmd_error;
> +       bool force_data_error;
>         struct tasklet_struct   tasklet;
>         unsigned long           pending_events;
>         unsigned long           completed_events;
> @@ -618,6 +620,14 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
>         if (!node)
>                 goto err;
>
> +       node = debugfs_create_bool("force_cmd_error", 644, root, &host->force_cmd_error);
> +       if (!node)
> +               goto err;
> +
> +       node = debugfs_create_bool("force_data_error", 644, root, &host->force_data_error);
> +       if (!node)
> +               goto err;
> +
>         node = debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
>         if (!node)
>                 goto err;
> @@ -1807,7 +1817,12 @@ static void atmci_tasklet_func(unsigned long priv)
>                                  * If there is a command error don't start
>                                  * data transfer.
>                                  */
> -                               if (mrq->cmd->error) {
> +                               if (mrq->cmd->error || host->force_cmd_error) {
> +                                       if (host->force_cmd_error) {
> +                                               dev_info(&host->pdev->dev, "FSM: forced cmd error!\n");
> +                                               host->force_cmd_error = false;
> +                                               mrq->cmd->error = -EINVAL;
> +                                       }
>                                         host->stop_transfer(host);
>                                         host->data = NULL;
>                                         atmci_writel(host, ATMCI_IDR,
> @@ -1939,7 +1954,11 @@ static void atmci_tasklet_func(unsigned long priv)
>                         atmci_writel(host, ATMCI_IDR, ATMCI_TXRDY | ATMCI_RXRDY
>                                            | ATMCI_DATA_ERROR_FLAGS);
>                         status = host->data_status;
> -                       if (unlikely(status)) {
> +                       if (unlikely(status) || host->force_data_error) {
> +                               if (data && host->force_data_error) {
> +                                       dev_info(&host->pdev->dev, "FSM: forced data error!\n");
> +                                       host->force_data_error = false;
> +                               }
>                                 host->stop_transfer(host);
>                                 host->data = NULL;
>                                 if (data) {
> @@ -2519,6 +2538,7 @@ static int atmci_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         host->pdev = pdev;
> +       host->force_data_error = host->force_cmd_error = false;
>         spin_lock_init(&host->lock);
>         INIT_LIST_HEAD(&host->queue);
>
> --
> 2.23.0
>

Haha, I just noticed that this is available from the general fault
injection framework. So sorry for the noise!
