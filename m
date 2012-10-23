From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] ARM: dt: tegra: Add sdhci regulators
Date: Tue, 23 Oct 2012 10:21:43 -0600
Message-ID: <5086C417.102@wwwdotorg.org>
References: <1350976709-19248-1-git-send-email-pkunapuli@nvidia.com> <1350976709-19248-2-git-send-email-pkunapuli@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44130 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab2JWQVq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Oct 2012 12:21:46 -0400
In-Reply-To: <1350976709-19248-2-git-send-email-pkunapuli@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavan Kunapuli <pkunapuli@nvidia.com>
Cc: linux@arm.linux.org.uk, cjb@laptop.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 10/23/2012 01:18 AM, Pavan Kunapuli wrote:
> Adding vmmc and vmmcq supplies for sdhci nodes
> in tegra dt files.

As I already mentioned downstream, this patch is invalid because it will
cause runtime failures if applied before the second patch in this
series. Please see the more detailed explanation I sent downstream.
