From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/4] mmc: davinci: fix unwinding in probe
Date: Mon, 14 Mar 2016 17:22:46 +0530
Message-ID: <56E6A60E.7040808@ti.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-3-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbcCNLyF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2016 07:54:05 -0400
In-Reply-To: <1457567405-30475-3-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>, ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

Hi David,

On Thursday 10 March 2016 05:20 AM, David Lechner wrote:
> Unwiding from an error in davinci_mmcsd_probe was a mess. Some errors were
> not handled and not all paths unwound correctly.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Since you are touching this, can you also shift to using devm_*()
variants where possible (like devm_ioremap()). That will simplify the
error handling quite a bit.

Regards,
Sekhar

