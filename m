Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84602C11F67
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 01:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612FA613BC
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 01:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhGBBeB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 21:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhGBBeA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 21:34:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1767C061762;
        Thu,  1 Jul 2021 18:31:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c5so7606341pfv.8;
        Thu, 01 Jul 2021 18:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qM0IASgoBZVDBMc/iSq9wtDekoeCr9h0tQGMOZCQdSU=;
        b=ipwtG2GDhk8omn4nOHeK7/duVF+qzYw0BDeftypVI8rz84wbXJpdyKM9RRc+78IH9q
         ljX1Q8OPwKXwtCp5zhPrreKrLkqwZcMyNjCRGu0XJX3NkI/5BrRbMqXeqA8bwIYwqwdS
         GqG1L3g1qnuhb6c6MG0lZzlqIEFYOSVMRCQQdTBuzaFj7fQc69FoS9k52OQXWKBDHp5o
         ky+GJXF9YTYnCy9DfXU900VgkUvuQMJim4+jzTs3Ncq/0Vx5nZS7Azi/yg8KTkosM5t1
         /FM3ULy3oICQReWxqx//I6Ckkxfxllp+8FZDYs375tSBXiGTvmSH7+q3wzBwBbROoT07
         S2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qM0IASgoBZVDBMc/iSq9wtDekoeCr9h0tQGMOZCQdSU=;
        b=ZZbCJrGUGbopqyDI8mQznAOJbe8lNauxBr6o3JEH74BZpol3P8TlnIs2Btozz0Oeq3
         mmGVMf5Q6mAf44h/M4mR4GRJD48V92gZ2Opg899XeJEG+TtoAKGNomYxmbUYS7CUnbHa
         vvmF9sSxvlP6vyBjXT+jd431Vb3SclMNwUHcDELnga2q3ykKDhET9CEHWjJxodyckwEg
         +6IF5ObpJ7OO8BcINlJ77dYozctyH09HG2pOERUryQkkzaD6PVYDu+7AgoSqM/quhcBN
         qqjYMwwexWJffh7SHdHkP5oVUYNog5AS8vunzKlk/lY6D2eu3oMeoq95MYNeTF2qpXWy
         YW0w==
X-Gm-Message-State: AOAM532YR29kNYFgs37/esIuyJ3/hQlVXBLToJmyYo9shqX6/n8wKvcQ
        IOTXEelQRUYtTea+75L+rV8=
X-Google-Smtp-Source: ABdhPJxAYwIEtoTJNtCqSYtqLsEkaIMU8Yn1c2YcsKNpL8mRT4W4+mXQ41/tbW6+kz6tPDXyr0vWXQ==
X-Received: by 2002:a62:aa10:0:b029:2bd:ea13:c4b4 with SMTP id e16-20020a62aa100000b02902bdea13c4b4mr2545700pff.48.1625189488094;
        Thu, 01 Jul 2021 18:31:28 -0700 (PDT)
Received: from U64-BenChuang.genesyslogic.com.tw ([180.176.36.63])
        by smtp.gmail.com with ESMTPSA id b1sm1181025pgb.91.2021.07.01.18.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 18:31:27 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     reniuschengl@gmail.com
Cc:     ben.chuang@genesyslogic.com.tw, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, Ben Chuang <benchuanggli@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Finetune GL9763E L1 Entry Delay
Date:   Fri,  2 Jul 2021 09:29:51 +0800
Message-Id: <20210702012951.2911-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJU4x8tAoHebcynA1+UdAiqF4kRYgzEpu2qpzcikfUSKxjL3AQ@mail.gmail.com>
References: <CAJU4x8tAoHebcynA1+UdAiqF4kRYgzEpu2qpzcikfUSKxjL3AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf and Renius,

> Ulf Hansson <ulf.hansson@linaro.org> 於 2021年6月30日 週三 下午11:16寫道：
> >
> > On Thu, 24 Jun 2021 at 04:56, Renius Chen <reniuschengl@gmail.com> wrote:
> > >
> > > Finetune the L1 entry delay to 20us for better balance of performance and
> > > battery life.
> > >
> > > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > > ---
> > >  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > > index 302a7579a9b3..4e3c0561354d 100644
> > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > @@ -90,7 +90,7 @@
> > >
> > >  #define PCIE_GLI_9763E_CFG2      0x8A4
> > >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> > > -#define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > > +#define   GLI_9763E_CFG2_L1DLY_MID 0x50
> >
> > We just changed from 21us to 20us. Really, how big of a difference can
> > this make?
> >
> > Moreover, I suppose the difference is related to the running use case. No?
> >
> > If you really want this, at least I want an ack from Ben for it, then
> > let's be done with it.
> >
> > Kind regards
> > Uffe
> >
> Yes, according to the result of our customer's PLT test for battery life,
> It will pass the test with 20us and will not pass the test with 21us.
> I'll ask Ben for acking this, thank you.

Using 20us can pass the battery life testing, but need to consider that it
may reduce some performance.

So this patch should be together with 4k patch or after 4k patch.
Then I can acked Acked-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>. 

Best regards,
Ben

>
> > >
> > >  #define PCIE_GLI_9763E_MMC_CTRL  0x960
> > >  #define   GLI_9763E_HS400_SLOW     BIT(3)
> > > @@ -810,7 +810,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> > >
> > >         pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
> > >         value &= ~GLI_9763E_CFG2_L1DLY;
> > > -       /* set ASPM L1 entry delay to 21us */
> > > +       /* set ASPM L1 entry delay to 20us */
> > >         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
> > >         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
> > >
> > > --
> > > 2.27.0
> > >
