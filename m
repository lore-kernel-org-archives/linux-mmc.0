From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
Date: Wed, 13 Apr 2011 00:44:30 -0500
Message-ID: <BANLkTiksXp7fgjkeNcGbh+HTMxjtBbo=xA@mail.gmail.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-2-git-send-email-andreiw@motorola.com>
	<5D8008F58939784290FAB48F54975198389075A5E9@shsmsx502.ccr.corp.intel.com>
	<BANLkTin6Aya3KpY6NUYtHTWRpg7azO5nOg@mail.gmail.com>
	<5D8008F58939784290FAB48F5497519838C3288867@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:43831 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab1DMFod convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 01:44:33 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3D5gh8w003136
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 01:42:43 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3D5ggnL003122
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 01:42:42 -0400 (EDT)
Received: by wwb28 with SMTP id 28so280897wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 22:44:30 -0700 (PDT)
In-Reply-To: <5D8008F58939784290FAB48F5497519838C3288867@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, metan@ucw.cz
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "cjb@laptop.org" <cjb@laptop.org>

On Tue, Apr 12, 2011 at 8:59 PM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:

> Yes, if all the consumers of mmc_command memset the structure to 0, there will be no problem. But just reviewed the code, and found mmc_app_cmd() (in sd_ops.c) didn't memset the command structure. So I think if we can make sure all the command structures will be initialized before using it, that would be better.

I would say that CMD55 is not a command that utilizes the DAT line,
again, so not setting cmd_timeout itself is not a problem.

However, using uninitialized data is nasty, and can lead to problems
if cmd->data ever happens to be not NULL.
I'll send a patch for this tomorrow. Thanks for catching this. I'm
curious if this is the reason behind Cyril's problem.

Cyril can you try modifying mmc_app_cmd like this? Does that do
anything for you?

static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
{
        int err;
        struct mmc_command cmd;

        BUG_ON(!host);
        BUG_ON(card && (card->host != host));

+      memset(&cmd, 0, sizeof(struct mmc_command));
        cmd.opcode = MMC_APP_CMD;

A
