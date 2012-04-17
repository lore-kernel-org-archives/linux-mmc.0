From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: refine non-removable card checking for card detection
Date: Tue, 17 Apr 2012 08:48:56 -0600
Message-ID: <CAMLZHHSnzQH_ncwtyi2vyzS8H2DBDxvtHKofitGnwUf5ya+xmQ@mail.gmail.com>
References: <20120409231420.B54649D401E@zog.reactivated.net>
	<1334044850-sup-1149@twin.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53356 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2DQOs5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 10:48:57 -0400
Received: by vbbff1 with SMTP id ff1so4199398vbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Apr 2012 07:48:56 -0700 (PDT)
In-Reply-To: <1334044850-sup-1149@twin.sascha.silbe.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Silbe <silbe@activitycentral.com>
Cc: cjb <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Tue, Apr 10, 2012 at 2:05 AM, Sascha Silbe <silbe@activitycentral.com> wrote:
> What exactly is the behaviour after this patch? Will systems running
> from SD cards attached to a host controller that's _not_ marked as
> MMC_CAP_NONREMOVABLE (e.g. the external SD card slot on XOs) work again?
> Or does it only fix running off internal SD cards (which are marked
> MMC_CAP_NONREMOVABLE)?

Not sure which issue you are referring to but it must be different.
This patch only affects cards that are inserted after boot and it
doesn't change the behaviour w.r.t MMC_CAP_NONREMOVABLE.

Daniel
