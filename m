From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v3] ARM: davinci: map default_queue to edma channels
Date: Thu, 2 Feb 2012 19:53:11 +0000
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317AE7C6@DBDE01.ent.ti.com>
References: <1326956721-25158-1-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6317970CE@DBDE01.ent.ti.com>
 <4F28DE58.3040902@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41630 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933313Ab2BBTx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2012 14:53:26 -0500
In-Reply-To: <4F28DE58.3040902@denx.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "hs@denx.de" <hs@denx.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "juha.kuikka@gmail.com" <juha.kuikka@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Wolfgang Denk <wd@denx.de>, Sergei Shtylyov <sshtylyov@mvista.com>

Hi Heiko,

On Wed, Feb 01, 2012 at 12:10:24, Heiko Schocher wrote:
> Hello Nori,
> 
> Nori, Sekhar wrote:
> > Hi Heiko,
> > 
> > On Thu, Jan 19, 2012 at 12:35:21, Heiko Schocher wrote:
> >> Default queue is expected to be a low-priority queue.
> >> This way, long transfers on the default queue started
> >> by the codec engine will not cause audio defects.
> >>
> >> Signed-off-by: Heiko Schocher <hs@denx.de>
> > 
> >> Signed-off-by: juha.kuikka@gmail.com
> >> Reported-by: juha.kuikka@gmail.com
> > 
> > Sign-off should include real name, so I changed these
> > two lines to:
> > 
> >     Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
> >     Reported-by: Juha Kuikka <juha.kuikka@gmail.com>
> 
> Thanks!
> 
> > before applying. Let me know if anyone has objections.
> 
> I saw no objections, so can this patch go in now?

Queuing this for v3.4. Thanks for the reminder.

Regards,
Sekhar
