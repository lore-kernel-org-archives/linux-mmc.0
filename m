From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: Wait for card_busy before starting sdio requests
Date: Wed, 23 Sep 2015 23:43:24 +0200
Message-ID: <CAPDyKFqvnVTL0pDLc8S1Ssqmy5WXR9+=uCWq8ONmgrYU=Zzoow@mail.gmail.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33663 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbbIWVnZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 17:43:25 -0400
Received: by wiclk2 with SMTP id lk2so3248268wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2015 14:43:25 -0700 (PDT)
In-Reply-To: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <chris@printf.net>, Arend van Spriel <arend@broadcom.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 22 September 2015 at 17:30, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Ulf,
>
> Here is a non RFC version of my patch-set to wait for card_busy before
> starting sdio requests. It is the same as the RFC version of the set,
> but this time it has been tested no hardware which actually needs this
> and I can confirm now that this fixes wifi on that hardware.

Great! Thanks, applied for next!

>
> This patch-set should also allow removing this dw_mmc specific fix:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040
>
> As this patch-set fixes this problem in a generic manner.

Care to send a patch to remove the above hack/fix?

Kind regards
Uffe
