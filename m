From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2] arm, da8xx, mmc: set second MMC controllers default
 queue
Date: Thu, 12 Jan 2012 09:19:44 +0000
Message-ID: <DF0F476B391FA8409C78302C7BA518B63178E65C@DBDE01.ent.ti.com>
References: <1322991210-20486-1-git-send-email-hs@denx.de>
 <1323327357-23886-1-git-send-email-hs@denx.de> <4F0D4848.4070000@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55565 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab2ALJTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2012 04:19:55 -0500
In-Reply-To: <4F0D4848.4070000@denx.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "hs@denx.de" <hs@denx.de>
Cc: "juha.kuikka@gmail.com" <juha.kuikka@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Wolfgang Denk <wd@denx.de>, Sergei Shtylyov <sshtylyov@mvista.com>

Hi Heiko,

On Wed, Jan 11, 2012 at 13:58:56, Heiko Schocher wrote:
> Hello,
> 
> Heiko Schocher wrote:
> > The MMC driver allocates channels with EVENTQ_DEFAULT, they
> > get put into EVENTQ_1, which the second EDMA controller does
> > not have and hence transfers stall. This is fixed
> > in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf
> > "ARM: davinci: Explicitly set channel controllers' default queues"
> > from Ido Yariv. This patch sets immediately in edma_probe()
> > the proper default_queue, so this patch does not really fix
> > something, it is more a cosmetic change.
> > 
> > Signed-off-by: Heiko Schocher <hs@denx.de>
> > Signed-off-by: juha.kuikka@gmail.com
> > Reported-by: juha.kuikka@gmail.com
> > Acked-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: davinci-linux-open-source@linux.davincidsp.com
> > Cc: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> > Cc: Ido Yariv <ido@wizery.com>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Cc: Wolfgang Denk <wd@denx.de>
> > Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> > 
> > ---
> > - changes for v2:
> >   - add comment from Sergei Shtylyov
> >     add in commit message the commit's summary in parens.
> >   - add comment from Ido Yariv:
> >     changed comment and commit message
> >   - added Acked-by from Rajashekhara, Sudhakar
> > 
> >  arch/arm/mach-davinci/dma.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> Ping. Can this patch go into mainline, or are there some more objections?

Hmm, looks like you asking "no need for applying my
patch" in an earlier e-mail on this topic made me
discard this.

I had a look and the patch is OK. Except, I think the
comment can do better without reference to TC1 since
its not relevant once the code has been fixed. Also,
the comment is better placed in edma.h where near
the default_queue member definition since that's where
folks will look up when setting up the default queue.

So, the comment can simply be:

+		/*
+		 * Default queue is expected to be a low-priority queue.
+		 * This way, long transfers on the default queue started
+		 * by the codec engine will not cause audio defects.

Similarly you can drop references to the MMC/SD issue and the
fix in the commit text since its not directly relevant to your
patch.

Can you fix this up so I can apply it? Please note that patches
for mach-davinci should be pre-fixed with "ARM: davinci: ".

Also Cc linux-arm-kernel@lists.infradead.org on ARM patch submissions.

Thanks,
Sekhar

