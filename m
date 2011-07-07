From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-pltfm: dt device does not pass parent
 to sdhci_alloc_host
Date: Thu, 07 Jul 2011 15:33:15 +0400
Message-ID: <4E15997B.6080804@mvista.com>
References: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org> <1309879568-25837-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:56052 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab1GGLe0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 07:34:26 -0400
Received: by fxd18 with SMTP id 18so1000983fxd.11
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2011 04:34:25 -0700 (PDT)
In-Reply-To: <1309879568-25837-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hello.

On 05-07-2011 19:26, Shawn Guo wrote:

> Neither platform based nor dt based device needs to pass the parent
> to sdhci_alloc_host.  There is no difference between platform and dt
> on this point.

> The patch makes the change to pass device itself than its parent to

    Maybe "rather than"?

> sdhci_alloc_host for dt case too.  Otherwise the probe function of
> sdhci based drivers which is shared between platform and dt will
> fail on dt case.

> Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> Acked-by: Grant Likely<grant.likely@secretlab.ca>
> Cc: Chris Ball<cjb@laptop.org>

WBR, Sergei
