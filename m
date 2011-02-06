From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] mmc_test: Don't warn about not waiting for busy if
 controller can't do this
Date: Sun, 6 Feb 2011 19:53:59 +0000
Message-ID: <20110206195359.3dfeef7a@mfleming-mobl1.ger.corp.intel.com>
References: <1295283631-7965-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:32778 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753173Ab1BFTyH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2011 14:54:07 -0500
In-Reply-To: <1295283631-7965-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 17 Jan 2011 17:00:31 +0000
Pawel Moll <pawel.moll@arm.com> wrote:

> If the MMC host controller does not support waiting for card signaling
> busy state (MMC_CAP_WAIT_WHILE_BUSY cap), there is no point in prining
> the relevant warning message.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/mmc/card/mmc_test.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Seems straight forward.

Reviewed-by: Matt Fleming <matt@console-pimps.org>
