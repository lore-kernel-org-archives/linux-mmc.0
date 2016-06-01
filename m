From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
Date: Wed, 1 Jun 2016 11:58:34 -0700
Message-ID: <CAOCOHw7aHvSUUoxkrDkGwNrTGNbZm-3RSuhJF3CCvRUiK5tDgg@mail.gmail.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
	<1464505484-3661-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:34945 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbcFAS6f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2016 14:58:35 -0400
Received: by mail-it0-f44.google.com with SMTP id z189so89342803itg.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2016 11:58:35 -0700 (PDT)
In-Reply-To: <1464505484-3661-2-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Sun, May 29, 2016 at 12:04 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> When IS_ERR_VALUE was removed from the mmc core code, it was replaced
> with a simple not-zero check. This does not work, as the value checked
> is the return value for mmc_select_bus_width, which returns the set
> bit width on success. This made eMMC modes higher than HS-DDR unusable.
>
> Fix this by checking for a positive return value instead.

mmc_select_bus_width() can return 0 on "success" as well and the
previous check was !IS_ERR_VALUE(err), which coverts that. So I
believe these checks should be for err >= 0 rather than just > 0.


Either way this fixes the boot failures seen on my Qualcomm based
boards with v4.7-rc1.

Regards,
Bjorn
