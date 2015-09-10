From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: block: Add new ioctl to send multi commands
Date: Thu, 10 Sep 2015 10:38:27 +0200
Message-ID: <1992614.qXMDtKgeKR@wuerfel>
References: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com> <3546402.HsxrhMD6nc@wuerfel> <55F13E33.9000703@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55496 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbIJIib (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2015 04:38:31 -0400
In-Reply-To: <55F13E33.9000703@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, grundler@google.com, olofj@chromium.org, Seshagiri Holi <sholi@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 10 September 2015 09:24:19 Jon Hunter wrote:
> On 09/09/15 21:22, Arnd Bergmann wrote:
> > On Wednesday 09 September 2015 17:44:54 Jon Hunter wrote:
> >> On 09/09/15 16:56, Arnd Bergmann wrote:
> >>> On Wednesday 09 September 2015 16:06:01 Jon Hunter wrote:
> 
> > - you have some implicit padding after the structure and should replace that
> >   with explictit pad bytes to extend the structure to a multiple of its
> >   alignment (8 bytes).
> 
> Would padding with __u32 at the end be sufficient here? I assume the
> __u32 would be 32-bit aligned. However, was not sure if this would
> always be the case.

If you have a layout of 

	__u64 pointer; 
	__u8 size;
	__u32 pad;

you still get three bytes of implied padding between size and pad. It's
better to just have '__u8 __pad[7]' in that case.

> > I was not referring to the use of an __u64 variable to pass a pointer, that
> > is expected (and the macro would make it harder to understand).
> > 
> > What I meant instead was the use of a pointer to an array as opposed to
> > passing the array itself. With the definition I gave above, the size would
> > still be the same on all architectures (you can replace the __u64 with
> > an __u8 plus padding if you like), as sizeof(struct mmc_ioc_multi_cmd)
> > is just '8' here.
> 
> Do you have any strong preference here? I guess I don't and agree
> neither are ideal.
> 
> > Alternatively, you could just use an array of struct mmc_ioc_cmd by
> > itself and encode the length in the ioctl command:
> > 
> > #define MMC_COMBO_IOC_CMD(n) _IOC(_IOC_READ|_IOC_WRITE, 1, sizeof(struct mmc_ioc_cmd) * (n))
> > 
> > This is of course also ugly because the ioctl command number is not
> > fixed, and because the limit for the number of mmc command blocks
> > is architecture dependent, depending on the definition of the _IOC
> > macro that can have either 13 or 14 bits to encode the argument length
> > in bytes.
> 
> Interesting idea. However, given your comments above, I think that I
> would rather place the size in the structure.

I don't have a strong preference here. If there is a slight chance that
you might need more than ((1<<13) / sizeof(struct mmc_ioc_cmd)) mmc commands
in one ioctl, you can rule out that last solution.

If you can prove that this length would always be sufficient, I'd probably
pick that approach. Otherwise, I'd pick the one the size followed by
an an open array.

	Arnd
