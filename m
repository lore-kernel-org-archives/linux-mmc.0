From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Wed, 3 Feb 2016 10:33:21 +0800
Message-ID: <56B166F1.5080605@rock-chips.com>
References: <56B07BA5.4060407@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:43924 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458AbcBCCd2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 21:33:28 -0500
In-Reply-To: <56B07BA5.4060407@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com

+ Michal, S=F6ren Brinkmann

On 2016/2/2 17:49, Mason wrote:
> Hello everyone,
>
> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt states:
>
> Required Properties:
>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>                  'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>
> What do 8.9a, 4.9a, and 5.1 refer to?
>

Good question.

Michal told me that 8.9a and 4.9a came from Xilinx
databook which define their available arasan controller to be version
4.9a and 8.9a.

5.1 refer to the lastest arasan controller version which supports
emmc standard 5.1+(with a command queue engine and enhanced-strobe=20
function inside)

I not 100% sure how arasan folks define these versions or just
vendor define it themself in thire databook. But, something need to
be done to clarify these vague definitions.

Hello, Michal and Soren,

Could you elaborate more? :)

> $ git ls Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> da795ec26e25 mmc: sdhci-of-arasan: Add the support for sdhci-5.1
> 308f3f8d8112 mmc: sdhci-of-arasan: Add the support for sdhci-arasan4.=
9a
> e3ec3a3d11ad mmc: arasan: Add driver for Arasan SDHCI
>
>
> I found two Arasan data sheets.
>
> The first data sheet, created 2010-02-19, is titled
> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
> and the documentation revision number is 6.0
>

----8<------------

>
> The second data sheet, created 2012-09-07, is titled
> "SD3.0 / SDIO3.0/ eMMC4.5 Host Controller"
> and the documentation revision number is 1.13
>
> Revision history mentions a "new architecture" for rev 1.0
> in 2011-06-01
>
>
> Neither of these data sheets mention anything about a 4.9a or 8.9a
> version of the controller... And I don't think 5.1 refers to the
> documentation rev, right?
>
> So what do 8.9a, 4.9a, and 5.1 refer to?
>
> Regards.
>
>
>


--=20
Best Regards
Shawn Lin

