From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/14] mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
Date: Sun, 8 Jan 2012 10:25:33 +0000
Message-ID: <20120108102533.GA21765@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-11-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43907 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab2AHKZn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jan 2012 05:25:43 -0500
Content-Disposition: inline
In-Reply-To: <1323106560-5218-11-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Mon, Dec 05, 2011 at 06:35:56PM +0100, Ulf Hansson wrote:
> Instead of reading a register value everytime we need to
> apply a new value for it, maintain a cached copy for it.
> This also means we are able to skip writes that are not
> needed.

I'm not sure this is a good idea.  The ARM Primecells require a certain
number of bus clocks and MCLK periods between writes to both these
registers, and reading them back helps to ensure that we conform to
that requirement.  Maintaining a cached copy of them allows faster
writes to these registers which could cause that requirement to be
violated.

What you could do is read the register, modify, and check whether the
modification has had any effect before writing it back.  That will
allow unnecessary writes to still be skipped.
