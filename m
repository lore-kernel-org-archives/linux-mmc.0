From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: A serial patchs that support FSL's eSDHC
Date: Thu, 2 Sep 2010 18:06:16 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA078545@zch01exm22.fsl.freescale.net>
References: <1283334305-12453-1-git-send-email-r65037@freescale.com>
	<20100901101500.GE11407@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20100901101500.GE11407@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram:
Thanks for your comments.
I would change the patches and resend them later.

Best Regards,
Richard Zhu
Freescale Semiconductor
Tel: +86-021-28937189
Email:Hong-Xing.Zhu@freescale.com 


-----Original Message-----
From: Wolfram Sang [mailto:w.sang@pengutronix.de] 
Sent: Wednesday, 1 September, 2010 18:15
To: Zhu Richard-R65037
Cc: linux-mmc@vger.kernel.org; kernel@pengutronix.de;
linux-arm-kernel@lists.infradead.org
Subject: Re: A serial patchs that support FSL's eSDHC

On Wed, Sep 01, 2010 at 05:45:04PM +0800, Richard Zhu wrote:

> Can you help me to review the following serial patchs, that enable the

> sdhci driver to support FSL's eSDHC on i.MX family.

I see two major problems: First, you often modify sdhci.c to work around
the hardware-quirks. See sdhci-of-esdhc.c how it can be handled in a
seperate source-file and keep sdhci.c clean. (While at it, what is
common between the of-driver and the platform-driver should be shared).
Second, your platform-driver is a complete one, but we have a platform
core meanwhile (sdhci-pltfm.c). Please use that.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang
|
Industrial Linux Solutions                 | http://www.pengutronix.de/
|
