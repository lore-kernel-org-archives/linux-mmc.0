From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 1/2] mmc: sdhci: dt: Add device tree property
 sdhci-cap-speed-modes-broken
Date: Wed, 26 Oct 2016 16:03:46 -0500
Message-ID: <20161026210346.v3aj4fuuryngc52w@rob-hp-laptop>
References: <1476824736-9337-1-git-send-email-zach.brown@ni.com>
 <1476824736-9337-2-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36132 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbcJZVDs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2016 17:03:48 -0400
Content-Disposition: inline
In-Reply-To: <1476824736-9337-2-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 18, 2016 at 04:05:35PM -0500, Zach Brown wrote:
> On some systems the sdhci capabilty registers are incorrect for one
> reason or another.
> 
> The sdhci-cap-speed-modes-broken property will let the driver know that
> the sdhci capability registers should not be relied on for speed modes.
> Instead the driver should check the mmc generic DT bindings.
> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
