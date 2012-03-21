From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/2] MMCIF Clock Fixes
Date: Wed, 21 Mar 2012 18:02:27 +0900
Message-ID: <1332320549-28584-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41240 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722Ab2CUJCl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 05:02:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

Hi,

the following two patches fix inaccuracies in the mmcif implementation
relating to treatment of the clock. They have been lightly tested and
they do not seem to result in any change in transfer speeds.

