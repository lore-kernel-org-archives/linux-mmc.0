From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [rfc] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Mon, 14 Mar 2011 10:28:18 +0900
Message-ID: <20110314012802.GD15317@verge.net.au>
References: <1299743892-3668-1-git-send-email-horms@verge.net.au>
 <AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
 <20110310084158.GB6508@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:59670 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747Ab1CNB2Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 21:28:25 -0400
Content-Disposition: inline
In-Reply-To: <20110310084158.GB6508@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Magnus,

are the following also sh7372 specific?

#define SDHI1_BASE              (void __iomem *)0xe6860000
#define SDHI_BASE                SDHI1_BASE

