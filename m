From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] mmc: host: sdhci-tegra: cleanup ifdefs
Date: Wed, 20 Feb 2013 12:15:29 -0700
Message-ID: <512520D1.5070103@wwwdotorg.org>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com> <1361385317-6020-4-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54108 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935522Ab3BTTPc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Feb 2013 14:15:32 -0500
In-Reply-To: <1361385317-6020-4-git-send-email-rklein@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Chris Ball <cjb@laptop.org>, linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, Pritesh Raithatha <praithatha@nvidia.com>

On 02/20/2013 11:35 AM, Rhyland Klein wrote:
> The structs wrapped with the SOC ifdefs are small enough where having
> them always there shouldn't be a big overhead. Removing the ifdefs
> also makes the code a little cleaner.

Patch 3 and 4 to the MMC driver look fine. But I'd ask Chris to hold off
on applying them for 3.10 until I've sorted out the dependencies of
Joseph Lo's MMC patches; if I can get the device tree fix for the CD
GPIO polarity into 3.9/stable as a bug-fix, there will be no dependency
issue I think. Otherwise, I'll probably want to take all the Tegra SDHCI
changes through the Tegra tree for 3.10 to resolve the dependencies.
