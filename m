From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH] sdio: add MMC_PM_SKIP_RESUME_PROBE to workaround powered resume
Date: Wed, 1 Sep 2010 20:40:01 +0200
Message-ID: <AANLkTinSO-SMyXCv3r-p5TOgWSkyyrSSe3KJX5V=7kHW@mail.gmail.com>
References: <1279763215-17574-1-git-send-email-bzhao@marvell.com>
	<m339tz6agq.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59591 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0IASkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 14:40:03 -0400
Received: by qwh6 with SMTP id 6so6644835qwh.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Sep 2010 11:40:02 -0700 (PDT)
In-Reply-To: <m339tz6agq.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Bing Zhao <bzhao@marvell.com>, linux-mmc@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Andrew Morton <akpm@linux-foundation.org>

2010/8/27 Chris Ball <cjb@laptop.org>:
> Any comments on this patch from the list?
>
> From: Bing Zhao <bzhao@marvell.com>
> Date: Wed, 21 Jul 2010 18:46:55 -0700
>
> Marvell 8686/8688 device will not respond to re-probe attemps
> in powered resume, if the card is in sleep mode.
> The added MMC_PM_SKIP_RESUME_PROBE flag is checked so that
> call to mmc_sdio_init_card() can be skipped.
[patch cut]

Simplified SDIO spec v.2.00 (section 6.14 - Bus State Diagram)
suggests, that initialization commands (CMD5, CMD3) are not accepted
in CMD state. As the card stays in that state on powered suspend (no
resetting CMD52 nor power cycle is issued) then reinitialization
should be entirely skipped on resume unless the power was lost between
suspend and resume (or card was temporarily removed from the slot).

Best Regards,
Micha=B3 Miros=B3aw
