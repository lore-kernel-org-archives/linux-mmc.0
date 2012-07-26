From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 2/2] mmc: card: Adding support for sanitize in eMMC 4.5
Date: Thu, 26 Jul 2012 13:27:49 +0000
Message-ID: <201207261327.49781.arnd@arndb.de>
References: <1343208766-8046-1-git-send-email-ygardi@codeaurora.org> <1343208766-8046-3-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57537 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab2GZVo7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jul 2012 17:44:59 -0400
In-Reply-To: <1343208766-8046-3-git-send-email-ygardi@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Wednesday 25 July 2012, Yaniv Gardi wrote:
> This feature delete the unmap memory region of the eMMC card,
> by writing to a specific register in the EXT_CSD
> unmap region is the memory region that were previously deleted
> (by erase, trim or discard operation)
> 
> Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>

This looks like it will only work for eMMC-4.5 but not for SD-3.01, which
offers the same funcitonality in the form of the "start recording" option
to CMD20. Is there any reason why you would want to implement one but
not the other?

	Arnd

