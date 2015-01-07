From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
Date: Wed, 07 Jan 2015 17:13:44 +0100
Message-ID: <10623722.YrKe6DgiSS@wuerfel>
References: <22569458.nE7JkNNnz3@wuerfel> <2633187.PyovTNc8DC@wuerfel> <54AD42D0.4070402@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57013 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbAGQNz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jan 2015 11:13:55 -0500
In-Reply-To: <54AD42D0.4070402@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org

On Wednesday 07 January 2015 15:29:36 Lars-Peter Clausen wrote:
> On 01/06/2015 02:48 PM, Arnd Bergmann wrote:
> > On Tuesday 06 January 2015 11:45:58 Lars-Peter Clausen wrote:
> >> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
> >>> As discussed on the topic of shmobile DMA today, jz4740 is the only
> >>> user of the slave_id field in dma_slave_config besides shmobile. This
> >>> use is really incompatible with the way that other drivers use the
> >>> dmaengine API, so we should get rid of it.
> >>
> >> Do you have a link to that discussion?
> >
> > http://www.spinics.net/lists/linux-mmc/msg30069.html
> 
> I'm really not comfortable with this patch, since it is a step back. But I 
> guess the end justify the means. So if it helps to get rid of slave_id I'm 
> ok with it, sooner or later jz4740 will be converted to DT so once that's 
> done the filter function can be removed again. But please put the filter 
> function in a non arch specific header so we can still compile test things. 
> And maybe note in the commit message that this is meant as a temporary hack.
> 

Do you have a timeline for DT support? Maybe it's easier to just
wait for the problem to solve itself.

	Arnd
