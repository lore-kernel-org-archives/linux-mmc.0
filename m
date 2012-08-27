From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: core: pre-patch for next eMMC version
Date: Mon, 27 Aug 2012 14:04:29 +0200
Message-ID: <CAPDyKFqJynoS5d3EmnRi4CxmUyOMYBRzy2spDgUTfT=7+0Xg6Q@mail.gmail.com>
References: <5036C96A.7070300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38832 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2H0MEb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 08:04:31 -0400
Received: by weyx8 with SMTP id x8so2306348wey.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Aug 2012 05:04:29 -0700 (PDT)
In-Reply-To: <5036C96A.7070300@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

I think this patches as of now does not really make sense. These types
of devices is far from reaching the market and just saying that a
later revision in the ext_csd is supported is too simple. Moreover,
why shall we add a quirk for a problem that does not even exist.

Kind regards
Ulf Hansson

On 24 August 2012 02:23, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> eMMC card revision have increased more faster than before.
> We need to prepare the next eMMC revision(eMMCx.0).
> Its revision is 0x7. (eMMC4.5 is 0x6 - can get the information at ext_csd register)
>
> Jaehoon Chung (2):
>   mmc: core: prepare the next version of eMMC card
>   mmc: core: add the quirk for broken revision
>
>  drivers/mmc/core/mmc.c     |   15 ++++++++++-----
>  include/linux/mmc/card.h   |    1 +
>  include/linux/mmc/host.h   |    1 +
>  5 files changed, 17 insertions(+), 5 deletions(-)
>
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
