From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [patch] sdhci: remove SDHCI_QUIRK_FORCE_1_BIT_DATA
Date: Tue, 9 Nov 2010 15:27:39 +0300
Message-ID: <20101109122739.GA6776@oksana.dev.rtsoft.ru>
References: <AANLkTimBGorfWHVCnVtUWx6n-22anXmQnKFXVGzB6TUf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45040 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab0KIM1p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 07:27:45 -0500
Received: by eye27 with SMTP id 27so3441286eye.19
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2010 04:27:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimBGorfWHVCnVtUWx6n-22anXmQnKFXVGzB6TUf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Xiaobo Xie <X.Xie@freescale.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kmpark@infradead.org>, Philip Rakity <prakity@marvell.com>, Pierre Ossman <pierre@ossman.eu>

Hi,

On Tue, Nov 09, 2010 at 06:37:58AM -0500, zhangfei gao wrote:
> Here is patch to remove SDHCI_QUIRK_FORCE_1_BIT_DATA, which only used
> in drivers/mmc/host/sdhci-of-core.c.
> The reason is quirk is too valuable resource, the type is u32, while
> the highest is (1<<29) now.

FYI, initially that wasn't a quirk. Here is Pierre's last opinion on that:

http://lists.ozlabs.org/pipermail/devicetree-discuss/2009-June/000981.html

Thanks,

> 1. MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA  is opened by default in sdhci.c
> 2. platform driver could close such flag after sdhci_add_host.
> 
> We have verified on our platform, would you mind check whether it
> impact your driver behavior.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
