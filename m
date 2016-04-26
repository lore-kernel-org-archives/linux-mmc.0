From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 0/6] mmc: tmio/sdhi: clean up cruft
Date: Tue, 26 Apr 2016 18:00:22 +0200
Message-ID: <5670294.DxdOlL4ZCe@wuerfel>
References: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:56052 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbcDZQAg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2016 12:00:36 -0400
In-Reply-To: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>

On Tuesday 26 April 2016 17:55:21 Wolfram Sang wrote:
> Largely due to DT unification, some parts of the code became obsolete. Let's
> remove that, the code is complex enough still:
> 
> * There are no boards anymore with named interrupt support. Drop support for
>   that (patches 2-4)
> * No need anymore for a public mmc/tmio.h header file. Merge it into the
>   private one (patch 5)
> 
> Patches 1 and 6 are small cleanups found on the way 
> 
> Based on latest renesas-drivers which is based on v4.6-rc1 with my sdr50
> patches on top. Tested on a Renesas Lager board and build bot is happy, too
> (after finding some issues initially).
> 
> Change since V1:
> 
> * Drop a small cleanup touching SH board files, so we stay in the MMC realm.
>   I will do this as a seperate patch so this series won't get delayed.
> 
> Please test, comment, apply...
> 

Looks really nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
