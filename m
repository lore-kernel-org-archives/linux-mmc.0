From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/85xx: add 'cpu-rev' property for cpus node
Date: Fri, 24 Jul 2015 21:24:36 -0500
Message-ID: <1437791076.2993.265.camel@freescale.com>
References: <1437471923-34172-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0109.outbound.protection.outlook.com ([157.56.110.109]:13324
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753030AbbGYCYq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Jul 2015 22:24:46 -0400
In-Reply-To: <1437471923-34172-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

On Tue, 2015-07-21 at 17:45 +0800, Yangbo Lu wrote:
> Add 'cpu-rev' property for cpus node to support getting cpu revision
> from dts, since it's not good to get cpu revision using powerpc specific
> function(like SVR_REV()) in common drivers.

No.  Don't modify the device tree within Linux without a really good reason 
(e.g. platform code to fix up a broken device tree).

Why not just read SVR from guts, which works on both PPC and ARM?

-Scott

