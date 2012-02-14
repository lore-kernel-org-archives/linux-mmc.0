From: Johan RUDHOLM <johan.rudholm@stericsson.com>
Subject: RE: ANNOUNCE: new "mmc-utils" repository
Date: Tue, 14 Feb 2012 09:04:26 +0100
Message-ID: <E2E6AC6BFAD06343BA2D97432459C1B60723E3414C@EXDCVYMBSTM005.EQ1STM.local>
References: <m2y5s8j86z.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:57629 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756357Ab2BNIEy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 03:04:54 -0500
In-Reply-To: <m2y5s8j86z.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Chris Ball wrote:

> Johan, when I try running these I'm seeing:
> 
> octavius:cjb~/git/mmc-utils % sudo ./mmc extcsd read /dev/mmcblk0
> sdhci-pci 0000:0d:00.0: mmc_blk_ioctl_cmd: cmd error -110
> ioctl: Connection timed out
> Could not read EXT_CSD from /dev/mmcblk0
> 
> Were you doing something to get the card back into idle state first,
> perhaps?

Thank you for giving the code a home!

Hmm... No, this works fine for me without doing anything special. Even when reading/writing from/to the card, it works fine. It is an eMMC, right?

Kind regards, Johan
