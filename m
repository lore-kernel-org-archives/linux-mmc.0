From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: sh mmcif cleanups
Date: Tue,  1 Apr 2014 13:01:40 +0100
Message-ID: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47295 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751332AbaDAMBu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 08:01:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk

This is a second round of the mmcif cleanups

Changes since v1:

	- fix issues with devm_ioremap return, and error printing
	- change the initial print
	- fix issue with disabling clock

