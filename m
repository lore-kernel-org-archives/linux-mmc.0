From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH v2] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri,  5 Jan 2018 16:13:50 +0100 (CET)
Message-ID: <OF516BA7ED.7F78F40A-ONC125820C.0052D43F-C125820C.0053AA04@rittal.de>
References: <20180105141535.17614-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:57117 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeAEPNw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 10:13:52 -0500
In-Reply-To: <20180105141535.17614-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>

That works!

Tested on i.mx25 architecture with sdhci-esdhc-imx driver.

Here are some time measurements.

#time dd if=/dev/zero of=test bs=1MB count=1
real	0m0.614s
user	0m0.000s
sys	0m0.132s

#time dd if=/dev/zero of=test bs=1MB count=4
real	0m1.328s
user	0m0.000s
sys	0m0.390s

#time dd if=/dev/zero of=test bs=1MB count=8 
real	0m3.922s
user	0m0.000s
sys	0m0.747s

#time dd if=/dev/zero of=test bs=1MB count=16
real	0m8.162s
user	0m0.009s
sys	0m1.419s

#time dd if=/dev/zero of=test bs=1MB count=32
real	0m15.725s
user	0m0.000s
sys	0m2.758s

Thanks for the help.

Kind regards,
Benjamin Beckmeyer
