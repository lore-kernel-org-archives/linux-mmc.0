From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 0/7] mmc: sdhci/imx: a few clean up and fixes
Date: Wed, 3 Sep 2014 20:19:33 +0800
Message-ID: <20140903121929.GA31326@shlinux1.ap.freescale.net>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
 <CAOMZO5D8GaMTCnGo4iO+eKYr6xXx3iyN-9pyNMUT-0f-dv1+FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1lp0142.outbound.protection.outlook.com ([207.46.163.142]:13996
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932220AbaICMlF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Sep 2014 08:41:05 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5D8GaMTCnGo4iO+eKYr6xXx3iyN-9pyNMUT-0f-dv1+FQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 03, 2014 at 09:34:28AM -0300, Fabio Estevam wrote:
> Hi Dong,
> 
> On Wed, Sep 3, 2014 at 9:04 AM, Dong Aisheng <b29396@freescale.com> wrote:
> > A few clean up and fixes.
> 
> Usually it is a good idea to separate cleanup from fixes. Do any of
> the fixes should go to 3.17-rc or stable?
> 

Thanks for reminder.
Most are tiny fixes and clean up.
If to be strictly, Patch 3 mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
could go to stable although the issue is very very hard to reproduce as stated
in errata.

Regards
Dong Aisheng

> Regards,
> 
> Fabio Estevam
