From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4] mmc: allow upper layers to determine immediately if a card has been removed
Date: Thu, 01 Dec 2011 13:50:36 -0500
Message-ID: <87r50ojfcz.fsf@laptop.org>
References: <1322490120-23429-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49386 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330Ab1LASuc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 13:50:32 -0500
In-Reply-To: <1322490120-23429-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 28 Nov 2011 16:22:00 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, per.lkml@gmail.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi Adrian, Sujit,

On Mon, Nov 28 2011, Adrian Hunter wrote:
> Add a function mmc_detect_card_removed() which upper layers
> can use to determine immediately if a card has been removed.
> This function should be called after an I/O request fails so
> that all queued I/O requests can be errored out immediately
> instead of waiting for the card device to be removed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for working on this -- pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
