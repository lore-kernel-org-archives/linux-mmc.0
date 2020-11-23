Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D728C2D0E4
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4122076E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cd9H8Fy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbgKWQHf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKWQHe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 11:07:34 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE725C061A4D
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:32 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id i62so4055447vkb.7
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNsop+cjEneyR6Ql2hsZCZcsflP0cbZhcL6E3kTgIJE=;
        b=Cd9H8Fy/EEy2EVXyMtJdIYyP/IYtfyQfGwJCqk0fyc4pG+Ri//S5+3ZvYM5glp1ZJ4
         ZVpOc3/9mHF17iULTB1oum8mS8BTwOcqNPsBrBr5KOopK58JAPYG3ZtH5Cfh7EM02SfW
         u8v9dh/qskdFaQxe+oZy5GeJzKFJOVzMzvIpfXw6+2isPqbRi+/GT7kpplRCoBpQNKEh
         vluYENBYiw7UwIlqIKR8In3xPatHHeYpCB/CRhdg1R6sNQrRsUOftWmJzz2bxj5PDcHV
         edfTUtm9iAr2BidHf1KMyEU4zK35Rhw7pNGjat+i42krW9SDkcKf9jtgwNbyEGOwpVU7
         8vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNsop+cjEneyR6Ql2hsZCZcsflP0cbZhcL6E3kTgIJE=;
        b=nyFYKRno2wfK7x3vpBj7bopZH6kg83PBtQLYpajiHmWEojiBJA0flk81bzqbTul3at
         7REksWUhgxOB1yF5+I9uQnEjrz5aCdpv80acW7m2oGTmLPLNmP+VxaKsGuy1z5CKsAtW
         AQ7cXD0Vr3dRmMfyjbmbwFKNwmwdVf77Mmo6RCpTL2Ijks+BwvJyG/3hwZdduaS66Uc8
         Qs3PCSo1ZVFneWoLvqim5rs3P7qHMnfhTJUWBTSmkxvJZOqZH6imOqSLw5Xg6m8g6lUN
         pnmC6HESkgW1OrScfWqKnLfacq+HMJJkNgqtz6BZhXm/pAZG4PXiCfQHvG7RfiXBZmME
         cMNg==
X-Gm-Message-State: AOAM531jRyZ6yTpI8NMZ9v9Q87aWGMHsQiQHgZJjqR/swE8cQKtHynu1
        Ju4bLCZXwGr9jPcD2zWxPLlqTSy7Qk3SC1JRwbNkEw==
X-Google-Smtp-Source: ABdhPJyOs8N3MeZsp7FriWdMaHZTpzFrInprCKZugi76ui1r4JwfNeV5VLB6ZZQVRdgjqtC5UIQahxENrMD8YMjwo74=
X-Received: by 2002:a1f:9889:: with SMTP id a131mr456205vke.15.1606147650704;
 Mon, 23 Nov 2020 08:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20201118063405.24906-1-wenbin.mei@mediatek.com>
In-Reply-To: <20201118063405.24906-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:06:53 +0100
Message-ID: <CAPDyKFpHAWBtxLOOvvqmAYFAwCsV66s_LzzVJg-zfXH5QE++Ng@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: Add system suspend/resume interface
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Nov 2020 at 07:34, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> Before we got these errors on MT8192 platform:
> [   59.153891] Restarting tasks ...
> [   59.154540] done.
> [   59.159175] PM: suspend exit
> [   59.218724] mtk-msdc 11f60000.mmc: phase: [map:fffffffe] [maxlen:31]
> [final:16]
> [  119.776083] mmc0: cqhci: timeout for tag 9
> [  119.780196] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
> [  119.786709] mmc0: cqhci: Caps:      0x100020b6 | Version:  0x00000510
> [  119.793225] mmc0: cqhci: Config:    0x00000101 | Control:  0x00000000
> [  119.799706] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000000
> [  119.806177] mmc0: cqhci: Int sig:   0x00000000 | Int Coal: 0x00000000
> [  119.812670] mmc0: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
> [  119.819149] mmc0: cqhci: Doorbell:  0x003ffc00 | TCN:      0x00000200
> [  119.825656] mmc0: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> [  119.832155] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00001000
> [  119.838627] mmc0: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
> [  119.845174] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x0000891c
> [  119.851654] mmc0: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> [  119.865773] mmc0: cqhci: : ===========================================
> [  119.872358] mmc0: running CQE recovery
> From these logs, we found TDL base was back to the default value.
>
> After suspend, the mmc host is powered off by HW, and bring CQE register
> to the default value, so we add system suspend/resume interface, then bring
> CQE to deactivated state before suspend, it will be enabled by CQE first
> request after resume.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

I took the liberty of renaming msdc_sys_suspend|resume to
msdc_suspend|resume, as I think the "_sys" is a bit superfluous.

Additionally, I added a fixes+stable tag, then I applied this for fixes, thanks!

Please tell me, if there is anything you would like me to change.

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fc5ee5df91ad..c5f9cd6fc951 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2758,11 +2758,29 @@ static int msdc_runtime_resume(struct device *dev)
>         msdc_restore_reg(host);
>         return 0;
>  }
> +
> +static int msdc_sys_suspend(struct device *dev)
> +{
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
> +       int ret;
> +
> +       if (mmc->caps2 & MMC_CAP2_CQE) {
> +               ret = cqhci_suspend(mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +
> +static int msdc_sys_resume(struct device *dev)
> +{
> +       return pm_runtime_force_resume(dev);
> +}
>  #endif
>
>  static const struct dev_pm_ops msdc_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(msdc_sys_suspend, msdc_sys_resume)
>         SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
>  };
>
> --
> 2.18.0
>
