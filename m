From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Mon, 22 Feb 2010 15:11:34 +0000
Message-ID: <4B829EA6.40307@csr.com>
References: <cover.1266847842.git.david.vrabel@csr.com> <94a0d4531002220655p675f7648rdfd302ea6aeb1b58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:37336 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0BVPPd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2010 10:15:33 -0500
In-Reply-To: <94a0d4531002220655p675f7648rdfd302ea6aeb1b58@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com

Felipe Contreras wrote:
> On Mon, Feb 22, 2010 at 4:24 PM, David Vrabel <david.vrabel@csr.com> wrote:
>> These patches add support for SDIO cards to the omap_hsmmc driver.
>> Power management changes to prevent SDIO cards from being turned off
>> and losing all state, and card interrupts.
>>
>> I've been unable to test these exact patches as I only have an N900 for
>> testing and the N900 support in mainline is incomplete.
> 
> Can't you get the source code with 'apt-get source' in Maemo SDK? It's
> a tarball but at least it's something.

I have SDIO cards tested and working on the N900 with the Fremantle
kernel but that's a modified 2.6.28 kernel.  These patches are for
mainline and there are differences between mainline and the fremantle
kernel that means they need different patches.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
