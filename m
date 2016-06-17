From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [V3] mmc: mmci: add missing include of mmci_qcom_dml.h
Date: Fri, 17 Jun 2016 13:41:19 +0200
Message-ID: <4881149.p2gsOpsjH3@wuerfel>
References: <1466102852-10063-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:64731 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcFQLj6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2016 07:39:58 -0400
In-Reply-To: <1466102852-10063-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Thursday, June 16, 2016 7:47:32 PM CEST Ben Dooks wrote:

> Note, since this is a very small addition to the mmci
> module, it would better to build it into the main mmci
> driver (either by direct copy, or multiple linked
> module)

I suspect the latter is actually what the author intended,
except they accidentally made the symbol tristate and got the
Makefile logic wrong.

Most likely, the qcom developers never considered the case
of having loadable modules.

	Arnd
