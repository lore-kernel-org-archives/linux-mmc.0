From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/2] ARM: dts: r8a7793/gose: enable SDHI
Date: Wed, 16 Mar 2016 18:11:35 +0100
Message-ID: <1458148297-22159-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34819 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934332AbcCPRLm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 13:11:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

This enables SDHI on the Gose board, including pins and regulators.

CU
Uli


Ulrich Hecht (2):
  ARM: dts: r8a7793: Add SDHI controllers
  ARM: dts: gose: Enable SDHI controllers

 arch/arm/boot/dts/r8a7793-gose.dts | 119 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     |  33 ++++++++++
 2 files changed, 152 insertions(+)

-- 
2.6.4

