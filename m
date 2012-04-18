From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V1] mmc: tegra: support SDHCI SPEC 300
Date: Wed, 18 Apr 2012 10:52:33 -0600
Message-ID: <4F8EF151.8050808@wwwdotorg.org>
References: <1334755082-26818-1-git-send-email-pkunapuli@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37793 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab2DRQwi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 12:52:38 -0400
In-Reply-To: <1334755082-26818-1-git-send-email-pkunapuli@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavan Kunapuli <pkunapuli@nvidia.com>
Cc: cjb@laptop.org, swarren@nvidia.com, paul.gortmaker@windriver.com, olof@lixom.net, rmk+kernel@arm.linux.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/18/2012 07:18 AM, Pavan Kunapuli wrote:
> Tegra3 SDHOST controller doesn't advertise
> v3.00 support by default. This support has to
> be enabled by configuring a vendor register in
> the tegra3 sd host address space.
> 
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>

FWIW,

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
