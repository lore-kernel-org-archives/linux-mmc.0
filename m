From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/2] [rfc] mmc, sh: Read MMCIF during zboot
Date: Sat, 27 Nov 2010 08:05:55 +0900
Message-ID: <1290812757-20571-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42921 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab0KZXGN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Nov 2010 18:06:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>

The first patch of this short series prototype of code to read MMC during
zboot on AP4EV boards.

The second patch is a hack to allow it to be tested from uboot.

