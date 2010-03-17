From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Wed, 17 Mar 2010 09:49:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:41726 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab0CQN63 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Mar 2010 09:58:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZF0066XIEB5A20@VL-MR-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 17 Mar 2010 09:49:23 -0400 (EDT)
In-reply-to: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu

On Wed, 17 Mar 2010, Hemanth V wrote:

> Hi All,
> 
> We are trying to enable highmem support for OMAP based boards, while doing so
> we are
> unable to boot poky UI if the filesystem is in a MMC card.
> 
> The poky UI comes up fine if the filesystem is in NAND or NFS,
> while with MMC it gives errors like segmentation faults/syntax error while
> there are none.
> Seems like read from MMC is getting corrupted.

Yes, this is a known issue with highmem on ARM architectures v6 and 
later, related to some cache mishandling.  This is not a MMC issue as 
the problem occurs when booting from SATA too. The problem is still 
investigated.


Nicolas
