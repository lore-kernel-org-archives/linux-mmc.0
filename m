Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7146C3F68F
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE91B2077B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnT8YTWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPPhN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:37:13 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44151 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPhN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 10:37:13 -0500
Received: by mail-vs1-f67.google.com with SMTP id p6so12913668vsj.11
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8FYtMYgRqfcM3VrVjRmmrLZtQqIBlgUNnDbRk2ys1k=;
        b=MnT8YTWMSeLsD2sgjF6ZeceXA5LCWYRsKcjb4x0XdOxCwJeXlKyefd7ltqJ2sEiWjS
         YhDR3mQg6alaFY0a5tNZMz7dJWsEvxupaWm3yqUgZS8jARBU7Kn/Ebpxdo7unFIWv7R2
         b1g8x9hRuRrK3DD5SEhX/CP9C/n1b5ss/rPb6gyDIF5rpb8t3ffVv5JqLNZijLBI86oA
         9dbeR6JmOA4c0SGJiylkQHbTEdIZBjjprv6ooPcnNgPAD/V/MmVogbf1M0Isho81z0Hb
         o6YwgWfzer9k0Suzy6kHne7KWjCFIA/Zt/k2t5bCDvlo2esjQbWRP0tk6nm7oCYlJYQK
         vrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8FYtMYgRqfcM3VrVjRmmrLZtQqIBlgUNnDbRk2ys1k=;
        b=AE9gsT1ebGmC0Eu0RRHfDQZwNIyyLylMqW0MgI3c92YvF1XlXeIudy9MoW3JeZzyjH
         YaR/hsstls9cVcljdQ/jpU9dU1G9eiJkHrdY3MLezzWmf47UcEl4hSHuJk9oFNmMrg+q
         TxFnLePB2y0kdY0NgF0VMsN6+v6FeORhMXZmg5UkM++agJCXOHMujvQBQIiTjbv6ODLk
         O+2g+00LzPSXe8IGRLCYsIwfDRSE1iPVJF1q56VylRVoBE16SiCN5p/iyPdSn+QSMHx3
         54tBf2qlZPalbPa9IxQvGhAv9dEi/U2ApY/jqq0yLTLsd8oKVLG2IQH6Liq6nsXigMVH
         C5Yg==
X-Gm-Message-State: APjAAAVJDfCGJmR7BE/gDtgv1rkynxNiKOlzTnfdgQa5VoeMtETIdr+o
        8saKZRQQaEcfLM6KhtDKvNqb3jB5t53L/Ql9K2j+ow==
X-Google-Smtp-Source: APXvYqwvM8opGLNl1yTY7CdvLKcHqtG2FepjgUgQtLlcPxV3dx6/KM2MQ8hZcAMDqRwwhoZusR7J0wKJUWW48nUE2Ys=
X-Received: by 2002:a67:314e:: with SMTP id x75mr1759712vsx.35.1579189032070;
 Thu, 16 Jan 2020 07:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20191114111814.35199-1-yangbo.lu@nxp.com> <CAPDyKFqfMzv1hFzPzS7w5BVHyXybu--7p11wHYa8WTQAVB7r4g@mail.gmail.com>
 <AM7PR04MB68856B9D41A5867AB39D37F2F83E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB68856B9D41A5867AB39D37F2F83E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 16:36:35 +0100
Message-ID: <CAPDyKFq7VnfYAs=RcjUpskAfSC_fatksQ1_sJ6wEOinbPDKmkQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: fix up CMD12 sending
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sachin Miglani <sachin.miglani@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jan 2020 at 10:37, Y.b. Lu <yangbo.lu@nxp.com> wrote:
>
> Hi Uffe and Adrian,
>
> Back again on this topic. Actually we are trying to make the error recovery work after data error of CMD18 in linux-4.14.
> With this patch, when CMD18 data error got, manual CMD12 would be sent. And then went into mmc_blk_cmd_recovery(). (Should be mmc_blk_mq_rw_recovery() in latest linux-5.5-rc2.)
> In mmc_blk_cmd_recovery(), re-tuning would fail before sending CMD13 on our specific board.
> This may be some issue related to specific eMMC card we are investigating.
>
> The above is just background introduction, and you may not care about that:)
> I'd like to have some queries on CMD12 usage in MMC driver.
> 1. It seems CMD12 is always not using ABORT type for sending in sdhci.c. The SDHCI_CMD_ABORTCMD hasn't been used. Is this issue?

I defer that question to Adrian.

> 2. In block.c, CMD12 uses R1 response for data reading and R1B response for writing. Is it ok to use R1 response for SD? The SD spec mentions only R1B response for CMD12.

I think the specs isn't that clear on this. In this case, the R1B, is
an R1 with an *optional* busy signaling on DAT0, unless it has been
changed lately.

Additionally, as far as can tell, there have been no reports about
problems with the current approach for "reads". Are you saying there
is?

[...]

Kind regards
Uffe
