From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/5] mmc: davinci: prepare clock
Date: Tue, 15 Mar 2016 14:43:25 +0530
Message-ID: <56E7D235.9070404@ti.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-4-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55738 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbcCOJOl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2016 05:14:41 -0400
In-Reply-To: <1457996081-21975-4-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: khilman@kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Tuesday 15 March 2016 04:24 AM, David Lechner wrote:
> When trying to use this driver with the common clock framework, enabling
> the clock fails because it was not prepared. This fixes the problem by
> calling clk_prepare and clk_enable in a single function. Ditto for
> clk_disable_unprepare.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Regards,
Sekhar
