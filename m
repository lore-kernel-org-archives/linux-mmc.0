From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Wed, 3 Feb 2016 08:20:36 +0100
Message-ID: <56B1AA44.1010108@xilinx.com>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com ([104.47.36.52]:23587
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933155AbcBCHUw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Feb 2016 02:20:52 -0500
In-Reply-To: <56B166F1.5080605@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com

Hi,

On 3.2.2016 03:33, Shawn Lin wrote:
> + Michal, S=F6ren Brinkmann
>=20
> On 2016/2/2 17:49, Mason wrote:
>> Hello everyone,
>>
>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt states:
>>
>> Required Properties:
>>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' o=
r
>>                  'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>>
>> What do 8.9a, 4.9a, and 5.1 refer to?
>>
>=20
> Good question.
>=20
> Michal told me that 8.9a and 4.9a came from Xilinx
> databook which define their available arasan controller to be version
> 4.9a and 8.9a.

Our version is coming from here.
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000=
-TRM.pdf
page 28

Datasheets from 2012 and 2010 doesn't look too recent and I expect that
Arasan did a lot of work from that time that's why I am not surprised
that you are not able to see that versions.

Thanks,
Michal

