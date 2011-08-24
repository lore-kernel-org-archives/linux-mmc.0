From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci move vmmc to set_ios
Date: Wed, 24 Aug 2011 21:22:21 +0800
Message-ID: <CAMj5BkhyPtbFJfpDKssoWiTDbjAjwy5TuJJa8zATrBOCjuENSA@mail.gmail.com>
References: <1311663973-23715-1-git-send-email-zhangfei.gao@marvell.com>
	<1311663973-23715-2-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52003 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab1HXNWW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2011 09:22:22 -0400
Received: by qwk3 with SMTP id 3so672579qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2011 06:22:21 -0700 (PDT)
In-Reply-To: <1311663973-23715-2-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ohad Ben-Cohen <ohad@wizery.com>

On Tue, Jul 26, 2011 at 3:06 PM, Zhangfei Gao <zhangfei.gao@marvell.com=
> wrote:
> Move vmmc to set_ios, as a result mmc_power_up/down handles regulator=
_enable/disable vmmc
> Move regulator outof spin_lock, since usually i2c operation is called
> Remove vmmc from suspend/resume function, instead vmmc is handled pro=
perly in mmc_suspend/resume_host according to mmc_card_keep_power
>
> CC: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0 27 +++++++++++++++------------
> =A0include/linux/mmc/sdhci.h | =A0 =A01 +
> =A02 files changed, 16 insertions(+), 12 deletions(-)
>

Hi, Daniel

We found some impact to sd if reusing vmmc in set_ios, when no sd card
is inserted.
When no sd card, CD pin is high, but when vmmc is disabled in
mmc_power_down, as a result CD pin will be pulled down, which is same
as sd card is inserted, however the card detect will fail since no sd
card in fact.

So additional regulator vsdio still required to control power of
vsdio, to make mmc_power_up/down control sdio power.

Thanks
