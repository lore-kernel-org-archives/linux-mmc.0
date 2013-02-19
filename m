From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9 0/2] *** adding and exposing SANITIZE capability to
 the user space via a unique IOCTL ***
Date: Tue, 19 Feb 2013 08:26:10 -0800
Message-ID: <20130219162610.GL17414@htj.dyndns.org>
References: <1361290937-7427-1-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:60316 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758244Ab3BSQ0P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 11:26:15 -0500
Content-Disposition: inline
In-Reply-To: <1361290937-7427-1-git-send-email-ygardi@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org, jaxboe@fusionio.com, akpm@linux-foundation.org, linux-arm-msm@vger.kernel.org

(resending as requested)

On Tue, Feb 19, 2013 at 06:22:15PM +0200, Yaniv Gardi wrote:
> *** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***

If this is something eMMC specific and not expected to have in-kernel
consumer, unlike DISCARD which filesystems use, why not just use
SG_IO?

Thanks.

-- 
tejun
