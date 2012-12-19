From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: Removing the unnecessary runtime_get/put in sdio_bus_remove()
Date: Wed, 19 Dec 2012 09:18:26 +0200
Message-ID: <CAK=WgbYM6hbYGHupLOfdgg457qSjur7=PteO--Lnzgh-14pkfw@mail.gmail.com>
References: <1355928677.1839.9.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:46460 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2LSH0t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Dec 2012 02:26:49 -0500
Received: by mail-la0-f41.google.com with SMTP id m15so1325163lah.14
        for <linux-mmc@vger.kernel.org>; Tue, 18 Dec 2012 23:26:48 -0800 (PST)
In-Reply-To: <1355928677.1839.9.camel@cliu38-desktop-build>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 19, 2012 at 4:51 PM, Chuansheng Liu
<chuansheng.liu@intel.com> wrote:
>
> The runtime_get_sync() is called during sdio_bus_probe(), then the device
> will be kept in active runtime state

Unless, of course, the driver powered it down.

>, so not neccessary to call
> runtime_get_sync/put_noidle() again in sdio_bus_remove().

See comment above...
