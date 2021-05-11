Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB12EC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 11:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF3B6134F
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 11:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEKLEf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhEKLEf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 07:04:35 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B60C061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 04:03:29 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id n61so6203775uan.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kja24isdbSJM03sWOU5N8MqOAw88tKizKWVVTvrDIFc=;
        b=tAdGF1M6J6WM4HSd/CmesutyIqQI28NWdwO8LZL2lkMGy51NTr1ILsSF5HejRQyswP
         lkKbouWCsOGbjGA5cuXJ6j2F8Bx3trcfYtZ5BeUwLf9Z6UNNQFcQWrr4DHVFA+uIpA95
         B5dv1cbhryiOt6uurQ1IiSu94eoYTNjsS1vIopQA48/oD0knrBoWVaaNYqOgGOFpuQ83
         WnaOiPwblY7gab+HWd1JI8IkU1y5/98+e5k8VEOknjoNGZzGl0TfBYgfUDdK8dmGtAtF
         dcapXcNw9ITy9Spg2n/IoiqeE2HgSF+qavFYA/dJ7B9q/CJMCop5iLuMePAFnZX9nfof
         DZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kja24isdbSJM03sWOU5N8MqOAw88tKizKWVVTvrDIFc=;
        b=XjxJZvm9v/o/C9oUlxE4naamxNtsN04bUTP1ojRtk+RflrJlMotgl226zpCOznM6Pv
         9a/pKkgnbuONt3yI5H65FqgfTMVHeHIAiRYOQFHeR4B2ylm7W6sQD1//SFo8wISyqHlT
         xyFNDRnmc7H+87dkMCFPGXDHgoT3HBrT5DSxZ7yLnCWAJR0HA4wFzmI/+u7X9AoCfhao
         YsFtEWol42P+MeurtF9TU/sp6MnWr9mxllIGHHCaw3zzK0wIs3vDrlybinEGzcb5xNgE
         qdzGMxrngVg1zAxzLcp3Ys6pIWISbB2haAFgGjgH4IY6+DlJRjPYS3upDp4QMpmysxB5
         dP/Q==
X-Gm-Message-State: AOAM5336SX9uRQae+RezSQMSaUtq6S+FoAGuDl3oikzbYtzdHDszoyOK
        uHCJ7KfI4JYgFbP50dMa/uaGUTRmZQnH4xnpr7MCxw==
X-Google-Smtp-Source: ABdhPJy8wuHnHRd7WhDwoOy5q9mSDiib2vWilJ/HOSveVa4OyPdn9x91QjAyH7cYwHrdBblz+kPFIaeH17fZIkjTVfo=
X-Received: by 2002:a9f:35b3:: with SMTP id t48mr6657459uad.129.1620731008424;
 Tue, 11 May 2021 04:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210503092157.5689-1-hdegoede@redhat.com> <CAPDyKFq2+SgWE7XAMWAQsC4Ud5YNx0E-CCsMgeDzN3b_wvwL-g@mail.gmail.com>
 <7c72c70b-8e5c-77e1-70c2-bf93e66fb407@redhat.com>
In-Reply-To: <7c72c70b-8e5c-77e1-70c2-bf93e66fb407@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 13:02:52 +0200
Message-ID: <CAPDyKFoa2w8BvXjphxSfzSWC6UFbBhxdzp5LRbg34hy_GoqO-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Disable write protect detection on
 Toshiba Encore 2 WT8-B
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 May 2021 at 12:58, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 5/11/21 12:56 PM, Ulf Hansson wrote:
> > On Mon, 3 May 2021 at 11:22, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> On the Toshiba Encore 2 WT8-B the  microSD slot always reports the card
> >> being write-protected even though microSD cards do not have a write-protect
> >> switch at all.
> >>
> >> Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk entry to sdhci-acpi.c's
> >> DMI quirk table for this.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > Applied for next, thanks!
> >
> > Should we tag this for stable?
>
> Yes please.

Done, thanks!

Kind regards
Uffe

>
> Thanks & Regards,
>
> Hans
>
>
>
>
> >> ---
> >>  drivers/mmc/host/sdhci-acpi.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> >> index b6574e7fd26b..9e4358d7a0a6 100644
> >> --- a/drivers/mmc/host/sdhci-acpi.c
> >> +++ b/drivers/mmc/host/sdhci-acpi.c
> >> @@ -820,6 +820,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
> >>                 },
> >>                 .driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
> >>         },
> >> +       {
> >> +               /*
> >> +                * The Toshiba WT8-B's microSD slot always reports the card being
> >> +                * write-protected.
> >> +                */
> >> +               .matches = {
> >> +                       DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> >> +                       DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA ENCORE 2 WT8-B"),
> >> +               },
> >> +               .driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
> >> +       },
> >>         {} /* Terminating entry */
> >>  };
> >>
> >> --
> >> 2.31.1
> >>
> >
>
