From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc/sdio: don't allow interface to runtime-suspend until
 probe is finished.
Date: Sun, 11 Dec 2011 09:30:48 +0200
Message-ID: <CAK=WgbbZU=NJupPCeXfy5WcFCvzoCgmcf5HPWUEFaHMwLLCWJg@mail.gmail.com>
References: <20111205125416.6093ecd8@notabene.brown> <CAK=Wgbb-6eV6aDxTdi3qFLZmu0cHSZvHRUpUEr3YQ=4tO5sCPw@mail.gmail.com>
 <20111206060654.0e8bebe0@notabene.brown> <CAK=WgbbqgAYZ8uurf+xVyCxfZxoHcLdytxzdUNtoP9VNYPd57A@mail.gmail.com>
 <20111210181546.6da7099a@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56316 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab1LKHbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Dec 2011 02:31:10 -0500
In-Reply-To: <20111210181546.6da7099a@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Daniel Drake <dsd@laptop.org>, Joe Woodward <jw@terrafix.co.uk>, Chris Ball <cjb@laptop.org>, Bing Zhao <bzhao@marvell.com>

On Sat, Dec 10, 2011 at 9:15 AM, NeilBrown <neilb@suse.de> wrote:
> When I force it to hold off suspend for a little while I see (startin=
g at the
> same place):
>
> [ =A0656.189697] bus: 'sdio': driver_probe_device: matched device mmc=
1:0001:1 with driver libertas_sdio
> [ =A0656.212768] bus: 'sdio': really_probe: probing driver libertas_s=
dio with device mmc1:0001:1
> [ =A0656.247741] libertas_sdio mmc1:0001:1: firmware: requesting libe=
rtas/sd8686_v9_helper.bin
> [ =A0656.257537] device: 'mmc1:0001:1': device_add
> [ =A0656.263580] PM: Adding info for No Bus:mmc1:0001:1
> [ =A0656.298187] device: 'mmc1:0001:1': device_unregister
> [ =A0656.303375] PM: Removing info for No Bus:mmc1:0001:1
> [ =A0656.322967] libertas_sdio mmc1:0001:1: firmware: requesting libe=
rtas/sd8686_v8_helper.bin
> [ =A0656.344207] device: 'mmc1:0001:1': device_add
> [ =A0656.357147] PM: Adding info for No Bus:mmc1:0001:1
> [ =A0656.395782] device: 'mmc1:0001:1': device_unregister
> [ =A0656.407409] PM: Removing info for No Bus:mmc1:0001:1
> [ =A0656.418579] libertas_sdio mmc1:0001:1: firmware: requesting sd86=
86_helper.bin
> [ =A0656.435699] device: 'mmc1:0001:1': device_add
> [ =A0656.446655] PM: Adding info for No Bus:mmc1:0001:1
> [ =A0656.504974] device: 'mmc1:0001:1': device_unregister
> [ =A0656.511749] PM: Removing info for No Bus:mmc1:0001:1
> [ =A0656.521148] libertas_sdio mmc1:0001:1: firmware: requesting sd86=
86.bin
> [ =A0656.529205] device: 'mmc1:0001:1': device_add
> [ =A0656.535095] PM: Adding info for No Bus:mmc1:0001:1
> [ =A0656.584625] device: 'mmc1:0001:1': device_unregister
> [ =A0656.591369] PM: Removing info for No Bus:mmc1:0001:1
> [ =A0657.384063] libertas_sdio mmc1:0001:1: (unregistered net_device)=
: 00:19:88:3d:ff:f0, fw 9.70.3p24, cap 0x00000303
> [ =A0657.454467] libertas_sdio mmc1:0001:1: (unregistered net_device)=
: PREP_CMD: command 0x00a3 failed: 2
> [ =A0657.464080] device: 'phy0': device_add
>
>
> =A0But shortly there after the extra tracing I put in shows that mmc_=
power_off
> =A0is called,

Probably right after libertas' if_sdio_probe() returns ?

> then mmc_sdio_power_restore calls mmc_send_io_op_cond

Is that as a result of libertas' if_sdio_power_restore() being called
(i.e. someone/something called 'ifconfig up') ?

> which again
> =A0returns -110, but now it isn't a problem and the wifi chip keeps w=
orking.

if_sdio_power_restore doesn't check the return value of
pm_runtime_get_sync, so it won't error out, but I wonder how come the
chip still works.

> =A0So maybe the fact that we error-out in the first case is a problem=
??

It might be nice if Marvell could comment on this, though we can
probably empirically deduce this too.

> =A0I found that if I pull the reset line down and then let it back up=
 then it
> =A0all works.

Nice. Joe, did this work out for you too ?

> So I have run out of ideas. =A0I can make it work by reseting the chi=
p during
> mmc_power_up but I have no idea what is causing the chip to need a re=
set.

I wonder why the sdio reset command isn't helpful for you - it did
seem to resolve some issues for Daniel. Maybe you have two different
hardware revisions of the 8686 which behave differently in this
respect ?

> However for now I think I'll go with my 'remux' hack.

=46eel free to post it so we can take a look.

Thanks,
Ohad.
