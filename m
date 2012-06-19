From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Subject: Re: [PATCH 2/2] sound: tegra_alc5632: Adjust to of_get_named_gpio() change
Date: Tue, 19 Jun 2012 07:03:41 -0300
Message-ID: <CAAAP30FoHAbA1HcUCGQxorFymVDed19N1PPe-ZH0x0s3M+W8bg@mail.gmail.com>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
	<1340037743-12924-2-git-send-email-stigge@antcom.de>
	<CAAAP30G1qzDn+NKT1is+GJ9K2DS3Sm3QY+=n7s-P-Rop2b7FPQ@mail.gmail.com>
	<CALq1K=LXVqfiyrLjn+_p+NTU3X5RjyQzvKdVRf09zXk-RqbkrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48650 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2FSKDn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jun 2012 06:03:43 -0400
In-Reply-To: <CALq1K=LXVqfiyrLjn+_p+NTU3X5RjyQzvKdVRf09zXk-RqbkrQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Leon Romanovsky <leon@leon.nu>
Cc: Roland Stigge <stigge@antcom.de>, swarren@wwwdotorg.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org

On Tue, Jun 19, 2012 at 3:29 AM, Leon Romanovsky <leon@leon.nu> wrote:
> On Mon, Jun 18, 2012 at 8:28 PM, Alexandre Pereira da Silva
> <aletes.xgr@gmail.com> wrote:
>> On Mon, Jun 18, 2012 at 1:42 PM, Roland Stigge <stigge@antcom.de> wrote:
>>> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
>>> gpios not probed yet. This patch adjusts tegra_alc5632 to this.
>>>
>>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>> Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> Hi Alexandre,
> Sorry to be rude, but can you explain me why did you "Acked-by" on this patch ?
> I don't see your name in git log for tegra_alc5632.c file:
> http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=history;f=sound/soc/tegra/tegra_alc5632.c;h=d684df294c0c5c80458b6de591c16965027db14b;hb=refs/heads/for-next

I'm tracking Roland's work on Probe defer.
