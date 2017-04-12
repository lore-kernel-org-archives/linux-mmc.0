From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH v13 0/6] Cavium MMC driver
Date: Wed, 12 Apr 2017 18:21:32 -0500
Message-ID: <44e49a3b-ec51-7318-f6c1-911712127ddb@cavium.com>
References: <20170330153128.22842-1-jglauber@cavium.com>
 <20170412223750.mcm62ns57uag6y7q@raspberrypi-3.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:48480
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752372AbdDLXVk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Apr 2017 19:21:40 -0400
In-Reply-To: <20170412223750.mcm62ns57uag6y7q@raspberrypi-3.musicnaut.iki.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Jan Glauber <jglauber@cavium.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/12/2017 05:37 PM, Aaro Koskinen wrote:
> 
> Please rather post a new version that also works with OCTEON. I don't
> think a partial driver should be merged; originally this driver was
> working fine with OCTEON so there should be no issue supporting that?!
>
Hey Aaro.

The difference is that Jan added scatter/gather support to take
advantage of the DMA FIFOs on Thunder. The same FIFOs exist on
Octeon parts 73xx, 76xx, 78xx, CNF73xx, and CNF75xx to name a
few. In order to support those, portions of the Octeon platform
code had to be rewritten as well as minor changes in the core
Cavium driver code. I have a fully tested patchset that cleanly
applies on top of Jan's v13 driver. My personal preference is
for the Octeon code to be a separate patch. I will defer that
decision to Jan, David and the MMC maintainers.

Steve
