From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/4] ARM: tegra: add SDHCI support for Dalmore
Date: Wed, 20 Feb 2013 12:07:31 -0700
Message-ID: <51251EF3.4050901@wwwdotorg.org>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com> <1361385317-6020-3-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34815 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759101Ab3BTTHe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Feb 2013 14:07:34 -0500
In-Reply-To: <1361385317-6020-3-git-send-email-rklein@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Chris Ball <cjb@laptop.org>, linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, Pritesh Raithatha <praithatha@nvidia.com>

On 02/20/2013 11:35 AM, Rhyland Klein wrote:
> Based on changes by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>

A patch description would be useful here. Something simple like:

Dalmore has a built-in eMMC device and a user-accessible SD card slot.
Add device tree nodes to enable these.

The same rebasing comment will apply here too.
