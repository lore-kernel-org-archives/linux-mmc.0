From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH 2/2] sound: tegra_alc5632: Adjust to of_get_named_gpio() change
Date: Tue, 19 Jun 2012 09:29:58 +0300
Message-ID: <CALq1K=LXVqfiyrLjn+_p+NTU3X5RjyQzvKdVRf09zXk-RqbkrQ@mail.gmail.com>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
 <1340037743-12924-2-git-send-email-stigge@antcom.de> <CAAAP30G1qzDn+NKT1is+GJ9K2DS3Sm3QY+=n7s-P-Rop2b7FPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62875 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab2FSGaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jun 2012 02:30:20 -0400
Received: by lbbgm6 with SMTP id gm6so5319681lbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jun 2012 23:30:19 -0700 (PDT)
In-Reply-To: <CAAAP30G1qzDn+NKT1is+GJ9K2DS3Sm3QY+=n7s-P-Rop2b7FPQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Cc: Roland Stigge <stigge@antcom.de>, swarren@wwwdotorg.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org

On Mon, Jun 18, 2012 at 8:28 PM, Alexandre Pereira da Silva
<aletes.xgr@gmail.com> wrote:
> On Mon, Jun 18, 2012 at 1:42 PM, Roland Stigge <stigge@antcom.de> wro=
te:
>> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
>> gpios not probed yet. This patch adjusts tegra_alc5632 to this.
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Hi Alexandre,
Sorry to be rude, but can you explain me why did you "Acked-by" on this=
 patch ?
I don't see your name in git log for tegra_alc5632.c file:
http://git.kernel.org/?p=3Dlinux/kernel/git/broonie/sound.git;a=3Dhisto=
ry;f=3Dsound/soc/tegra/tegra_alc5632.c;h=3Dd684df294c0c5c80458b6de591c1=
6965027db14b;hb=3Drefs/heads/for-next

Thanks.

--=20
Leon Romanovsky | Independent Linux Consultant
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0www.leon.nu=C2=A0| leon@leon.nu
