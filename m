From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: can we remove the quirk  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
Date: Tue, 9 Nov 2010 12:08:35 +0000
Message-ID: <20101109120835.0fea3feb@lxorguk.ukuu.org.uk>
References: <4D68A6A7-2D95-463F-875B-DB52ECCC53F1@marvell.com>
	<65EBF3EE-DE1E-46A4-BF41-A9D5A6096673@marvell.com>
	<20101109115517.GD3223@pengutronix.de>
	<23C594B6-1B72-4DE0-8BE7-04E1FD36B58E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45652 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754515Ab0KIMKC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 07:10:02 -0500
In-Reply-To: <23C594B6-1B72-4DE0-8BE7-04E1FD36B58E@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zhangfei.gao@gmail.com>

I think I agree with Wolfram. Perhaps a much better model would be

"Anyone who adds a quirk will have to figure out how to remove one"

Several are trivial to remove and generalise into a couple of function
overrides.

Alan
