From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: direct dependencies (MISC_DEVICES && EXPERIMENTAL && PCI)
Date: Mon, 27 Dec 2010 13:46:50 +0100
Message-ID: <201012271346.51610.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:33806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753662Ab0L0Mqz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2010 07:46:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Dubov <oakad@yahoo.com>
Cc: linux-mmc@vger.kernel.org

Hello,

a "make randconfig 1>/dev/null" gave today :

warning: (MMC_TIFM_SD && MMC && EXPERIMENTAL && PCI || MEMSTICK_TIFM_MS=
 && MEMSTICK && EXPERIMENTAL && PCI) selects TIFM_CORE which=20
has unmet direct dependencies (MISC_DEVICES && EXPERIMENTAL && PCI)

for the current git kernel sources.
Is this an already known issue ?

--=20
MfG/Kind regards
Toralf F=C3=B6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

