From: Chris Ball <cjb@laptop.org>
Subject: Re: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
Date: Wed, 10 Aug 2011 09:30:11 -0400
Message-ID: <m239h9tmvw.fsf@bob.laptop.org>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-2-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43572 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab1HJNa1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Aug 2011 09:30:27 -0400
In-Reply-To: <1302556424-21951-2-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Mon, 11 Apr 2011 16:13:42 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de, Chuanxiao Dong <chuanxiao.dong@intel.com>

Hi Andrei,

On Mon, Apr 11 2011, Andrei Warkentin wrote:
> ERASE command needs R1B response, so fix R1B-type command
> handling for SDHCI controller. For non-DAT commands using a busy
> reponse, the cmd->cmd_timeout_ms (in ms) field is used for timeout
> calculations.
>
> Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Looks like this patch has been implicated in causing IO errors on
ThinkPads with a Ricoh device -- please could you take a look at
https://bugzilla.kernel.org/show_bug.cgi?id=38922 ?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
