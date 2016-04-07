From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: linux-4.6-rc2/drivers/mmc/host/sdhci.c:3033: pointless test ?
Date: Thu, 7 Apr 2016 11:07:33 +0300
Message-ID: <57061545.80601@intel.com>
References: <DUB128-W16B599992A5DF1CBD18A799C9F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22872 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbcDGILR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Apr 2016 04:11:17 -0400
In-Reply-To: <DUB128-W16B599992A5DF1CBD18A799C9F0@phx.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 06/04/16 19:38, David Binderman wrote:
> linux-4.6-rc2/drivers/mmc/host/sdhci.c:3033]: (style) Redundant
> condition: mmc.f_max. '!mmc.f_max || (mmc.f_max && mmc.f_max>max_clk)' is
> equivalent to '!mmc.f_max || mmc.f_max>max_clk'
> 
> Source code is
> 
> if (!mmc->f_max || (mmc->f_max && (mmc->f_max> max_clk)))

I made a patch which I will include later with other fixes I am doing.
