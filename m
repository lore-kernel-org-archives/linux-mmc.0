From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 3/4] mmc: davinci: prepare clock
Date: Mon, 14 Mar 2016 17:24:21 +0530
Message-ID: <56E6A66D.1080909@ti.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-4-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59062 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcCNLzi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2016 07:55:38 -0400
In-Reply-To: <1457567405-30475-4-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>, ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Thursday 10 March 2016 05:20 AM, David Lechner wrote:
> When trying to use this driver with the common clock framework, enabling
> the clock fails because it was not prepared. This fixes the problem by
> calling clk_prepare and clk_enable in a single function.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Patch looks good. But I wonder how you hit this issue since we dont use
common clock framework on mach-davinci and this driver is not used
anywhere else AFAIK.

Regards,
Sekhar

