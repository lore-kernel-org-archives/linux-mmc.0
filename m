From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pci: identify correct base addresses for slots
Date: Sat, 26 Oct 2013 21:23:47 -0400
Message-ID: <87iowjld5o.fsf@octavius.laptop.org>
References: <1372670535-2778-1-git-send-email-jackey.shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47921 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab3J0BXx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Oct 2013 21:23:53 -0400
In-Reply-To: <1372670535-2778-1-git-send-email-jackey.shen@amd.com> (Jackey
	Shen's message of "Mon, 1 Jul 2013 17:22:15 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jackey Shen <jackey.shen@amd.com>
Cc: linux-mmc@vger.kernel.org

Hi Jackey,

On Mon, Jul 01 2013, Jackey Shen wrote:
> A PCI Based SD Host Controller can support up to a total of six SD Slots, and
> the base addresses are specified by Slot Information Register of its PCI header.
> Please refer to C.3.3 of SD Host Controller Standard Specification Version 3.0.

Out of curiosity (and for the patch record), do you have hardware that
requires this patch that you've tested it on, or is it just theoretical?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
