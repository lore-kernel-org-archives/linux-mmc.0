From: Simon Horman <horms@verge.net.au>
Subject: [PATCH v6] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
Date: Wed, 30 Mar 2011 11:59:14 +0900
Message-ID: <1301453955-15759-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58259 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab1C3C71 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 22:59:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>

Hi Magnus,

could I get an Ack or otherwise from you on this change?
All the pre-requisites are in 2.6.39-rc1.

Note that if you are inclined to build a 2.6.39-rc1 kernel for mackerel you
will also need "sh: intc: fix build error in interrupts.h"
(https://patchwork.kernel.org/patch/672972/) or similar.  That change is
unrelated to my work.

