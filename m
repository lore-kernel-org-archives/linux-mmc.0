From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/2] mmc: zboot helpers
Date: Thu, 24 Mar 2011 15:54:06 +0900
Message-ID: <1300949648-15078-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47433 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845Ab1CXGyR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2011 02:54:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: vger.kernel.org@vergenet.net, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>

Hi Paul,

please consider merging the following two patches.
They are both pre-requisites for
"mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM"
which I plan to submit to Russell King.

These patches were originally submitted in a for patch series
however they do not depend on any of the other patches in the series
so I am posting them independently.

These patches apply against Linus's current tree
and I am not aware of any particular prerequisites for them
other than that the 2nd patch depends on the 1st one.

