From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH V4] mmc: allow upper layers to determine immediately if
 a card has been removed
Date: Thu, 01 Dec 2011 16:04:12 +0530
Message-ID: <4ED75824.20205@codeaurora.org>
References: <1322490120-23429-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:31983 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab1LAKeR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 05:34:17 -0500
In-Reply-To: <1322490120-23429-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, per.lkml@gmail.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 11/28/2011 7:52 PM, Adrian Hunter wrote:
> Add a function mmc_detect_card_removed() which upper layers
> can use to determine immediately if a card has been removed.
> This function should be called after an I/O request fails so
> that all queued I/O requests can be errored out immediately
> instead of waiting for the card device to be removed.
>
> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
Acked-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

--
Thanks,
Sujit

