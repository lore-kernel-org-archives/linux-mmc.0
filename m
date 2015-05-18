From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2, 1/2] powerpc/dts: add eSDHC compatible list
Date: Mon, 18 May 2015 14:14:22 -0500
Message-ID: <1431976462.27761.0.camel@freescale.com>
References: <1431657962-42443-1-git-send-email-yangbo.lu@freescale.com>
	 <1431735910.3868.213.camel@freescale.com>
	 <CAPDyKFrFdnnq6esR-JPB30sPnT_DZAUvgP9_3rN8O6A9f+8Hpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0113.outbound.protection.outlook.com ([157.56.110.113]:23062
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964781AbbERTra (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 May 2015 15:47:30 -0400
In-Reply-To: <CAPDyKFrFdnnq6esR-JPB30sPnT_DZAUvgP9_3rN8O6A9f+8Hpw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On Mon, 2015-05-18 at 11:03 +0200, Ulf Hansson wrote:
> On 16 May 2015 at 02:25, Scott Wood <scottwood@freescale.com> wrote:
> > On Fri, 2015-05-15 at 10:46 +0800, Yangbo Lu wrote:
> >> Add eSDHC compatible list for P2041/P3041/P4080/P5020/P5040.
> >>
> >> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> >> ---
> >>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
> >>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
> >>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
> >>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
> >>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
> >>  5 files changed, 5 insertions(+)
> >
> > Acked-by: Scott Wood <scottwood@freescale.com>
> >
> > -Scott
> 
> Hi Scott,
> 
> Does the above ack mean you want me to pick up and take it through my mmc tree?

That'd be fine.

-Scott


