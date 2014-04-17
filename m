From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: eMMC 4.2 controller vs. eMMC 4.5 memory
Date: Thu, 17 Apr 2014 09:23:34 +0200
Message-ID: <OF7C51E6D0.060CAE3E-ONC1257CBD.0028048A-C1257CBD.00289C50@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:58477 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbaDQHdz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Apr 2014 03:33:55 -0400
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
	by gw1.transmode.se (Postfix) with ESMTP id E8B604841D6
	for <linux-mmc@vger.kernel.org>; Thu, 17 Apr 2014 09:23:34 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

We got a P2041 Freescale CPU with a built in MMC controller(eSDHC) 
conforming to MMC version 4.2 but
we would like use the some features from a 4.5 eMMC memory(reliable write, 
discard etc.).

What 4.5 features, if any, can I use in a 4.2 eMMC controller?

 Jocke
