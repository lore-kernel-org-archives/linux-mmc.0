From: Arnd Bergmann <arnd.bergmann@linaro.org>
Subject: Re: [PATCH 1/2] [MMC-4.5] Disable emulation
Date: Thu, 17 May 2012 07:07:34 +0000
Message-ID: <201205170707.34674.arnd.bergmann@linaro.org>
References: <1337185615-17202-1-git-send-email-saugata.das@stericsson.com> <CAKLKtzeZaOJ7vKqLgj5HYJF18ww+=C5LwWkU_i-77D0Xz6EVSQ@mail.gmail.com> <CAKYAXd_pNg0MwX5vR2Pegn0UeSX3=qO4WU70QExfiFooD8yLuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61907 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759685Ab2EQHHo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 03:07:44 -0400
In-Reply-To: <CAKYAXd_pNg0MwX5vR2Pegn0UeSX3=qO4WU70QExfiFooD8yLuw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Saugata Das <saugata.das@linaro.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, venkat@linaro.org, patches@linaro.org, lporzio@micron.com

On Thursday 17 May 2012, Namjae Jeon wrote:
> 2012/5/17, Saugata Das <saugata.das@linaro.org>:
> > On 17 May 2012 06:35, Namjae Jeon <linkinjeon@gmail.com> wrote:
> >> 2012/5/17, Saugata Das <saugata.das@stericsson.com>:
> >> If you change native 4K from 512B emulation, filesystem sector size is
> >> also 4KB align as well block size.
> >> because default block size of most of filesystem is 4KB, but
> >> filesystem sector size is 512B,
> >> So filesystem corruption can be occured on native 4K device.
> >>>
> >
> > I have tested ext4 with 4KB block size and I did not see an instance
> > where it requested 512B.
> -> yes, you can not see it, because when formating parittion, sector
> size is set to 4K by I/O topology. As you know, several filesystems
> can be used on eMMC not only Ext4. You should mention filesystem
> sector size align in changelog.

It's important to note here that if someone tries to use a block size
of less than 4KB on eMMC, or has a misaligned partition, that is already
a mistake and causes increased wear and reduced performance. Forcing 4KB
alignment is defintely a good idea and I would recommend setting the
'disable emulation' flag on all hardware that allows it just for this
reason.

Also note that hard drives and SSDs are also moving to 4KB hard sector
size and other block devices (DVD-RAM, DASD, ...) have only supported
larger sectors since the start and can be used with most file systems.

	Arnd
