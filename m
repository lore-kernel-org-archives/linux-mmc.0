From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: core: eMMC in Sleep mode before suspend
Date: Thu, 12 Apr 2012 00:24:12 -0400
Message-ID: <87wr5lr30z.fsf@laptop.org>
References: <1315499919-804-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49815 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752Ab2DLEYT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Apr 2012 00:24:19 -0400
In-Reply-To: <1315499919-804-1-git-send-email-balajitk@ti.com> (Balaji T. K.'s
	message of "Thu, 8 Sep 2011 22:08:39 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, adrian.hunter@intel.com, Venkatraman S <svenkatr@ti.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>

Hi,

On Thu, Sep 08 2011, Balaji T K wrote:
> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
> in the mmc suspend so that Vcc (NAND core) can be cut
> to minimize power consumption.
> eMMC put into SLEEP can respond to CMD0 or H/W reset or CMD5.
> Current implemention on resume from suspend relies on CMD0 in
> mmc_init_card to get out of SLEEP mode.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Acked-by: Venkatraman S <svenkatr@ti.com>

I've just tried this on an eMMC 4.41 device (Sandisk SEM04G) with
sdhci-pxav3, and it resulted in a crash on the way into suspend:

[   18.379192] PM: Syncing filesystems ... done.
[   18.423866] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   18.446542] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[   18.549586] PM: Device sdhci-pxav3.2 failed to suspend: error -110
[   18.583808] PM: Some devices failed to suspend
[   22.141284] mmcblk0: error -110 sending status command, retrying
[   22.153150] mmcblk0: error -110 sending status command, retrying
[   22.164708] mmcblk0: error -110 sending status command, aborting
[   22.176097] end_request: I/O error, dev mmcblk0, sector 4430104
[..]

Digging down, the -110 is coming from:

int mmc_card_sleepawake(struct mmc_host *host, int sleep)
{
        struct mmc_command cmd = {0};
        struct mmc_card *card = host->card;
        int err;

        if (sleep)
                mmc_deselect_cards(host);

        cmd.opcode = MMC_SLEEP_AWAKE;
        cmd.arg = card->rca << 16;
        if (sleep)
                cmd.arg |= 1 << 15;

        cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
        err = mmc_wait_for_cmd(host, &cmd, 0);
        if (err)
                return err;
        [..]

Has anyone tried sleepawake on an SEM04G before?

It seems likely (I haven't tested yet, but will do) that the card
actually went into sleep successfully and is waiting for an AWAKE
command, even though mmc_wait_for_cmd() returned a timeout.
If so, any suggestions on how to handle that case?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
