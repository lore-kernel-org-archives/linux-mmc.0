From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Tools to read eMMC registers?
Date: Fri, 19 Aug 2011 09:08:51 +0200
Message-ID: <3037570.4brBQrqVRc@wuerfel>
References: <4E4D5DC8.4010605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64658 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab1HSHJV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2011 03:09:21 -0400
In-Reply-To: <4E4D5DC8.4010605@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: linux-mmc@vger.kernel.org

On Thursday 18 August 2011 11:45:28 J Freyensee wrote:
> Are there any tools, software (free or proprietary but preferably 
> Linux-based) or hardware probes, that can read eMMC registers?  If so, 
> would you be able to provide a link to it?
> 
> Thanks, I appreciate it!

You can read a subset of the registers by looking into
/sys/block/mmcblk*/device/*

If you are looking for a register other than those, it shouldn't
be hard to hack the mmcblock driver to export that too.

	Arnd
