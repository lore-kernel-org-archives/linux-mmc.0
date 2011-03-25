From: "Tomoya MORINAGA" <tomoya-linux@dsn.okisemi.com>
Subject: RE: A MMC card transfer issue
Date: Fri, 25 Mar 2011 10:22:17 +0900
Message-ID: <74A77583FFF245F68480BC4467DB4028@hacdom.okisemi.com>
References: <4CD8DE9C.4040505@dsn.okisemi.com> <AANLkTimfnj8GcSwmALjaZUBsiq6ssaVuzVZZsZHRYmiX@mail.gmail.com> <001701cb814c$71926bf0$66f8800a@maildom.okisemi.com> <001201cb90f4$4be8f790$66f8800a@maildom.okisemi.com> <2D50F985-2383-4406-8514-DFE462A5F546@marvell.com> <4D2E0464ABB54FFF9C10583336E27879@hacdom.okisemi.com> <4C4E7DE5-7CF1-4D97-9CAD-F600FCBE477A@marvell.com> <20110119174233.GA30494@void.printf.net> <F6E8C422FB8A4D78A5BDF7B6ECDA1E00@hacdom.okisemi.com> <D8E7AFC5-6B9E-414E-81A8-292FCD2F6E3C@marvell.com> <629816F753974155B62FF8FA718A26CA@hacdom.okisemi.com> <6076934B-27C2-4766-B101-793C7447C71C@marvell.com> <0F933C1424BF45E3BD2E13358BD3C89E@hacdom.okisemi.com> <7BDF62B4-A11A-4CB4-9F80-F2206C2655F9@marvell.com> <A32C38D81702478B9AB8626F523E79BB@hacdom.okisemi.com> <0DBFCBB8-B4A3-46A
 6-A68D-14FAED451619@marvell.com> <9992F28C7C0C445E956D351E3774C821@hacdom.okisemi.com> <82CB4E44-6543-4578-ACE4-37850FC4A49A@marvell.com> <EE9384C765994E26857C78E3D3A19304@hacdom.okisemi.com
     > <AF584C10-A796
	-	43 5 B-8AB2-DA6D6C0E3FD7@marvell.com> <DE7D3AAF538943459079D18D0CE6ED44@hacdom.okisemi.com> <DDF13C55-A8A1-45C1-AE9A-A76754ED7008@marvell.com> <4425BB0054B748C68A25DD1DFBBB52A7@hacdom.okisemi.com> <5E1B7BBD-C96E-4CC0-B03B-ADCEB0120085@marvell.com> <0C438F11-132E-4639-820D-0E42EEDCD6E7@marvell.com> <671E3EC021E946A383C65F07A0101B27@hacdom.okisemi.com> <16706427-F00E-46F3-B0B4-9B7F06AD0E71@marvell.com> <5CBEE3CD-E95A-4657-8842-D87B5F1F9AC1@marvell.com>,<3032905B991B4B59ADF0239D4AB008C4@hacdom.okisemi.com> <43E4817426ED174AA81263BCECB4351D134716B99D@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sm-d311v.smileserver.ne.jp ([203.211.202.206]:40874 "EHLO
	sm-d311v.smileserver.ne.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755410Ab1CYBWU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2011 21:22:20 -0400
In-Reply-To: <43E4817426ED174AA81263BCECB4351D134716B99D@sc-vexch3.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Philip Rakity' <prakity@marvell.com>, 'Nicolas Pitre' <nico@fluxnic.net>
Cc: 'Toshiharu Okada' <toshiharu-linux@dsn.okisemi.com>, linux-mmc@vger.kernel.org, kok.howg.ewe@intel.com, "'Lai, Mee Sim'" <mee.sim.lai@intel.com>

Hi  Philip,

On Thursday, March 24, 2011 11:19 PM, Philip Rakity wrote:
> I think the solution is to try to rad the CSD if bus test 
> fails.  If CSD read fails then lower bus width until it 
> passes.  Not had time to work on this yet.  On my list of 
> things to do.
OK.
Do you have fixed schedule for this work ?
If yes, let me know the schedule.

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.

