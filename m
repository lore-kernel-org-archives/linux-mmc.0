From: Tushar Behera <trblinux@gmail.com>
Subject: Re: [PATCHv5 2/2] ARM: dts: unuse the slot-node and deprecated supports-highspeed
 for dw-mmc.
Date: Thu, 05 Jun 2014 10:18:52 +0530
Message-ID: <538FF6B4.7090609@gmail.com>
References: <1401943439-8146-1-git-send-email-jh80.chung@samsung.com> <1401943439-8146-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:35742 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbaFEEs6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 00:48:58 -0400
In-Reply-To: <1401943439-8146-3-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, mark.rutland@arm.com, tushar.behera@linaro.org

On 06/05/2014 10:13 AM, Jaehoon Chung wrote:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog V5:
> 	- Fix typo.
> Changelog V4:
> 	- Remove the slot-node.
> 	- Rename Subject.
> 		"[PATCHv3 4/4]ARM: dts: replace the slot property into slot sub-node for dwmmc"
> Changelog V3:
> 	- Merge "[PATCH 2/5] mmc: dw_mmc: rmove the "supports-highspeed" property"
> Changelog V2:
> 	- None
> 
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++--------
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++-----
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++-----

For the documentation changes,
Reviewed-by: Tushar Behera <trblinux@gmail.com>

-- 
Tushar Behera
