Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1415FC5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C739206E0
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h56OQ/sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgKYKnd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgKYKnd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 05:43:33 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480AC0613D4;
        Wed, 25 Nov 2020 02:43:17 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d9so3513642qke.8;
        Wed, 25 Nov 2020 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfzdYERePZMzBaNOZIUJ+TWMPJEifgCrLz3ilkJ+c2U=;
        b=h56OQ/sj+0y0m641GlXhoLSGSaVQBJYq4zX5m40qeFuQVBgSZ+YYZfPPnPaHcwsn6G
         cRK6I1PNvtUofjmCKigG3RFmxHjC0OkugIpnAHf55t89vq4FtMd2HghniFfYhefavRjX
         iPOwuy8JKxNBogS9nHCAAwgiKKpHIsPO9/xY6Fi8a5aih/PVr2za43UyG1q1TkUYn38D
         NwaYsNE5I9/LLwuffDq+tI6iskFA5Pj06Zb2QYOyT9iyZKgey1KiATwsizj80BNI/rXC
         BVDgeumBiZmUCIu1RtG9N2GMubVeXKzwOwb7tWSP4e3lZ6f3A5yytFpi23PdfIOou8qi
         wiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfzdYERePZMzBaNOZIUJ+TWMPJEifgCrLz3ilkJ+c2U=;
        b=OFe+zw+6QVQYw3iHIKe4KIWTzTk5fJYMDt3T5MUlblqaDJ9Eng7Ca8rZf5dwOo+NMm
         eXffzJ4iTiVgT0/SWnIxZIZGmq8Vmxtxx0XAYZnhgelKR43bk29El8guM9gzhRO2VUd4
         Djo3wklQut9L+fiBJOFTENGowyj8RSFCXdRVrFdVo53Vx2dAlelLssqDkE09fTfToMvT
         JtCFI6v7h4fY04fLY8bSt264KruphJ5wrM1LXKrTSVpF/nQoHHitv+/DI2stF/+9KAeX
         GfCi6/zeKrmLmWfr3Uflbvd7jMRdJp9myqIzn/oJ/rNXbOWXWytr0g//2aBolxkBh9q0
         U9Eg==
X-Gm-Message-State: AOAM530xwHoqgb1IUxZL2IKuQx532JwvOA9/JPYQcIQYWC6Ivb1m19nw
        OAQFF1gYDTIKU4IToP6dPVmBWdz7WvX/VHdQYsy64+ISfXPOAg==
X-Google-Smtp-Source: ABdhPJxp43tmeVPZtiGwMMUOOqxNh+AWkZqI/0Nrn5I8wF0w71KDcQMsDaXvuOISnuPotiMyPYwAyf9ybEoiDXhbfZs=
X-Received: by 2002:a25:8404:: with SMTP id u4mr2746968ybk.48.1606300996918;
 Wed, 25 Nov 2020 02:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20201125100004.1288-1-benchuanggli@gmail.com> <CAPDyKFp_3Vpq6ZRm5Qm1Zningz9tDqQLS_E78a8ChYHVbofB9g@mail.gmail.com>
In-Reply-To: <CAPDyKFp_3Vpq6ZRm5Qm1Zningz9tDqQLS_E78a8ChYHVbofB9g@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 25 Nov 2020 18:43:06 +0800
Message-ID: <CACT4zj_rrV+MFXwsnXpLD=CNjApUKozMWJMnhS6z2q5d6-dY-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Wed, Nov 25, 2020 at 6:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 25 Nov 2020 at 10:59, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
> > to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.
> >
> > Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
>
> Why a fixes tag? This patch looks like an improvement and not a fix, right?
>

Since the specification defines that the HS400 mode must run at 200Mhz,
this patch fixes the HS400 mode to 200Mhz.

Best regards,
Ben

> Kind regards
> Uffe
>
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index 9887485a4134..d45d7e529150 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -87,6 +87,9 @@
> >  #define PCIE_GLI_9763E_SCR      0x8E0
> >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> >
> > +#define PCIE_GLI_9763E_MMC_CTRL  0x960
> > +#define   GLI_9763E_HS400_SLOW     BIT(3)
> > +
> >  #define SDHCI_GLI_9763E_CQE_BASE_ADDR   0x200
> >  #define GLI_9763E_CQE_TRNS_MODE           (SDHCI_TRNS_MULTI | \
> >                                     SDHCI_TRNS_BLK_CNT_EN | \
> > @@ -764,6 +767,10 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> >         value |= GLI_9763E_SCR_AXI_REQ;
> >         pci_write_config_dword(pdev, PCIE_GLI_9763E_SCR, value);
> >
> > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, &value);
> > +       value &= ~GLI_9763E_HS400_SLOW;
> > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
> > +
> >         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> >         value &= ~GLI_9763E_VHS_REV;
> >         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> > --
> > 2.29.2
> >
