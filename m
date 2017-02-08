From: Hartley Sweeten <HartleyS@visionengravers.com>
Subject: mmc_spi dependancy
Date: Wed, 8 Feb 2017 22:37:40 +0000
Message-ID: <SN1PR0101MB15655A022662B3A24C7EE419D0420@SN1PR0101MB1565.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:45291
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751916AbdBHWhn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Feb 2017 17:37:43 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>

Hello all,

Question, why does the mmc_spi driver have a !HIGHMEM dependency?

Regards,
Hartley

