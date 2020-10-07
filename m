Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E610AC4363D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAA621531
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuOjVEZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgJGOx7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgJGOx7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2020 10:53:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D48C061755;
        Wed,  7 Oct 2020 07:53:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bb1so1133014plb.2;
        Wed, 07 Oct 2020 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyV6KXUS1c7DltkhuFHvz8iH/qvXIDKFdF/6FuM3Dvg=;
        b=OuOjVEZrMX7i4qZyPfaYfkDmwT4UCUjiWjpK5i0cEo0a2i3+Z9CLqRNjB0So9tDlI1
         UPO1GLlswNEiEsawr+zNU8fOe1Mza/Xw/3wFb74ZWe1wJvLs84q3AMNdSPSbLzjrN1kd
         N9423/l51m7+ASIR/M1B8R1j85SprUi0VLe6uHuSbbD6wVEMBVyno8mS5Al0yRrJT0kK
         daDAWfB+ZWbUbjZSFR0BtVxwg6SQXQR/S5Li6ZqgfHF/0EMkMZ+Hg2tKAv+EvY/guGZv
         GlYacxbTY0AWjijUbWDcIOSv2x3SlSOsu0huSSwD0f/2b8DW4mb8so9Qz+x5IjfJufkc
         XLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyV6KXUS1c7DltkhuFHvz8iH/qvXIDKFdF/6FuM3Dvg=;
        b=cv0g0PRYgKXmWBEMl9tbAJgRUlgUIAwFSalnB0HidOxNKJCGUm+uHdt6mV5tRVxq0Y
         BDkJkcT8STPunqinR/fiw1TAH4g8ktsX1+mUJSpPyhkZm2mD+Kx4fYp7/d7vsvyBUWbe
         EL1SQBXNmZOk6SgyeCWwsEkZJ8DvaNvwyi9OZO3vgL3NUxrMSqVS6e/KLHJQRENk8IFA
         ytJ/t8UgqJlmOOqe4enRIpG75U33+M932l5L6NWesXoFDhHZxDx/TEKqvDwhS+k4Ezyj
         pcx84EaNGoFrunFpVhcJ0YwdcBUcHcZGYFJfQYj57MXNUWj/PYiJwBrlBTB9qMQ2++mg
         VQCw==
X-Gm-Message-State: AOAM530/N9VHv16VqBzWYVvoxYwFE5WetILWVIJlSMlbSLI/RLF5hcgC
        h6Q0VmwM7wy/SvpVUOun3sxsdLpcSD05LvV2Y9Q=
X-Google-Smtp-Source: ABdhPJyYIQrR0698WQb7xr65UOrpJZ49f68fUhyAjCgrnYz/LAGp892x0F2TCpJq42TdjUcdJGj0D/XxeGRvKN+i5fc=
X-Received: by 2002:a17:902:ea8c:b029:d2:8abd:c8de with SMTP id
 x12-20020a170902ea8cb02900d28abdc8demr3306474plb.21.1602082438746; Wed, 07
 Oct 2020 07:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com>
 <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com> <CAHp75VfXe=dwbNEdUfwmMnZCkSTRH_6HjGD0MUs=GY0en4f0sw@mail.gmail.com>
 <DM6PR11MB28768EDF354D2ED4A43B4AD2B80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB28768EDF354D2ED4A43B4AD2B80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Oct 2020 17:54:48 +0300
Message-ID: <CAHp75VeyO1XErkO=sGnY2VTyPQT9Gp-rkfPdmj0AMM95fA2J1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 7, 2020 at 4:28 PM Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
> >From: Andy Shevchenko <andy.shevchenko@gmail.com>
> >Sent: Wednesday, October 7, 2020 4:56 PM
> >On Wed, Oct 7, 2020 at 11:38 AM Michal Simek <michal.simek@xilinx.com>
> >wrote:
> >> On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:

...

> >> > +     struct device *dev = &pdev->dev;
> >>
> >> nit: I got this but as I see 3 lines below maybe would be better to
> >> use it everywhere but it can be done in separate patch.
> >
> >In that case I think it would be better to have that patch first. It make follow up
> >code cleaner.
> I want to get some clarification here.

> Do I need a separate patch for this struct device *dev = &pdev->dev;?

It should be a separate patch and better your series starts with it,
so it won't interfere with new code.

> Can I embedded together with UHS patch?

Better to avoid merging orthogonal things together in one change.

-- 
With Best Regards,
Andy Shevchenko
