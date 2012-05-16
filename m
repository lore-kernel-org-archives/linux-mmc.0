From: <ludovic.desroches@atmel.com>
Subject: [PATCH 0/4] mmc: atmel-mci: add support for old mci IPs
Date: Wed, 16 May 2012 15:25:57 +0200
Message-ID: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:51033 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966086Ab2EPN0S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 May 2012 09:26:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com

This set of patches is an extra step to remove at91-mci dirver which is mainly
used for old chips having mci IPs whose version is lesser than v2xx (rm9200
and 9261).
Since it introduces many changes and there was a lack of logs to help people
when there is an issue with atmel-mci driver, I added some debug logs.

These changes have been tested on at91rm9200, at91sam9261, at91sam9263,
at91sam9g10 and at91sam9g45.


Regards

Ludovic

