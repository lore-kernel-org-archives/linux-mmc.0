From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Date: Mon, 9 May 2011 21:23:25 +0100
Message-ID: <20110509202325.GD16919@n2100.arm.linux.org.uk>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50504 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab1EIUXh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2011 16:23:37 -0400
Content-Disposition: inline
In-Reply-To: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-mmc@vger.kernel.org, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Mon, May 09, 2011 at 10:11:09PM +0200, Antonio Ospite wrote:
> Don't wrap regulator_get() inside an #ifdef CONFIG_REGULATOR anymore, as
> now (since be1a50d) it correctly degenerates and returns NULL when the
> regulator framework is disabled.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

NAK.  This has been proposed before, and rejected.  See the comments
against the original proposal:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6525/1
