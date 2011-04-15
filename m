From: Cyril Hrubis <metan@ucw.cz>
Subject: Re: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
Date: Fri, 15 Apr 2011 23:34:07 +0200
Message-ID: <20110415213407.GB4420@atrey.karlin.mff.cuni.cz>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com> <1302556424-21951-2-git-send-email-andreiw@motorola.com> <5D8008F58939784290FAB48F54975198389075A5E9@shsmsx502.ccr.corp.intel.com> <BANLkTin6Aya3KpY6NUYtHTWRpg7azO5nOg@mail.gmail.com> <5D8008F58939784290FAB48F5497519838C3288867@shsmsx502.ccr.corp.intel.com> <BANLkTiksXp7fgjkeNcGbh+HTMxjtBbo=xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:38188 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757160Ab1DOVeI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 17:34:08 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTiksXp7fgjkeNcGbh+HTMxjtBbo=xA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "cjb@laptop.org" <cjb@laptop.org>

Hi!
> > Yes, if all the consumers of mmc_command memset the structure to 0, there
> > will be no problem. But just reviewed the code, and found mmc_app_cmd() (in
> > sd_ops.c) didn't memset the command structure. So I think if we can make
> > sure all the command structures will be initialized before using it, that
> > would be better.
>
> I would say that CMD55 is not a command that utilizes the DAT line,
> again, so not setting cmd_timeout itself is not a problem.
> 
> However, using uninitialized data is nasty, and can lead to problems
> if cmd->data ever happens to be not NULL.
> I'll send a patch for this tomorrow. Thanks for catching this. I'm
> curious if this is the reason behind Cyril's problem.
> 
> Cyril can you try modifying mmc_app_cmd like this? Does that do
> anything for you?
> 
> static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> {
>         int err;
>         struct mmc_command cmd;
> 
>         BUG_ON(!host);
>         BUG_ON(card && (card->host != host));
> 
> +      memset(&cmd, 0, sizeof(struct mmc_command));
>         cmd.opcode = MMC_APP_CMD;
>

Not really, it behaves same regardless the memset().

-- 
metan 
