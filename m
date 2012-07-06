From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] sdhci: poll for card even when card is logically unremovable
Date: Fri, 6 Jul 2012 08:49:20 -0600
Message-ID: <CAMLZHHS2XKwmUrUj2ajvhQCtrQpSD4=zQfcGWhd_U+EBba7Zgw@mail.gmail.com>
References: <20120705210613.8B3F89D401E@zog.reactivated.net>
	<4FF6A065.9050700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38775 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab2GFOtV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jul 2012 10:49:21 -0400
Received: by pbbrp8 with SMTP id rp8so14726988pbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 Jul 2012 07:49:20 -0700 (PDT)
In-Reply-To: <4FF6A065.9050700@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Fri, Jul 6, 2012 at 2:23 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Daniel,
>
> When enabled MMC_UNSAFE_RESUME, it assumed that card didn't remove
> during suspend/resume.
> If you need to remove the card during suspend/resume,
> why enable MMC_UNSAFE_RESUME?

We don't want to remove the card during suspend/resume.

We want the card to remain present during suspend/resume with any open
mounts and files untouched (the previous patch), and we want the
ability to hotplug cards while the system is running (this patch)
after the user has unmounted it.

Thanks,
Daniel
