From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH v2] mmc: core: eMMC in Sleep mode before suspend
Date: Thu, 12 Apr 2012 12:52:47 +0530
Message-ID: <CANrkHUbD6hP3BN0zE8W2T5kH+WzM9ZqUqTeG2YqZBFVS3bZDLw@mail.gmail.com>
References: <1315499919-804-1-git-send-email-balajitk@ti.com>
	<87wr5lr30z.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58976 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752051Ab2DLHWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Apr 2012 03:22:50 -0400
Received: by lagr15 with SMTP id r15so2592238lag.16
        for <linux-mmc@vger.kernel.org>; Thu, 12 Apr 2012 00:22:47 -0700 (PDT)
In-Reply-To: <87wr5lr30z.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, adrian.hunter@intel.com, Venkatraman S <svenkatr@ti.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>

On Thu, Apr 12, 2012 at 9:54 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Sep 08 2011, Balaji T K wrote:
>> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
>> in the mmc suspend so that Vcc (NAND core) can be cut
>> to minimize power consumption.
>> eMMC put into SLEEP can respond to CMD0 or H/W reset or CMD5.
>> Current implemention on resume from suspend relies on CMD0 in
>> mmc_init_card to get out of SLEEP mode.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> Acked-by: Venkatraman S <svenkatr@ti.com>
>
> I've just tried this on an eMMC 4.41 device (Sandisk SEM04G) with
> sdhci-pxav3, and it resulted in a crash on the way into suspend:
>
> [ =A0 18.379192] PM: Syncing filesystems ... done.
> [ =A0 18.423866] Freezing user space processes ... (elapsed 0.01 seco=
nds) done.
> [ =A0 18.446542] Freezing remaining freezable tasks ... (elapsed 0.01=
 seconds) done.
> [ =A0 18.549586] PM: Device sdhci-pxav3.2 failed to suspend: error -1=
10
> [ =A0 18.583808] PM: Some devices failed to suspend
> [ =A0 22.141284] mmcblk0: error -110 sending status command, retrying
> [ =A0 22.153150] mmcblk0: error -110 sending status command, retrying
> [ =A0 22.164708] mmcblk0: error -110 sending status command, aborting
> [ =A0 22.176097] end_request: I/O error, dev mmcblk0, sector 4430104
> [..]
>
> Digging down, the -110 is coming from:
>
> int mmc_card_sleepawake(struct mmc_host *host, int sleep)
> {
> =A0 =A0 =A0 =A0struct mmc_command cmd =3D {0};
> =A0 =A0 =A0 =A0struct mmc_card *card =3D host->card;
> =A0 =A0 =A0 =A0int err;
>
> =A0 =A0 =A0 =A0if (sleep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
>
> =A0 =A0 =A0 =A0cmd.opcode =3D MMC_SLEEP_AWAKE;
> =A0 =A0 =A0 =A0cmd.arg =3D card->rca << 16;
> =A0 =A0 =A0 =A0if (sleep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd.arg |=3D 1 << 15;
>
> =A0 =A0 =A0 =A0cmd.flags =3D MMC_RSP_R1B | MMC_CMD_AC;
> =A0 =A0 =A0 =A0err =3D mmc_wait_for_cmd(host, &cmd, 0);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0[..]
>
> Has anyone tried sleepawake on an SEM04G before?
>
Hi Chris,

I tried eMMC 4.41 device (Sandisk SEM08G) with
omap4, both CMD5 sleep/awake is successful

mmc_card_sleepawake (host, 1)
[   20.094451] mmc0: starting CMD7 arg 00000000 flags 00000000
[   20.103576] omap_hsmmc omap_hsmmc.1: mmc0: CMD7, argument 0x00000000
[   20.103576] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   20.110229] mmc0: req done (CMD7): 0: 00000000 00000000 00000000 000=
00000
[   20.122528] mmc0: starting CMD5 arg 00018000 flags 0000001d
[   20.128356] omap_hsmmc omap_hsmmc.1: mmc0: CMD5, argument 0x00018000
[   20.135040] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   20.140228] omap_hsmmc omap_hsmmc.1: IRQ Status is 2
[   20.140228] mmc0: req done (CMD5): 0: 00000600 00000000 00000000 000=
00000
[   20.152526] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0=
 timing 0

mmc_card_sleepawake (host, 0)
[   32.875762] mmc0: starting CMD5 arg 00010000 flags 0000001d
[   32.881591] omap_hsmmc omap_hsmmc.1: mmc0: CMD5, argument 0x00010000
[   32.888549] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   32.893737] omap_hsmmc omap_hsmmc.1: IRQ Status is 2
[   32.898925] mmc0: req done (CMD5): 0: 00001400 00000000 00000000 000=
00000
[   32.906066] mmc0: starting CMD7 arg 00010000 flags 00000015
[   32.911895] omap_hsmmc omap_hsmmc.1: mmc0: CMD7, argument 0x00010000
[   32.918884] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   32.918884] mmc0: req done (CMD7): 0: 00000700 00000000 00000000 000=
00000
[   32.931182] omap_hsmmc omap_hsmmc.1: disabled

> It seems likely (I haven't tested yet, but will do) that the card
> actually went into sleep successfully and is waiting for an AWAKE
> command, even though mmc_wait_for_cmd() returned a timeout.
> If so, any suggestions on how to handle that case?
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
