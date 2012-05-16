From: <ludovic.desroches@atmel.com>
Subject: [PATCH 0/2] ARM: at91: allow all boards to use atmel-mci driver
Date: Wed, 16 May 2012 17:51:57 +0200
Message-ID: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:19695 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab2EPPwd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 May 2012 11:52:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

This set of patches depends on 'mmc: atmel-mci: add support for old mci IPs'
which allows to use atmel-mci driver on all boards. So keeping at91-mci only
for old chips is no more necessary.
If there are no issues with this new atmel-mci driver, at91-mci driver will be
removed for 3.7 release.


Regards

Ludovic

