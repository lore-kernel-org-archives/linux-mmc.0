Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B93CD8C8E
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Oct 2023 14:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjJJO2G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjJJO2F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 10:28:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE9A9
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:28:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so844244276.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948081; x=1697552881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G+bzCawygPfYZQRWEWjzk60GqJiz5rFfjOtmLh7nplo=;
        b=K4rP0Ygv/I4SvoYv70rISgW7p1M57QcSAw786+766t/xC+pz9fjluzqMY79BLKNhKR
         RUpCz8qq3rxbFVA81LG8yzezrYU2UZqCD04hbOxCoycJuPx0rcKPcPZJefUpIa4lyU1s
         F0yo12ixoH8ppEwSkgf7++kz5HhICvbERPg0HPJ4h6fS42k0DFKeRQhG4lSOThjQjFyJ
         3DcCpzrnekpd8MX8rNUxXWTwHVM93w5IyYyQgfLzT8tJ6Xx/vHoQBAtHjQSgAzNn7YtT
         6PqcEJ+x3uMdq0lP0yrOlF4+PEYDco0QfKRijPbOB8IOTbmPxRKKeXIeQR7GaW8+2lSM
         e+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948081; x=1697552881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+bzCawygPfYZQRWEWjzk60GqJiz5rFfjOtmLh7nplo=;
        b=h3AwGH+i78H18cYh1pQsvJH1ThyiZCLenZnygwT3eYdHpYKRJ2XoaIfQR+J28PiRwo
         KdyWg9SE7x/rEJLvpXugxEmxAjKj7U8AQMD1RywtOENfwb75IcnvW1yAowWF2FgHur2E
         ATRKZtCoi/2CXQbAZosRkdQ3eI8cGlD0IoR6Cr20j7SXhh4zdymoXltUPQD3i6imQePg
         3RTR9b5U4zsvJKo6X2E+/pC/t1V7bMd528erzHN4V0TuOiPzvJ9WaEj16xyJipAFsZRr
         nNuSb6obyNGdoEXMakCAxZjbicbzGjTbwF4lhFtrUl2lnqXNzS1AFXz2AIUn6GUFraBQ
         8H+Q==
X-Gm-Message-State: AOJu0YxDd3Lw3PZfabmjP5N52m6Eg0zaF0p6/E1ID8eiW6wn2qdrEtcg
        te4eLW5TlK0cam8Fbv4ztB8CE3xqHjMon6Zu2IYvSCzJ4D12Czco
X-Google-Smtp-Source: AGHT+IEWokDbVqlkMPFDHZLLeXvpDy2LcMylLq0K1tDaame0w/TBAEIlq4XoMo0X/ee88uUG+47+PxMN4Jyxd7+521A=
X-Received: by 2002:a25:6b4e:0:b0:d85:b09e:b9c9 with SMTP id
 o14-20020a256b4e000000b00d85b09eb9c9mr19897738ybm.52.1696948080773; Tue, 10
 Oct 2023 07:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
In-Reply-To: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:25 +0200
Message-ID: <CAPDyKFob43kTEXqf4-gXj7CQCpdn2nKHxoAsXv4nFgaQ88s-dQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: Allow speed modes to be adjusted dynamically
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 29 Sept 2023 at 09:45, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> During board verification, there is a need to test the various supported
> eMMC/SD speed modes.  However, since the framework chooses the best mode
> supported by the card and the host controller's caps, this currently
> necessitates changing the devicetree for every iteration.  This series
> provides a way to adjust speed modes dynamically via debugfs.
>
> --
> Changes in v2:
> - Replace module parameter with a debugfs file.
> - Add patch to move mmc_select_card_type().
> - Link to v1: https://lore.kernel.org/r/20220623080009.1775574-1-vincent.whitchurch@axis.com/
>
> ---
> Vincent Whitchurch (2):
>       mmc: core: Always reselect card type
>       mmc: debugfs: Allow host caps to be modified
>
>  drivers/mmc/core/debugfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/core/mmc.c     |  7 ++++++-
>  2 files changed, 55 insertions(+), 3 deletions(-)
> ---

Applied for next, thanks!

Kind regards
Uffe
