From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V8 0/2] HS200 Mode support for device and host
Date: Thu, 29 Dec 2011 17:19:58 +0530
Message-ID: <CAGxe1ZH=9OUp9YZi0nHHuwkBcQGYM40m0GYUMAOFaw6Vf6cfkA@mail.gmail.com>
References: <1324624322-2189-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53489 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1L2Lt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2011 06:49:59 -0500
Received: by vcbfk14 with SMTP id fk14so10048175vcb.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2011 03:49:58 -0800 (PST)
In-Reply-To: <1324624322-2189-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Chris,
can you add this patch series in your next pull request

On 23 December 2011 12:42, Girish K S <girish.shivananjappa@linaro.org>=
 wrote:
> changes in v7:
> =A0 =A0 =A0 =A0Updated with review comments for minor changes in host=
 conditional
> =A0 =A0 =A0 =A0handling. added the handling for 4 bit bus width.
> Changes in v6:
> =A0 =A0 =A0 split the patch into 2 and classified them as a patch for=
 device
> =A0 =A0 =A0 and host. Modified to include the review comments.
> Changes in v5:
> =A0 =A0 =A0 Reduced the case statements for better code readability. =
Removed
> =A0 =A0 =A0 unused macro definitions. Modified the tuning function pr=
ototype
> =A0 =A0 =A0 and definition to support tuning for both SD and eMMC car=
ds.
> Changes in v4:
> =A0 =A0 =A0 Rebased onto chris-mmc/mmc-next branch. This patch is suc=
cessfully
> =A0 =A0 =A0 applied on commit with id de022ed3fdc14808299b2fa66dbb1ed=
5ab921912.
> Changes in v3:
> =A0 =A0 =A0 In the previous commits of chris-mmc/mmc-next branch, the=
 patch with
> =A0 =A0 =A0 commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) defi=
nes caps2 for
> =A0 =A0 =A0 more capabilities. This patch version deletes the member =
ext_caps(created
> =A0 =A0 =A0 in my earlier patch) from struct mmc_host and reuses alre=
ady accepted
> =A0 =A0 =A0 caps2 member.
> Changes in v2:
> =A0 =A0 =A0 Rebased to latest chris-mmc/mmc-next branch. Resolved ind=
entation
> =A0 =A0 =A0 problems identified in review. This patch has to be appli=
ed before
> =A0 =A0 =A0 the patch released for modifying the printk messages.
> Changes in v1:
> =A0 =A0 =A0 Case statements in switch that produce same result have
> =A0 =A0 =A0 been combined to reduce repeated assignments.
> =A0 =A0 =A0 patch recreated after rebase to chris balls mmc-next bran=
ch.
>
> Girish K S (2):
> =A0mmc: core: HS200 mode support for eMMC 4.5
> =A0mmc: host: Adds support for eMMC 4.5 HS200 mode
>
> =A0drivers/mmc/core/bus.c =A0 =A0 | =A0 =A03 +-
> =A0drivers/mmc/core/debugfs.c | =A0 =A03 +
> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0163 ++++++++++++++++++++++++++=
+++++++++++++++---
> =A0drivers/mmc/core/sd.c =A0 =A0 =A0| =A0 =A03 +-
> =A0drivers/mmc/core/sdio.c =A0 =A0| =A0 =A04 +-
> =A0drivers/mmc/host/sdhci.c =A0 | =A0 45 +++++++++---
> =A0drivers/mmc/host/sdhci.h =A0 | =A0 =A01 +
> =A0include/linux/mmc/card.h =A0 | =A0 =A03 +
> =A0include/linux/mmc/host.h =A0 | =A0 11 +++-
> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 66 +++++++++++++++++-
> =A0include/linux/mmc/sdhci.h =A0| =A0 =A01 +
> =A011 files changed, 278 insertions(+), 25 deletions(-)
>
