From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Fri, 13 May 2016 11:32:33 +0900
Message-ID: <20160513023233.GE24529@verge.net.au>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <SG2PR06MB09190A986DDC6D2220603AA6D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33959 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcEMCcg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2016 22:32:36 -0400
Content-Disposition: inline
In-Reply-To: <SG2PR06MB09190A986DDC6D2220603AA6D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, May 12, 2016 at 06:30:04AM +0000, Yoshihiro Shimoda wrote:
> Hi Simon-san,
> 
> > From: Simon Horman
> > Sent: Tuesday, May 10, 2016 2:52 PM
> > 
> > Hi,
> > 
> > this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
> > sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
> > Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
> > SDR-50 support to the same driver.
> > 
> > This series enables UHS-I SDR-104 on the r8a7790/Lager where
> > UHS-I SDR-50 is already enabled.
> > 
> > It is based on a merge of:
> > * The next branch of the mmc tree
> > * The renesas-next-20160427v2-v4.6-rc1 tag of the renesas tree
> > * The sh-pfc-for-v4.7-tag1 tag of the renesas-drivers tree
> > 
> > The first two mmc driver patches are targeted at the next branch of the mmc
> > tree. The last DT patch is targeted at the devel branch of the renesas tree.
> > 
> > To aid review this series is provided in the _temporary_ topic/sdr104 branch
> > of the renesas tree.
> 
> Thank you for the patch set!
> I tried to the patch using the topic branch.
> 
> > A description of testing performed follows:
> > 
> > * Environment
> > 
> >   SoC/Board: r8a7790/Lager
> >   SanDisk Card: SanDisk Ultra 64Gb microSDXC UHS-1
> >                 Identifier on Packaging: SDSQUNC-064G-GN6MA
> >   Samsung Card: Samsung 32Gb microSDHC Card Class 10 UHS-1 U3
> >                 ModelCode: MB-MG32EA/FFP
> 
> I used r8a7790/Lager and the following card:
> 
>    SanDisk Card: SanDisk Extreme Pro 32Gb microSDHC U3
>    (Sorry I don't have the packaging because I borrowed it from my colleague.)

My car has some rather difficult to read information printed on the back.
We can compare that if you think it is useful.

> < Result >
> - It seems worked correctly.
> - I tried 3 Lager boards:
>  - One of board (No.701 / ES2.0) sometimes works correctly.
>   - " mmc1: tuning execution failed: -110" appeared.
>  - Other 2 boards (No.465 / ES2.0 and No.322 / ES3.0) always works correctly.
> 
> Perhaps the issue is related to hardware problem.

[...]

Some discussion of that followed. I'll leave that as a separate sub-thread.
