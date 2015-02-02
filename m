From: =?UTF-8?B?U8OpYmFzdGllbiBCb3VyZGVhdWR1Y3E=?= <sb@m-labs.hk>
Subject: "Timeout waiting for hardware interrupt" on Lenovo Thinkpad Tablet
 10
Date: Mon, 02 Feb 2015 20:29:51 +0800
Message-ID: <54CF6DBF.4080404@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:38026 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbbBBMmK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 07:42:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by ssl.serverraum.org (Postfix) with ESMTP id 382A63F12F
	for <linux-mmc@vger.kernel.org>; Mon,  2 Feb 2015 13:34:53 +0100 (CET)
Received: from ssl.serverraum.org ([127.0.0.1])
	by localhost (ssl.serverraum.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cim7wZaLmQ2r for <linux-mmc@vger.kernel.org>;
	Mon,  2 Feb 2015 13:34:53 +0100 (CET)
Received: from [192.168.0.14] (123202036015.ctinets.com [123.202.36.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ssl.serverraum.org (Postfix) with ESMTPSA id 4E1973F12E
	for <linux-mmc@vger.kernel.org>; Mon,  2 Feb 2015 13:34:51 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

Under Linux, the most annoying problem that the Lenovo Thinkpad Tablet
10 has is the unreliable eMMC.

I intermittently get an error "mmc0: Timeout waiting for hardware
interrupt" followed by a crash of the machine (when the eMMC is used as
rootfs).

I have been able to work around this issue with kernel 3.13.0 by passin=
g
the debug_quirks2=3D0xc0 option to the sdhci module, which disables the
HS200 and DDR50 transfer modes. The read data rate (as measured by
hdparm -t) drops from 119MB/s to 42MB/s, but at least the computer no
longer crashes every 20 minutes and my files are not corrupted anymore.

Unfortunately, with more recent kernels such as 3.18.4, the sdhci modul=
e
(still with debug_quirks2=3D0xc0) appears to select another problematic
transfer mode. The read data rate jumps to 65MB/s and the bug manifests
itself again.

What changes in sdhci between 3.13.0 and 3.18.4 could cause that? I'd
like to be able to use the eMMC reliably at least at 42MB/s using recen=
t
kernels, which hopefully will introduce fixes for the gazillion other
problems that this crippled machine has under Linux (absolutely nothing
works correctly except the CPU, display and USB).

Thanks,
S=C3=A9bastien
