From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: r8a7793/gose: enable SDHI
Date: Mon, 18 Apr 2016 18:02:55 +0200
Message-ID: <1460995377-11478-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35361 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbcDRQDF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 12:03:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

This enables SDHI on the Gose board, including pins and regulators.

This revision includes the missing dma-names and power-domains entries
spotted by Sergei and Simon.

CU
Uli


Ulrich Hecht (2):
  ARM: dts: r8a7793: Add SDHI controllers
  ARM: dts: gose: Enable SDHI controllers

 arch/arm/boot/dts/r8a7793-gose.dts | 119 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     |  36 +++++++++++
 2 files changed, 155 insertions(+)

-- 
2.7.4

