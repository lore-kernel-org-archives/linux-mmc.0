Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19FBC55189
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8E120781
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THhL3ijJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgDVKdJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbgDVKdH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 06:33:07 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242AC03C1A8
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 03:33:07 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n207so481279vkf.8
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xM8Q7T6rdjH9e0uGDvlqHrRRLXPLFjytVZpcaXFHZdE=;
        b=THhL3ijJQL1p3tRF1MmaLpAi1ocdrrVuBVCXvpYEJW+FqGjb6E+2801ObV4nYOi67o
         0dDWVukcYXGc9Qx2rdh9HFLQgth/4J/j6ZM0mzV76SG3+DvrWMJmo+LEi/pGdjegRAp0
         M0a//fmFE5hMHa2G0h+xh07camJ6b6Eco734bI8IJZbFcTqDvBcU3GOkSV6TziTkkDON
         Wztb9c3dazycUTD7mDJqvrLtztRZv8O72MJue1/RTLrfyhyJBWumEWndLGi+SaRWA6Kd
         jZM79N/bXRVY+r0ReX8uvMSVLDK5qSEnyBDe6E6R8YsDgoDYk+K7z8y9Dw2FDBo7TO1n
         adkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xM8Q7T6rdjH9e0uGDvlqHrRRLXPLFjytVZpcaXFHZdE=;
        b=L+4+yrJxq69xKWOxHJ4eThecGoWBhAuN5V/y9JmjZYLwSkD6B2OxGvXRvTicgCrkaG
         Xpka+hjMwl4TY64NqomFcqJcPndM2ghu0Y+Y78IXUnCZEDUBQNgiHV1g9/W2sYOJDIn8
         T8GGchfYyf6aRrPBYkh7SlfInrVzOmQGTFq+CC9kP1xAZmfxGb4A9UbgC6ysc40TeXTj
         j5LaUqdMd2SpfR7FDg+8TlMEKh8l6+HqD0/9KuuhrUazcD8JkWKLmUXzMtOKPdP3Ply0
         rpIH7QBLdV5OBMIPuzXd2XcVUuCly4k4m3kAMuuegaG0RCu2IBHYbcAD484e1+KAfNWf
         VXRg==
X-Gm-Message-State: AGi0PuZ6EttyrL0icO5DrTCn8UrdIm/oDEShkeahEKLP1LFHq/DnS/BQ
        4Jw/KQC9GCx18hgZVkOxcr9f7ZAKO9hJqHCcjmc73A==
X-Google-Smtp-Source: APiQypK4t+PF8tt/SGAM8xALAG/aAG8RF3dYqDnfYxjk7JSdykupBOiWh+ZYe+V26P1bNFYl7z37eN37H5JA/ap7zUw=
X-Received: by 2002:a1f:ff11:: with SMTP id p17mr9338065vki.25.1587551586524;
 Wed, 22 Apr 2020 03:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <408ebea1-725d-2f8e-7d26-a2cb4d7754d3@first-world.info> <20200422082836.GL25745@shell.armlinux.org.uk>
In-Reply-To: <20200422082836.GL25745@shell.armlinux.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Apr 2020 12:32:30 +0200
Message-ID: <CAPDyKFqCLN9-Wq8aYDRp4xYUQLa_1J1fMyiaE=CuANLbvDUYRw@mail.gmail.com>
Subject: Re: 2 bug repport
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        alpha_one_x86 <alpha_one_x86@first-world.info>
Cc:     Hu Ziji <huziji@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Apr 2020 at 10:29, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 22, 2020 at 03:03:57AM -0400, alpha_one_x86 wrote:
> > Hi,
> >
> > On mcbin platform I have uSD problem, repported but no reply on linux kernel
> > bugzilla, https://bugzilla.kernel.org/show_bug.cgi?id=207083
> >
> > Any idea what patch try?
>
> I think that's a question for the MMC people.
>
> If you go back to your working 4.20 kernel, does the problem go away?
> If so, it sounds like a regression in the MMC subsystem.  If not, I
> wonder if it could be the uSD card going bad.
>
> However, I suspect the former.  I've seen one instance here where a
> Clearfog GT8k (Armada 8040 based just like the mcbin) running 5.6 with
> the rootfs on eMMC completely lost the ability to talk to the eMMC to
> the point that the machine had to be power cycled to recover it -
> merely rebooting did not.  I don't know the cause - the initial failure
> had vanished from the kernel logs, and because the eMMC was no longer
> accessible, the rsyslog files did not contain the details either.
> I've since setup remote logging, and I'm currently waiting for it to
> happen again.  I couldn't say if _that_ is a regression because I
> haven't been using the GT8k until very recently, and I tend not to use
> eMMC/uSD on the Macchiatobin that runs 24x7.

In v5.6 the following commits were introduced - and it has turned out
that a few other sdhci controllers had issues with them (which we have
fixed now).

Perhaps you can try a v5.6 kernel and just revert them and see if that
could help - as a start

533a6cfe08f9 ("mmc: core: Default to generic_cmd6_time as timeout in
__mmc_switch()")
ad91619aa9d7 ("mmc: block: Use generic_cmd6_time when modifying
INAND_CMD38_ARG_EXT_CSD")
24ed3bd01d6a ("mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC")

Kind regards
Uffe
