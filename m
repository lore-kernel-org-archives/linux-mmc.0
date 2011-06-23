From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
Date: Thu, 23 Jun 2011 14:37:02 +0100
Message-ID: <20110623133702.GZ23234@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org> <20110621075319.GN26089@n2100.arm.linux.org.uk> <BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com> <BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46141 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab1FWNhR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2011 09:37:17 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On Tue, Jun 21, 2011 at 11:26:27AM +0200, Per Forlin wrote:
> Here are the results.

It looks like this patch is either a no-op or slightly worse.  As
people have been telling me that dsb is rather expensive, and this
patch results in less dsbs, I'm finding these results hard to believe.
It seems to be saying that dsb is an effective no-op on your platform.

So either people are wrong about dsb being expensive, the patch is
wrong, or there's something wrong with these results/test method.

You do have an error in the ported patch, as that hasn't updated the
v7 cache cleaning code to remove the dsb() there, but that would only
affect the write tests.
