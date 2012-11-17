From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/5] mmc: Add access to RPMB partition
Date: Sat, 17 Nov 2012 18:12:10 -0500
Message-ID: <87mwyf7rjp.fsf@octavius.laptop.org>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50209 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372Ab2KQXMR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 18:12:17 -0500
In-Reply-To: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	(Loic Pallardy's message of "Mon, 6 Aug 2012 17:12:26 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Krishna Konda <kkonda@codeaurora.org>

Hi Loic,

On Mon, Aug 06 2012, Loic Pallardy wrote:
> The goal of this patchserie is to offer access to MMC RPMB 
> (Replay Protected Memory Block) partition.
> The RPMB partition is used in general to store some secure data.
> It is accessible through a trusted mechanism described in 
> JEDEC standard JESD84-A441.
>
> This patchserie proposes following modifications:
> - detect RPMB capability and create RPMB block device if supported
> - extend MMC sysfs to provide access to RPMB partition size and 
>   reliable write sector count (information needed by user space to 
>   acces RPMB partition)
> - update IOCTL to support RPMB access. This includes automatic partition
>   switch and sending of Set Block Count (CMD23) message.
>
> RPMB partition becomes accessible using standard IOCTL interface.
> Patches don't include trusted mechanism or any verification. 
> It is user space or secure application responsability to provide the right 
> command and the entire data frame as defined by JEDEC standard.

I've merged this to mmc-next for 3.8 now; thanks to everyone who Acked.

If you have any userspace sample code that could be added to mmc-utils
to show how the interface can be used, feel free to send a patch.
Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
