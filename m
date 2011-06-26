From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Sun, 26 Jun 2011 15:33:48 +0300
Message-ID: <BANLkTikQvu=+oXCb-K+NvnXZJjs=8gH8Sw@mail.gmail.com>
References: <20110625182011.7CB8E9D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61625 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab1FZMeM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Jun 2011 08:34:12 -0400
Received: by wwe5 with SMTP id 5so4032151wwe.1
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2011 05:34:10 -0700 (PDT)
In-Reply-To: <20110625182011.7CB8E9D401C@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Sat, Jun 25, 2011 at 9:20 PM, Daniel Drake <dsd@laptop.org> wrote:
> mmc_sdio_power_restore() skips some steps that are performed in other
> power-related codepaths which are necessary to fully reset the card.
> Without this, runtime PM fails for SD8686 SDIO wifi on OLPC XO-1.5.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Thanks for your work, Daniel.

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
