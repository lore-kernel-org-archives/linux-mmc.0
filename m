From: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH] mmc: tegra: convert to device tree support only
Date: Fri, 24 Aug 2012 09:40:33 +0800
Message-ID: <1345772433.5081.1.camel@jlo-ubuntu-64.nvidia.com>
References: <1345187071-6619-1-git-send-email-josephl@nvidia.com>
	 <502E950B.2010205@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18325 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab2HXBkm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 21:40:42 -0400
In-Reply-To: <502E950B.2010205@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, 2012-08-18 at 03:01 +0800, Stephen Warren wrote:
> On 08/17/2012 01:04 AM, Joseph Lo wrote:
> > When compiling a kernel that supports only Tegra30 and not Tegra20,
> > the SDHCI driver will fail to compile since the of_match_device() failure
> > fallback code unconditinally references soc_data_tegra20, which is only
> > compiled in when Tegra20 support is enabled.
> > 
> > In Kernel 3.7, both Tegra20 and Tegra30 will only support booting using
> > device tree, Hence, there is never a need to fall back to using
> > soc_data_tegra20 if of_mach_device() fails. Instead, make this case an
> > error. This removes the reference to soc_data_tegra20, and hence solves
> > the compile failure.
> 
> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> (built and tested both Tegra20-only and Tegr30-only kernels with this
> applied on top of next-20120816).

Ping.

Could anyone help to review this?
Thanks.


