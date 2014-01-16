From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix dw_mci_get_cd
Date: Thu, 16 Jan 2014 11:50:33 +0100
Message-ID: <201401161150.34258.arnd@arndb.de>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57081 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbaAPKuo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 05:50:44 -0500
In-Reply-To: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>, Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thursday 16 January 2014, Zhangfei Gao wrote:
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -73,6 +73,8 @@ Optional properties:
>  
>  * caps2-mmc-hs200-1_2v: Supports mmc HS200 SDR 1.2V mode
>  
> +* caps2-mmc-cd-active-high: cd pin is high when card present
> +
>  * broken-cd: as documented in mmc core bindings.
>  
>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is

No, don't introduce a new flag when there is already one defined
in the generic mmc binding.

	Arnd
