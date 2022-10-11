Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FAEC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Oct 2022 13:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJKNvy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJKNvw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2022 09:51:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3970C79EE2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Oct 2022 06:51:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso8302872pja.5
        for <linux-mmc@vger.kernel.org>; Tue, 11 Oct 2022 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3TOgt2vEpRrLSiB3atQwtzFhnMOsulmIzIgqeIq1nk0=;
        b=XSb6i3VpfNyWAq4vxeUCmNYS7AvXFIp/Ceze2c/cL8iQpUxCtxkVNBw2UldHR/Nb5u
         kwLcAWt6lHquxP8aj/eUlZ/zDkyYY7dzpIT47x/EVDoBDV4DhMrRDDxtvf2E4YZ29l+G
         Z5WoPgie9IxJsvL4kWnLCr9FjkgclgRSiHL+bCxKZP+lsYcjiOZihOUdqE0/rm/NBQkI
         CUx/bD4Un8LxSB+Gkw8W01hphPoidR8cBl3oY/Db4Lwi1K/VTMw8BPWQwP5DNwsI0QMu
         glgqxbm0xMb8ILcuMHWpQ9sdNmsIN+TIVUkfWvRB0nkIKHOuIhmkZiFKgBY63l9yfDb7
         ig7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TOgt2vEpRrLSiB3atQwtzFhnMOsulmIzIgqeIq1nk0=;
        b=fhxNRAR+iZEqwzZAs7labzHuY2p+eL6qQhJNcvXAwG0ky8nS4fdR+gW1jFnJTgW7kv
         jh5hFrw9oOKiFAuVpTawEXC+l5Izx9u7Ym8eNe2gEEtXHPJ+j8PaB6OUFU5FVzEbi10H
         AsPceqkXr0RnOSQypts6CdYlmHugAf/YGopDa7tvr0HPZt35ROdq6xAguY4Kh6r5zPZk
         LubmbewnvTIqk3dFnwMi9J1kFDK/E+jZIA/ZCPMGXdnJiUi350brxyveig1Ad9sF+mO4
         am+g2Y2HFWQmEmYqqyyLe6Iv6vq2vGbvpqRbry1VFH0TU02RYyt/v/8bUCazTpAi0IKq
         qNJQ==
X-Gm-Message-State: ACrzQf36/AK7+3k8MLNnKDfcPWU7rCyb9uH25v0YuT6x35bBjdsNXOK7
        kbHW/bEOWHA6sovhOfluOR9b3lHOLpxVQfHxe5PoYQ==
X-Google-Smtp-Source: AMsMyM6ZI1+Czzvdy2KBVZyE7SMw4ytpcTgrfacFlkhl48aF/wAR+uS3VQEg38HqWMe9SsU1lJ1BKumb3Y663OEQai0=
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id
 z12-20020a17090a7b8c00b0020b1f3bf6fdmr26702369pjc.202.1665496310708; Tue, 11
 Oct 2022 06:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221011104935.10980-1-wenchao.chen666@gmail.com>
In-Reply-To: <20221011104935.10980-1-wenchao.chen666@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Oct 2022 15:51:13 +0200
Message-ID: <CAPDyKFqG=QV3Oitot=w936wZL-zOE_6qdERxHZOjkTix6m3DLQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-sprd: Fix minimum clock limit
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 Oct 2022 at 12:49, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> From: Wenchao Chen <wenchao.chen@unisoc.com>
>
> v1 -> v2:
>  - Address Adrian's suggestions
>
> Our controller supports 100K. During the test, it was found that mmc_rescan
> failed to scan the card at 400K, and did not try 300K, 200K, and 100K. After
> modifying the minimum clock limit to 100K, the card scan was successful
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 46c55ab4884c..b92a408f138d 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -309,7 +309,7 @@ static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
>
>  static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
>  {
> -       return 400000;
> +       return 100000;
>  }
>
>  static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
> --
> 2.17.1
>
