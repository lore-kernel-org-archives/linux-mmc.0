From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Wed, 5 Jan 2011 01:34:59 +0200
Message-ID: <AANLkTik8FNxAhGz8Dzj=h4S1hyDGUYw4HSAhzwHWfWpG@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-4-git-send-email-ohad@wizery.com> <AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
 <AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com> <AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:51920 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1ADXfT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 18:35:19 -0500
Received: by iyf40 with SMTP id 40so6851330iyf.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 15:35:19 -0800 (PST)
In-Reply-To: <AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

On Wed, Jan 5, 2011 at 1:25 AM, Pierre Tardy <tardyp@gmail.com> wrote:
> There is no such platform data in intel_mid platforms.. Sound like
> another platform hack will be needed for wl1271 to be integrated. :-(

John (cc'ed) ported this to your platform and can share the solution
with you; IIRC the idea was the same: identify the card according to
the slot id (this is reasonable because the card is nonremovable) and
set it as MMC_QUIRK_NONSTD_FUNC_IF.

> Our first idea to resolve this problem was to hardcode wl1273 vendor
> id/product id in a black list table near read_fbr...

I'm not sure we want to hardcode such details in the SDIO core itself
(think of how it would look if more devices will show up..).

Thanks,
Ohad.
