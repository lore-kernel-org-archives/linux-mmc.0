From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/3] mmc_test: add some tests
Date: Tue,  8 Feb 2011 13:41:00 +0200
Message-ID: <1297165263-656-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:51033 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab1BHLla (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Feb 2011 06:41:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

Hi

Here are a couple of new performance tests for mmc-test.

Adrian Hunter (3):
      mmc_test: make performance test area size about 4MiB
      mmc_test: add tests to measure random I/O operations per second
      mmc_test: add tests to measure large sequential I/O performance

 drivers/mmc/card/mmc_test.c |  264 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 241 insertions(+), 23 deletions(-)

Regards
Adrian
