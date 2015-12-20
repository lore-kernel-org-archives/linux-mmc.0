From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH] mmc: core: Enable tuning according to the actual timing
Date: Sun, 20 Dec 2015 12:51:04 +0100
Message-ID: <CAOQ7t2ZEQborWOvEbVSbqp227N_kAPfqD=YO8fN5k5hr7ybt5Q@mail.gmail.com>
References: <1450474474-2666-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34764 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbbLTLvF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Dec 2015 06:51:05 -0500
Received: by mail-wm0-f50.google.com with SMTP id l126so37323035wml.1
        for <linux-mmc@vger.kernel.org>; Sun, 20 Dec 2015 03:51:05 -0800 (PST)
In-Reply-To: <1450474474-2666-1-git-send-email-carlo@caione.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Yang, York" <weijuny@qti.qualcomm.com>, Barry Song <21cnbao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, jh80.chung@samsung.com, "Song, Barry" <baohuas@qti.qualcomm.com>, Carlo Caione <carlo@endlessm.com>

On Fri, Dec 18, 2015 at 10:34 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> While in sdhci_execute_tuning() the choice whether or not to enable the
> tuning is done on the actual timing, in the mmc_sdio_init_uhs_card() the
> check is done on the capability of the card.
>
> This difference is causing some issues with some SDIO cards in DDR50
> mode where the CDM19 is wrongly issued.
>
> With this patch we modify the check in both
> mmc_(sd|sdio)_init_uhs_card() functions to take the proper decision
> only according to the actual timing specification.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Uhm, apparently this is causing some issues with the eMMC on another
laptop I'm testing this patch on.
Please, disregard this patch. I'll post a v2 once I understand what's going on.

Thanks,

-- 
Carlo Caione
