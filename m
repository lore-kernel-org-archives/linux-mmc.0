From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Initial signal voltage ?
Date: Mon, 10 Aug 2015 16:50:38 +0000
Message-ID: <1439225438.3120.94.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:50324 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbbHJQul convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2015 12:50:41 -0400
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
	by smtp.transmode.se (Postfix) with ESMTP id 49A661186FB8
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2015 18:50:39 +0200 (CEST)
Content-Language: en-US
Content-ID: <D9AA92828BDB4B46A21649985AC28CE2@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

in mmc_power_up() we have:
	/* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
	if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
		dev_err(mmc_dev(host), "Initial signal voltage of 3.3v\n");
	else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) == 0)
		dev_err(mmc_dev(host), "Initial signal voltage of 1.8v\n");
	else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120) == 0)
		dev_err(mmc_dev(host), "Initial signal voltage of 1.2v\n");

Here one jut brutally tries to set the initial power to 3.3 but nowhere in
general code there is a check if the controller can handle this w.r.t
HOST CAPS.
Where should this check be performed, I am guessing either here or in sdhci?
This is all new to me so I am just throwing this out there

 Jocke