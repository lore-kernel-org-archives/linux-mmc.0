From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat@webczatnet.pl>
Subject: Re: [PATCH 0/2] mmc: meson-gx: fix mmc module unloading
Date: Thu, 16 Feb 2017 15:48:00 +0100
Message-ID: <7318e9b7-79cc-3703-074b-8d9ccb50fbd6@webczatnet.pl>
References: <20170216143955.1233-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:59542 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754664AbdBPOsE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Feb 2017 09:48:04 -0500
In-Reply-To: <20170216143955.1233-1-webczat@webczatnet.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Sorry, did not send the whole patch series and have to resend.


W dniu 16.02.2017 o 15:39, Michał Zegan pisze:
> This patch series fixes mmc driver unloading.
> Previously, unloading meson-gx-mmc module would trigger kernel warnings.
>
> Michał Zegan (2):
>   mmc: meson-gx: prevent cfg_div_clk from being disabled on init
>   mmc: meson-gx: remove mmc host on device removal
>
>  drivers/mmc/host/meson-gx-mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

