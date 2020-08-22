Return-Path: <SRS0=q0fh=CA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC2C433DF
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Aug 2020 06:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0182A20825
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Aug 2020 06:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L64oCmJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgHVGRd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Aug 2020 02:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVGRc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Aug 2020 02:17:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58116C061573;
        Fri, 21 Aug 2020 23:17:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so1730586pjx.5;
        Fri, 21 Aug 2020 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/vsXxIYoH9IaQYN9SpjWFRYwceGPVmhGBMx9DqjyaCA=;
        b=L64oCmJwVTF5reQ8SOLuTTPV5gWEEEMC3h4StMqJ/EiQJARv55oVXDUXfzd+w37xOD
         +SR4p/LCjf/oTjg7I0kSn3FjUj6ItqeG0NgHsdf6ddPCIL56bA4AICnDxat0uUL7F0Fm
         owaLo2KopE49AXej+lF9qgFrlzmK88Vl+rporEN0WgZbciioS/Q3KOR8hstjeeKibBfw
         Ws1Jk7l/rvaMXw0oqiC3lVyM55xzPaOCvhF1ZjSwcJdu00MRWI9Le8JEOlh3Cl9k+qtQ
         lBry93n7hIk62FDZB6krMEjuiv8YTxK8cuZwTJm8bWvmomWkYjGGC3+YLmEfBpZuMIDw
         AJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/vsXxIYoH9IaQYN9SpjWFRYwceGPVmhGBMx9DqjyaCA=;
        b=sVWikr68DxWX4UAmmJ7EqKuUPdQCsbMsBd+x8CfySyJsjki/JBVuRFUmRVd6HTNj9v
         1k9WIMrFo97Gal10tMwd33vqB8WB0Cl0EiYtn3aCZwOAPwYYL3K3aDvtusmVtzUiCaXL
         nvlBCCQWt7fvTmaX7VZTol738+cU+G9Cu47u5YvP6pOp7D0gUPQYE+uDFf+fD+6ZF6rM
         H/kHZRzOe72k3DQZmogKy7d4cx/a5SWp8ggWQ01CdR33g7fWc9RFQk7tyRxIrOy6VszZ
         s6jJyQOp/Hl6PAF1d6QeU+0aaNP23/IorIHDOdckVZkbP3inyVK+bdllSybHefNNoQj8
         JhlA==
X-Gm-Message-State: AOAM533wLBIQLZKCZEKUWO9PjfgKHp3cmSJMVEtaDWxsl2GSyONdMPeB
        2pzb4LG8VCildAKUbGovQ2ns5Wx78A==
X-Google-Smtp-Source: ABdhPJz/zvfXAXwavjIE33/xdQA79vArlk5b5NzTPeQs2PGpP78M3V+Cqm13Pa0hBcfjKK7ft/9phw==
X-Received: by 2002:a17:90a:17ab:: with SMTP id q40mr5286180pja.28.1598077050740;
        Fri, 21 Aug 2020 23:17:30 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:cfa:ae3e:f998:8f12:465c:736b])
        by smtp.gmail.com with ESMTPSA id t2sm4500370pfb.123.2020.08.21.23.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 23:17:30 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Sat, 22 Aug 2020 11:47:25 +0530
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     madhuparnabhowmik10@gmail.com, Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: Re: [PATCH] drivers: mmc: host: via-sdmmc: Fix data race bug
Message-ID: <20200822061725.GA7141@madhuparna-HP-Notebook>
References: <20200803072857.8880-1-madhuparnabhowmik10@gmail.com>
 <CAPDyKFo2njN6bU+VqpuHPpHDx4+ZkuoNRZVb0a0EjGBi9uXa7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo2njN6bU+VqpuHPpHDx4+ZkuoNRZVb0a0EjGBi9uXa7g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 21, 2020 at 02:48:37PM +0200, Ulf Hansson wrote:
> On Mon, 3 Aug 2020 at 09:29, <madhuparnabhowmik10@gmail.com> wrote:
> >
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> > via_save_pcictrlreg() should be called with host->lock held
> > as it writes to pm_pcictrl_reg, otherwise there can be a race
> > condition between via_sd_suspend() and via_sdc_card_detect().
> > The same pattern is used in the function via_reset_pcictrl()
> > as well, where via_save_pcictrlreg() is called with host->lock
> > held.
> >
> > Found by Linux Driver Verification project (linuxtesting.org).
> >
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This doesn't apply to my mmc tree, can you please rebase and submit a
> new version.
>
Sure, I have rebased it to v5.9-rc1, please have a look.

Thanks,
Madhuparna

> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/host/via-sdmmc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> > index ef95bce50889..e4d8126cd4e5 100644
> > --- a/drivers/mmc/host/via-sdmmc.c
> > +++ b/drivers/mmc/host/via-sdmmc.c
> > @@ -1259,11 +1259,14 @@ static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
> >  static int via_sd_suspend(struct pci_dev *pcidev, pm_message_t state)
> >  {
> >         struct via_crdr_mmc_host *host;
> > +       unsigned long flags;
> >
> >         host = pci_get_drvdata(pcidev);
> >
> > +       spin_lock_irqsave(&host->lock, flags);
> >         via_save_pcictrlreg(host);
> >         via_save_sdcreg(host);
> > +       spin_unlock_irqrestore(&host->lock, flags);
> >
> >         pci_save_state(pcidev);
> >         pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
> > --
> > 2.17.1
> >
