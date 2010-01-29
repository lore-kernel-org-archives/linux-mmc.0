From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] mmc: au1xmmc: allow platforms to disable host
 capabilities
Date: Fri, 29 Jan 2010 01:10:51 +0100
Message-ID: <20100129001051.GD13143@linux-mips.org>
References: <4AD57FDE.1040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:47208 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0A2AKr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2010 19:10:47 -0500
Received: from localhost.localdomain ([127.0.0.1]:54643 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492737Ab0A2AKo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 29 Jan 2010 01:10:44 +0100
Content-Disposition: inline
In-Reply-To: <4AD57FDE.1040206@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mmc@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>, Linux-MIPS <linux-mips@linux-mips.org>

On Wed, Oct 14, 2009 at 09:38:06AM +0200, Manuel Lauss wrote:

> Although the hardware supports a 4/8bit SD interface and the driver
> unconditionally advertises all hardware caps to the MMC core, not all
> datalines may actually be wired up.  This patch introduces another
> field to au1xmmc platform data allowing platforms to disable certain
> advanced host controller features.

Haven't heared anything from the MMC folks so I've queued this one for
2.6.34.

Thanks,

  Ralf
