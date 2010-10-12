From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Mon, 11 Oct 2010 20:39:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010112036540.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
 <alpine.LFD.2.00.1010112005300.2764@xanadu.home>
 <AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:21264 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab0JLAjz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 20:39:55 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA500IQSJ6IDUB0@VL-MO-MR003.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 11 Oct 2010 20:39:54 -0400 (EDT)
In-reply-to: <AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 11 Oct 2010, Dmitry Shmidt wrote:

> Hi Nicolas,
> 
> Because for example some sdio device (like wlan) can be powered after
> suspend (we are not talking about desktop or laptop)
> and be a source of wakeup. And we don't want to remove it every time we are
> going to suspend.

See MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ.  That's exactly what 
they're for.  The OLPC Git tree should contain example usage by the 
libertas driver.


Nicolas
