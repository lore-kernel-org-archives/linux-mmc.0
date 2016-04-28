From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/4] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Thu, 28 Apr 2016 16:40:38 -0500
Message-ID: <20160428214038.GA32220@rob-hp-laptop>
References: <cover.1461770066.git.larper@axis.com>
 <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461770066.git.larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60419 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330AbcD1Vko (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2016 17:40:44 -0400
Content-Disposition: inline
In-Reply-To: <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461770066.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, g.liakhovetski@gmx.de, ulf.hansson@linaro.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

On Wed, Apr 27, 2016 at 05:21:26PM +0200, Lars Persson wrote:
> Add a pinctrl binding to specify different pin settings for high speed
> modes and UHS modes.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
