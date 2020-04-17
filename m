Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE04C2D0EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 13:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2AB214AF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 13:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJpcmkBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgDQNzd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730731AbgDQNzc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 09:55:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA5C061A0C;
        Fri, 17 Apr 2020 06:55:31 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so833036ilp.13;
        Fri, 17 Apr 2020 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OzUUDoJadsiieg+ssnYgOj42UdsJ0RJ/vkPjDepgAS8=;
        b=tJpcmkBxeQFfb1K1gqwBoimoekXBDdRQuWIdbNjxCM1mCXNZ3NuB+l5LLW1uPgQ05R
         Ch/sL5FP+FBKpf9GeQ2Xxl2s78gHb/0P9Mijvq/9ainBn5wR0dgL31NJCv9jeqBgeLGr
         p4k5oLVKZTnMq3vWzMBX5GNY+Fl9nGMWCkV+sFucBggm0XqBgEn2aiyGCJuhqWMCJtwz
         fDyGdzMf/XS6s+J7TljmCeuDGYbAloXr+oWvZGq8OFDUn6atmJN5YEvXMeFpSK8Ccvh/
         ++G2AbOyrG5sGXVMY9/0pOmHuraRDYvGspsM863OiTwJ7k5qG2F2SfAowocRjbozL3Ce
         Lz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OzUUDoJadsiieg+ssnYgOj42UdsJ0RJ/vkPjDepgAS8=;
        b=GcYm/LKnRhkJbGMULxir4zowj1ypwRm1tV9B7WEbhBHOF/0TwaPwR7oLqxXZyH9j7+
         Gyf6Qq7/jjpyNEjOXphHfwWr+OfLaWRm/KpZWbxXj8AsJgbmDbzelREPm8NJ/2x6fJoB
         blu2qe1bnb5cvEJsfiTJA2L3zIZhdXFttOr9aUzunCkWonotKS0fdKNLoy2iFp9Navfd
         ATgOFcIANo+zQw5P6udr8pCFIVT6mz+Q769woEEqYpRxxc8VVvEsRC54EHq7vcYtqfvJ
         eR6Z2XgrgNP7+WCSCYEFUWpZ8vZMM6TbFfsPZFnmxRok5vz1pFDZrDTgPRQATuizMPQj
         stbg==
X-Gm-Message-State: AGi0PuYUrXyWi8sIHRcaeBM7EglrwUTF6MQj9QGy3q5C9VATCCcrw7n8
        PbP896wE29QiZZzrsJXRK03+ZxE8dV7EDMBZuL0=
X-Google-Smtp-Source: APiQypJkZwCmAzmwzeVRASom5X4pM84AMdRVr4twxaMF4HzV++qpNsF2s19yLzLVSfHQ80dV5qm2CswcfjTs/APD7/k=
X-Received: by 2002:a92:4896:: with SMTP id j22mr2956518ilg.158.1587131730396;
 Fri, 17 Apr 2020 06:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl> <23c3fe72b0ff0eabdbf3a45023a76da1b18a7e90.1585827904.git.mirq-linux@rere.qmqm.pl>
 <218dd61b-48cc-a161-240f-b3823e8f48cb@intel.com> <20200415162839.GD19897@qmqm.qmqm.pl>
 <57b494b8-cae9-df10-2a4d-db02e7212f23@intel.com>
In-Reply-To: <57b494b8-cae9-df10-2a4d-db02e7212f23@intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 17 Apr 2020 09:55:19 -0400
Message-ID: <CAOGqxeVB2FTTi4DFynVj4hc+EcagMCg1j8F29L+9zRt1DKfbBQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] mmc: sdhci: fix base clock usage in preset value
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Acked-by: Al Cooper <alcooperx@gmail.com>On Thu, Apr 16, 2020 at 4:27
AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 15/04/20 7:28 pm, Micha=C5=82 Miros=C5=82aw wrote:
> > On Wed, Apr 15, 2020 at 03:25:52PM +0300, Adrian Hunter wrote:
> >> On 2/04/20 2:54 pm, Micha=C5=82 Miros=C5=82aw wrote:
> >>> Fixed commit added an unnecessary read of CLOCK_CONTROL. The value re=
ad
> >>> is overwritten for programmable clock preset, but is carried over for
> >>> divided clock preset. This can confuse sdhci_enable_clk() if the regi=
ster
> >>> has enable bits set for some reason at time time of clock calculation=
.
> >>> value to be ORed with enable flags. Remove the read.
> >>
> >> The read is not needed, but drivers usually manage the enable bits,
> >> especially disabling the clock before changing the frequency.  What dr=
iver
> >> is it?
> >
> > Hopefully no driver requires this. It's just removing a trap.
>
> The only driver that looks like it would benefit is sdhci-brcmstb because=
 it
> does not clear enable bits in sdhci_brcmstb_set_clock().  Adding Al Coope=
r.
> Al, can you ack this?

sdhci_brcmstb_set_clock() assumed that sdhci_calc_clk() would always
return the divider value without the enable set, so this fixes a case
for DDR52 where the enable was not being cleared when the divider
value was changed.
Acked-by: Al Cooper <alcooperx@gmail.com>
