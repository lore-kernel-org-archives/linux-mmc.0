From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Date: Mon, 9 May 2011 22:15:03 +0200
Message-ID: <20110509201503.GB21233@opensource.wolfsonmicro.com>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50429 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754372Ab1EIUO7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2011 16:14:59 -0400
Content-Disposition: inline
In-Reply-To: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, openezx-devel@lists.openezx.org, linux-arm-kernel@lists.infradead.org

On Mon, May 09, 2011 at 10:11:09PM +0200, Antonio Ospite wrote:
> Don't wrap regulator_get() inside an #ifdef CONFIG_REGULATOR anymore, as
> now (since be1a50d) it correctly degenerates and returns NULL when the
> regulator framework is disabled.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

But pleasse always include a plain text version of the commit
description for those who didn't memorise the entire git log.
