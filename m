From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 0/3] mmc_test: show test results via sysfs
Date: Wed,  1 Sep 2010 09:26:44 +0300
Message-ID: <cover.1283276161.git.ext-andriy.shevchenko@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56413 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab0IAG0W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 02:26:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Adrian Hunter <adrian.hunter@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There is a patchset which brings possibility to get test results via sysfs. It
helps to do tests non-interactively.

Andy Shevchenko (3):
  mmc_test: use API to check card type
  mmc_test: change simple_strtol() to strict_strtol()
  mmc_test: collect data and show it via sysfs by demand

 drivers/mmc/card/mmc_test.c |  130 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 122 insertions(+), 8 deletions(-)

