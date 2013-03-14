From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer
 forever.
Date: Thu, 14 Mar 2013 20:58:57 +0100
Message-ID: <20130314205857.7b0ad091@crub>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
	<20130219151414.2aa318d7@crub>
	<5126421D.7010204@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36942 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab3CNT67 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 15:58:59 -0400
In-Reply-To: <5126421D.7010204@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Javier Martin <javier.martin@vista-silicon.com>, linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, cjb@laptop.org, gcembed@gmail.com, festevam@gmail.com

Hi Fabio,

On Thu, 21 Feb 2013 12:49:49 -0300
Fabio Estevam <fabio.estevam@freescale.com> wrote:

> Hi Anatolij,
> 
> Anatolij Gustschin wrote:
> 
> > this change introduces a race condition for host->req (and maybe
> > for host->data) accesses. The callback is running in soft-irq context and can
> > be interrupted by the mxcmci_irq() interrupt which can finish the request and
> > set host->req to NULL. Then mxcmci_data_done() crashes with a null pointer
> > dereference. How extensively was it tested?
> 
> Does the patch below help?

Sorry for long delay. No, it doesn't help. With this patch applied
the task copying data to the sd-card hangs forever. I used following
patch to fix observed crashes:

 http://thread.gmane.org/gmane.linux.kernel.mmc/19658/focus=19662

Thanks anyway!

Anatolij
