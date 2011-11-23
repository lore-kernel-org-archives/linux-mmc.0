From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2] mmc: core: Fix deadlock when the CONFIG_MMC_UNSAFE_RESUME
 is not defined
Date: Wed, 23 Nov 2011 09:55:41 +0100
Message-ID: <4ECCB50D.3080008@stericsson.com>
References: <1322017998-16559-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:54849 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752411Ab1KWI4I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 03:56:08 -0500
In-Reply-To: <1322017998-16559-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>

Sujit Reddy Thumma wrote:
> mmc_suspend_host() tries to claim host during suspend
> and release it only when the bus suspend operation is
> compeleted. If CONFIG_MMC_UNSAFE_RESUME is defined and
> the host is flagged as removable, mmc_suspend_host()
> tries to remove the card. In this process, the file system
> sync can get blocked trying to acquire host which is already
> claimed by mmc_suspend_host() causing deadlock.
> 
> Fix this deadlock by releasing host before ->remove() is called.
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> 

Looks good to me!

Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>

