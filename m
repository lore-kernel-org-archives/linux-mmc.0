From: Cliff Brake <cliff.brake@gmail.com>
Subject: SDIO port expander
Date: Wed, 12 Jan 2011 16:01:26 -0500
Message-ID: <AANLkTimfM02BHPfDX-zSKRH-kwr70_WyBdg+4veWE7cp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46055 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab1ALVCA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2011 16:02:00 -0500
Received: by wyb28 with SMTP id 28so1014739wyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jan 2011 13:01:58 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

Has anyone implement Linux support for a SDIO port expander such as
the TI TXS02612?  I'm wondering how painful it would be.  Particularly
the issue with SDIO interrupts--it seems those would need to be routed
around the mux directly to the CPU.  We are using a OMAP3530 for the
SD controller.

http://focus.ti.com/docs/prod/folders/print/txs02612.html

Thanks,
Cliff

-- 
=================
http://bec-systems.com
