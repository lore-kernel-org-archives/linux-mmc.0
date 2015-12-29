From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] mmc-host: Fine-tuning for one function
Date: Tue, 29 Dec 2015 21:57:16 +0100
Message-ID: <5682F3AC.7050107@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:55968 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbbL2U5W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Dec 2015 15:57:22 -0500
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Sascha Sommer <saschasommer@freenet.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 29 Dec 2015 21:54:14 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete unnecessary variable initialisations in sdricoh_init_mmc()
  Less checks in sdricoh_init_mmc() after error detection

 drivers/mmc/host/sdricoh_cs.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
2.6.3

