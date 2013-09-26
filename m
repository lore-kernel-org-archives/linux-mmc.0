From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] Write-reliability settings support
Date: Wed, 25 Sep 2013 22:18:32 -0400
Message-ID: <87k3i42umf.fsf@octavius.laptop.org>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50735 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754262Ab3IZCSt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 22:18:49 -0400
In-Reply-To: <cover.1379602866.git.ben.l.gardiner@gmail.com> (Ben Gardiner's
	message of "Thu, 19 Sep 2013 11:14:26 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Gardiner <ben.l.gardiner@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Ben,

On Thu, Sep 19 2013, Ben Gardiner wrote:
> This series builds on top of 
> d91d3698c6464a83b7c301eb84da109f9f94b54c
>
> It introduces
>  * an extracted function for setting the PARTITION_SETTING_COMPLETE bit
>  * a command for setting the write-reliability bits
>  * pretty-printing the write-reliability bits from EXTCSD registers
>
> available also https://github.com/BenGardiner/mmc-utils/tree/features/reliable-write
> if it helps.
>
> Ben Gardiner (3):
>   extract PARTITION_SETTING_COMPLETE function
>   pretty print write reliability settings
>   support setting the OTP write reliability settings
>
>  mmc.c      |   5 +++
>  mmc.h      |   1 +
>  mmc_cmds.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  mmc_cmds.h |   1 +
>  4 files changed, 129 insertions(+), 21 deletions(-)

I've pushed all three patches to mmc-utils now.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
