From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [mmc-utils] a little eMMC 5.0 support
Date: Thu,  5 Mar 2015 14:19:22 +0100
Message-ID: <1425561565-24806-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49807 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbCENTc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:19:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

#1 enables read_extcsd on Hynix which claims to be a eMMC 5.0
   commpatible device.
#3 adds a few fields.

Sebastian

