From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: remove repetitive clear interrupt
Date: Mon, 25 Jan 2016 09:55:53 +0100
Message-ID: <1630713.rPyRx6D05H@wuerfel>
References: <1453684420-1860-1-git-send-email-shawn.lin@rock-chips.com> <56A5A11A.5030103@samsung.com> <56A5AAF9.5090002@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:64536 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcAYI4D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2016 03:56:03 -0500
In-Reply-To: <56A5AAF9.5090002@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 25 January 2016 12:56:25 Shawn Lin wrote:
> On 2016/1/25 12:14, Jaehoon Chung wrote:
> > Hi, Shawn.
> >
> > On 01/25/2016 10:13 AM, Shawn Lin wrote:
> >> This patch remove repetitive clear interrupt while
> >> probing dw_mmc.
> >
> > Could you explain to me more?
> 
> yes, it's a trivial improvement.
> 
> dw_mci_probe clear interrupt and disable all interrupt firstly.
> Then commit 2da1d7f2 add a new clear-interrupt operation before
> enable some interrupt. I can't see any reason to clear it twice
> here. No any side effect I had found in my test pattern without this
> . May I miss some important case?
> 

The explanation should go into the patch description to explain why
it is done. The one sentence "This patch remove repetitive clear
interrupt while probing dw_mmc" that you wrote instead can be
removed, it just repeats the patch subject.

	Arnd
