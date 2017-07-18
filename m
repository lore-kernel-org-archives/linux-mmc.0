From: Ian Molton <ian@mnementh.co.uk>
Subject: Remove !HIGHMEM from mmci-spi
Date: Tue, 18 Jul 2017 13:19:14 +0100
Message-ID: <20170718121915.23303-1-ian@mnementh.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [217.148.43.144] ([217.148.43.144]:51492 "EHLO mnementh.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751322AbdGRMT0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Jul 2017 08:19:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

Hi folks,

I cannot find anything to support the need for !HIGHMEM to be
set in this driver. Let's remove the dependency.

