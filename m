Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC12C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 09:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiKRJZk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKRJZk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 04:25:40 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011D813D28;
        Fri, 18 Nov 2022 01:25:38 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h24so2756776qta.9;
        Fri, 18 Nov 2022 01:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxmmB0O8kf2bCZUg8Vmzy4DjqrDLbrYKNV+9DFjGPdM=;
        b=iGoNWXXXnis33v7inwHeg1vbF1B+aH3d3MXsz/vIMruwIp734Gt5/9jGckp7x//ZgN
         GUZgpC4iS1d3MZLeR61ofeciNEKAujQfQZzxa6nfkxfGWUxBHeXadL9D49nz4Pt7M4aE
         XEzvZDukjfunZ6wtdG9pertRkqFFVaQnyRP8hyqXIRbTaBjLqQdj7GUA7LO1TSfVyQmr
         O6LIrFuZw506IRoPPlukiJta3izZliTAJr6PfuMf7hlxOUc3TY9gJuYau0H2ZLNydq6O
         H0mDhhIWwxRRPgSSPPTZcolCz6diIIqypw9cTpD2295ixLSMeu/WOir34l7dQ/cKaF5w
         dGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxmmB0O8kf2bCZUg8Vmzy4DjqrDLbrYKNV+9DFjGPdM=;
        b=y2j89IfcUguas1CKsr19yd6W9lILcnv7J3WgKGTaSqjYvlTgxQtiDrt8GLhkouoX1e
         P6JLDgYDtYUpiTmN6rPuLL0Lj10bB+GIt8vkHoIfJZJHrP7ezvDfbW2A7xAuejEiYFEO
         sD5RbO+D9wRtRNpdwIfQYV8CiphFaNbahQONuroevvLAvpgA/nnBXTL6isloY0oE/pGw
         /NYVbqfn0wmMiXTxxObXsqbNEe+VqiFvnIzwm2IyqVWU+MZk+BnhnyspEEUgj4SKXy/3
         M/b067csFUVV+O+yqPa6/7u6WmGjzLMI5w8dyCvp+pWFzZr44AnjUUyR/u+nufIbf8DT
         uCFg==
X-Gm-Message-State: ANoB5pmrGylpVHETxpPfpJ5Bjdq1CB9T+tf+Xkg2fkxtoW44kz9RWTO5
        JJdBnhU33jxLDdCmXO8lcHIc703zb34ZDpf1LlQ=
X-Google-Smtp-Source: AA0mqf5UhFnmhEBpfKYNk2qlm9NY4I1IaPGXQ1r6HCYQEskO1OiB0JmswdszYCQwSu0bqZtvW1F8XX18ZqCNcD0NOVM=
X-Received: by 2002:ac8:4d51:0:b0:3a5:1e6e:ad6a with SMTP id
 x17-20020ac84d51000000b003a51e6ead6amr5733386qtv.556.1668763538165; Fri, 18
 Nov 2022 01:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20221111084214.14822-1-wenchao.chen666@gmail.com>
 <20221111084214.14822-2-wenchao.chen666@gmail.com> <59fc95ec-c0db-4011-eca3-3d101f0bc908@intel.com>
In-Reply-To: <59fc95ec-c0db-4011-eca3-3d101f0bc908@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 18 Nov 2022 17:25:27 +0800
Message-ID: <CA+Da2qwdtUdCcv+HhNArGoriVtOmx+GGML4Avkk5QSdm8+XXTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during tuning
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 17, 2022 at 12:00 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 11/11/22 10:42, Wenchao Chen wrote:
> > From: Wenchao Chen <wenchao.chen@unisoc.com>
> >
> > During the HS200 tuning process, too many tuning errors are printed in
> > the log.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index fef03de85b99..a503b54305eb 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
> >               if (host->pending_reset)
> >                       return;
> >
> > +             command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> > +             if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
> > +                     return;
>
> Normally we wouldn't get here even if a request got an error because
> then we either reset the data circuit which should stop further
> interrupts, or set host->pending_reset.
>
> Can you elaborate on what is going wrong?
>
Hi  adrian
1. In the process of tuning, not all tuning values are good, some
tuning values may cause errors, and these errors print too many logs.
    Of course, we reset the cmdline or dataline on error.
2. use host->pending_reset = true
static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
{
...
if (sdhci_needs_reset(host, mrq))
host->pending_reset = true;
...
}

But intmask = 0x00200000
static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
{
...
if (!host->data) {
struct mmc_command *data_cmd = host->data_cmd;

if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
if (intmask & SDHCI_INT_DATA_TIMEOUT) { //#define
SDHCI_INT_DATA_TIMEOUT 0x00100000
host->data_cmd = NULL;
data_cmd->error = -ETIMEDOUT;
sdhci_err_stats_inc(host, CMD_TIMEOUT);
__sdhci_finish_mrq(host, data_cmd->mrq);//<=
return;
}
if (intmask & SDHCI_INT_DATA_END) {    //#define  SDHCI_INT_DATA_END 0x00000002

host->data_cmd = NULL;
/*
* Some cards handle busy-end interrupt
* before the command completed, so make
* sure we do things in the proper order.
*/
if (host->cmd == data_cmd)
return;

__sdhci_finish_mrq(host, data_cmd->mrq);//<=
return;
}
}
...
if (host->pending_reset)
return;

pr_err("%s: Got data interrupt 0x%08x even though no data operation
was in progress.\n",
       mmc_hostname(host->mmc), (unsigned)intmask);
sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
sdhci_dumpregs(host);

return;
}
...
}

> > +
> >               pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
> >                      mmc_hostname(host->mmc), (unsigned)intmask);
> >               sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>
