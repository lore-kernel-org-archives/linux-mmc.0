From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 1/5] mmc: davinci: remove matching string
Date: Tue, 15 Mar 2016 14:42:39 +0530
Message-ID: <56E7D207.4080905@ti.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-2-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42561 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881AbcCOJN5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Mar 2016 05:13:57 -0400
In-Reply-To: <1457996081-21975-2-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: khilman@kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Tuesday 15 March 2016 04:24 AM, David Lechner wrote:
> The string "MMCSDCLK" is not actually used for clock lookup, so can be removed.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

In general, you can carry forward acks received in the last version of
the patch if the patch is unchanged.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
