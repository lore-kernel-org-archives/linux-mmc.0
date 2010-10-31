From: Daniel Drake <dsd@laptop.org>
Subject: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 14:29:10 +0000
Message-ID: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33173 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab0JaO3N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 10:29:13 -0400
Received: by wyf28 with SMTP id 28so4661205wyf.19
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 07:29:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org

Hi,

I'm running linus master and can't load the libertas module for the
sd8686 wifi hardware in the OLPC XO-1.5 laptop.
Probe fails with -16.

dmesg and config:
http://dev.laptop.org/~dsd/20101031/dmesg-sdio-probe-fail.txt
http://dev.laptop.org/~dsd/20101031/config-sdio-probe-fail.txt

I've done some initial investigation; in sdio_bus_probe() we do this:
	ret = pm_runtime_get_sync(dev);
	if (ret < 0)
		goto out;

and pm_runtime_get_sync() returns -16

Daniel
