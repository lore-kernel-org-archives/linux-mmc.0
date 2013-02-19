From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9 0/2] *** adding and exposing SANITIZE capability to
 the user space via a unique IOCTL ***
Date: Tue, 19 Feb 2013 08:17:20 -0800
Message-ID: <20130219161720.GK17414@htj.dyndns.org>
References: <1361290252-6004-1-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:46929 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab3BSQRZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 11:17:25 -0500
Content-Disposition: inline
In-Reply-To: <1361290252-6004-1-git-send-email-ygardi@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Tue, Feb 19, 2013 at 06:10:50PM +0200, Yaniv Gardi wrote:
> *** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***

If this is something eMMC specific and not expected to have in-kernel
consumer, unlike DISCARD which filesystems use, why not just use
SG_IO?

Thanks.

-- 
tejun
