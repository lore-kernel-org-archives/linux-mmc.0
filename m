From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] Enabling patches for Intel MID SDHCI
Date: Thu, 7 Oct 2010 19:07:30 +0100
Message-ID: <20101007180730.GB15745@void.printf.net>
References: <20101004142246.901.37491.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46231 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab0JGSHb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Oct 2010 14:07:31 -0400
Content-Disposition: inline
In-Reply-To: <20101004142246.901.37491.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mmc@vger.kernel.org

Hi Alan,

On Mon, Oct 04, 2010 at 03:23:55PM +0100, Alan Cox wrote:
> Try again...
> 
> This adds basic support for the Intel MID platform devices. It doesn't include
> the callback stuff to handle some of the errata but I'm trying to verify
> which if any of those make sense outside of Intel before resubmitting that
> bit.

Thanks, applied to mmc-next / queued for 2.6.37.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
