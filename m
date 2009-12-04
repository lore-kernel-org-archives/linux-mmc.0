From: r66093@freescale.com
Subject: [PATCH 0/3] MMC/SD: Add the callback get_cd to dtect the card
Date: Fri,  4 Dec 2009 15:54:12 +0800
Message-ID: <1259913252-25021-1-git-send-email-r66093@freescale.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:63065 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbZLDH4p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2009 02:56:45 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id nB47uqjP012358
	for <linux-mmc@vger.kernel.org>; Fri, 4 Dec 2009 00:56:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nB480pba028528
	for <linux-mmc@vger.kernel.org>; Fri, 4 Dec 2009 02:00:52 -0600 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

The following patch is to detect if the card has been removed or the card is present through the callback 'get_cd', which will reduce many interrupt to check the SD/MMC/ card.
