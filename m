From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/5] CB710 driver updates
Date: Wed, 13 Oct 2010 00:22:13 +0200
Message-ID: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:40167 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131Ab0JLWwS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Oct 2010 18:52:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

This series consists of some updates for CB710 MMC host driver.

Micha=C5=82 Miros=C5=82aw (5):
  mmc: cb710: partially demystify clock selection
  mmc: cb710: implement get_cd() callback
  mmc: cb710: remove unnecessary msleep()
  mmc: cb710: clear irq handler on init() error path
  mmc: cb710: remove debugging printk (info duplicated from mmc-core)

 drivers/mmc/host/cb710-mmc.c |   54 +++++++++++++++++++---------------=
-------
 1 files changed, 25 insertions(+), 29 deletions(-)
