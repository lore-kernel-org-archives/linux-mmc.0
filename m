From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] mmc: add the MMC/SD/SDIO Arasan host controller
Date: Wed, 28 Jul 2010 09:39:36 +0100
Message-ID: <4C4FECC8.9060101@csr.com>
References: <1280299127-3075-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from doppler.zen.co.uk ([212.23.3.27]:56087 "EHLO doppler.zen.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729Ab0G1IlJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Jul 2010 04:41:09 -0400
Received: from [212.23.3.140] (helo=smarthost01.mail.zen.net.uk)
	by doppler.zen.co.uk with esmtp (Exim 4.63)
	(envelope-from <david.vrabel@csr.com>)
	id 1Oe2CI-0007Ob-4F
	for linux-mmc@vger.kernel.org; Wed, 28 Jul 2010 08:41:06 +0000
In-Reply-To: <1280299127-3075-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

Giuseppe CAVALLARO wrote:
> This patch adds the MMC/SD/SDIO Arasan host controller.
> Advanced DMA, Single DMA and PIO modes are supported.
> The former is the default.

The Arasan IP is a Standard Host Controller so you should look at using
the existing sdhci driver.  The sdhci-s3c driver provides an an example
of how to do this.

David
