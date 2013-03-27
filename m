From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Wed, 27 Mar 2013 13:40:06 +0000
Message-ID: <201303271340.06521.arnd@arndb.de>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63714 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3C0NkQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Mar 2013 09:40:16 -0400
In-Reply-To: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Friday 01 March 2013, Ulf Hansson wrote:
> 
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> SDIO has been using runtime pm for a while to handle runtime power save
> operations. This patchset is enabling the option to make the sd/mmc
> blockdevices to use runtime pm as well.
> 
> The runtime pm implementation for the block device will make use of
> autosuspend to defer power save operation to after request inactivty for
> a certain time.
> 
> To actually perform some power save operations the corresponding bus ops
> for mmc and sd shall be implemented. Typically it could make sense to do
> BKOPS for eMMC in here.

As per IRC discussion:

Acked-by: Arnd Bergmann <arnd@arndb.de>
