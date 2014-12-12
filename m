From: Bastien Nocera <hadess@hadess.net>
Subject: Disabling PM fixes Wi-Fi stability
Date: Fri, 12 Dec 2014 11:51:33 +0100
Message-ID: <1418381493.3172.26.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38816 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966102AbaLLKwg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Dec 2014 05:52:36 -0500
Received: from mfilter37-d.gandi.net (mfilter37-d.gandi.net [217.70.178.168])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 4E2E8FB89E
	for <linux-mmc@vger.kernel.org>; Fri, 12 Dec 2014 11:52:35 +0100 (CET)
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
	by mfilter37-d.gandi.net (mfilter37-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id in4isYmNlkfq for <linux-mmc@vger.kernel.org>;
	Fri, 12 Dec 2014 11:52:33 +0100 (CET)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CCB05FB8A4
	for <linux-mmc@vger.kernel.org>; Fri, 12 Dec 2014 11:52:33 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hey,

On my Onda v975w tablet[1], using a non-upstreamed Realtek driver[2], I
used to have the tablet hang after using Wi-Fi for a couple of minutes.

I unfortunately couldn't get any stacktraces of the hang. I suspected
Power Management in the SDHCI-ACPI driver to be a problem, as the Wi-Fi
chipset hangs off SDIO.

Using this horror of a patch:
https://gist.github.com/hadess/6ce1b1c5dc8f5468d9dc
Wi-Fi becomes stable enough to be used.

Is this an SDHCI bug? an ACPI bug? A driver bug?

If the machine was a desktop, I probably wouldn't care much about the
lack of Power Management, but on a tablet...

Cheers

[1]: A Baytrail tablet
https://wiki.gnome.org/BastienNocera/Ondav975w
[2]: https://github.com/hadess/rtl8723as

