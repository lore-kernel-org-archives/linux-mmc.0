From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v6 11/14] mmc: sdhci: fix the bug that DDR50 can't work
 for emmc
Date: Sat, 8 Dec 2012 09:54:55 +0800
Message-ID: <CADz5_gJfx6iZqx_007OKen+HviM2FJP5rnNbtnJoEPdqBg3SEw@mail.gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-12-git-send-email-keyuan.liu@gmail.com>
	<87zk2f7t8h.fsf@octavius.laptop.org>
	<CADz5_gJq9vA1mhabMtupBaBqfNcwGV6TnkaOZwoLocwNgmLPFw@mail.gmail.com>
	<CADz5_g+ncZdBLQwSh2Vkia+OD7VtXuLtKFsp-z2bM8JJu10Sog@mail.gmail.com>
	<87r4n1bruo.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40737 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530Ab2LHBy5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 20:54:57 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so445457wey.19
        for <linux-mmc@vger.kernel.org>; Fri, 07 Dec 2012 17:54:56 -0800 (PST)
In-Reply-To: <87r4n1bruo.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, cxie4@marvell.com, Philip Rakity <prakity@nvidia.com>, kliu5@marvell.com

2012/12/8 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Mon, Nov 19 2012, Kevin Liu wrote:
>> In fact, I don't think 3.3v vccq for emmc can work under DDR50 mode
>> with SD host.
>
> I've checked on the scope that we're reaching DDR50 with our 3.3V vccq
> eMMC, so it looks like this isn't true.
>

Chris,

Thanks for the check.
If you are using sdhci-pxav3.c, 3.3v vccq can work since it enabled
the 1.8v signaling in the callback function set_uhs_signaling.
What I want to say is if you don't enable the 1.8v signaling bit while
using 3.3v vccq, DDR50 on emmc should NOT work. (Use default sdhci
code without implementing set_uhs_signaling as the other drivers.)
You can just remove the set_uhs_signaling in sdhci-pxav3.c and try again.
So we should do this in sdhci.c by default and remove the callback
function, which only aim to enabling the 1.8v signaling bit.

Kevin
