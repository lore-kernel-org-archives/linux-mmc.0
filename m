From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: dt: Add device tree properties
 sdhci-caps and sdhci-caps-mask
Date: Mon, 31 Oct 2016 01:08:34 -0500
Message-ID: <20161031060834.wavxl7mhdxz5kgsv@rob-hp-laptop>
References: <1477670171-30015-1-git-send-email-zach.brown@ni.com>
 <1477670171-30015-2-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36795 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759688AbcJaGIr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2016 02:08:47 -0400
Content-Disposition: inline
In-Reply-To: <1477670171-30015-2-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 28, 2016 at 10:56:10AM -0500, Zach Brown wrote:
> On some systems the sdhci capabilty register is incorrect for one
> reason or another.
> 
> The sdhci-caps-mask property specifies which bits in the register
> are incorrect and should be turned off before using sdhci-caps to turn
> on bits.
> 
> The sdhci-caps property specifies which bits should be turned on.
> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt

Acked-by: Rob Herring <robh@kernel.org>
