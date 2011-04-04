From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: enable TRIM/ERASE caps for SDHCI host.
Date: Mon, 4 Apr 2011 03:34:12 -0500
Message-ID: <BANLkTi=eHfeXHfNr9gkyBe2VW6uwWMkA9Q@mail.gmail.com>
References: <BANLkTik0ijdeccTgqxf8Mu87s8jxevaOhA@mail.gmail.com>
	<1301907694-4533-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:50589 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab1DDIeQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 04:34:16 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p348WXpk017716
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 04:32:34 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p348WWwL017699
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 04:32:33 -0400 (EDT)
Received: by wwb28 with SMTP id 28so5868803wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 01:34:13 -0700 (PDT)
In-Reply-To: <1301907694-4533-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, Apr 4, 2011 at 4:01 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> SDHCI host controller has TRIM/ERASE capability, enable these caps for erasing
> purpose.
>
> ERASE command needs R1B response, so fix R1B-type command
> handling for SDHCI controller. For non-DAT commands using a busy
> reponse, the cmd->cmd_timeout (in ms) field is used for timeout
> calculations. cmd->cmd_timeout field is appropriately set to the
> correct erase timeout in core/core.c.
>
> Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

+Chuanxiao

Tested on Ricoh SDHCI controller (x64) with Arnd's erase tool (from
flashbench) for -
- Toshiba eMMC MMC08G (8Gb device) (with and without a changed version
my partitioning patch)
- SDHC SA08G (8Gb uSD in adapter)

Lack of proper R1B handling seems like a pervasive problem for other
host controller drivers as well. I can start making patches, but I
won't be able to test them since all I've got is SDHCI :(.

A
